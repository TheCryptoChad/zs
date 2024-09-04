import { useMutation, useQuery } from "react-query";
import { API } from "../../../api/api";
import { Plane, Html } from "@react-three/drei";
import { useState } from "react";
import { useEventStore } from "../../../stores/useEventStore";
import { useVesselsStore } from "../../../stores/useVesselsStore";
import { ThreeEvent } from "@react-three/fiber";
import { queryClient } from "../../../main";
import { useToast } from "@chakra-ui/react";

export const PlanetaryExhaustedTiles = () => {
    const { selectedVessel, clearSelectedVessel } = useVesselsStore();
    const [hoveredTile, setHoveredTile] = useState<{ x: number; y: number } | null>(null);
    const { event, send } = useEventStore()
    const toast = useToast();

    const { mutate } = useMutation((newData: { vesselId: number; x: number; y: number }) => API.vessel.move(newData.vesselId, newData.x, newData.y), {
		onSuccess: () => {
			// Invalidate and refetch
			queryClient.invalidateQueries("vessels");
			send({ type: "VESSEL_FOLLOW", payload: selectedVessel?.position });
			clearSelectedVessel();
			queryClient.invalidateQueries("radar");
		},
		onError: (data) => {
			toast({
				title: "Error",
				description: (data as { message: string }).message,
				status: "error",
				duration: 5000,
				isClosable: true,
			});
		},
	});

    const handleTileHover = (x: number, y: number) => {
        setHoveredTile({ x, y });
    };

    const handleTileUnhover = () => {
        setHoveredTile(null);
    };

    const handleClick = async (event: ThreeEvent<MouseEvent>) => {
		const posX = Math.floor(event.point.x);
		const posY = Math.floor(event.point.z);

		if (selectedVessel) {
			const params = { vesselId: selectedVessel.id, x: posX, y: posY };
			mutate(params);
		}
	};

    const { data: userData } = useQuery({
        queryKey: 'user',
        queryFn: API.user.getSelf
    })

    const { data: vesselsData } = useQuery({
        enabled: !!userData?.address,
        queryKey: 'vessels',
        queryFn: API.vessel.getAll,
    })

    const { data: exhaustedTilesData } = useQuery<Entity.Tile[]>({
        queryKey: "exhausted-tiles",
        queryFn: API.tiles.getAllExhausted,
        enabled: event?.type === "ACTIONSMENU_MOVE"
    });

    if (!exhaustedTilesData || !vesselsData) return null; // Return null if data is not available yet

    const tileSize = 0.99; // Adjust this to make the tiles smaller

    const exhaustedTiles = exhaustedTilesData.map((tileData: { x: number; y: number }) => {
        const { x, y } = tileData;

        const vesselAtSamePosition = vesselsData.some(vessel => vessel.x === x && vessel.y === y);

        return (
            <group
                key={`${x}_${y}`}
                position={
                    [
                        Number(x) + 1,
                        0.0004,
                        Number(y) + 1
                    ]
                }>
                <Plane
                    position={[-0.5, 0, -0.5]}
                    rotation={[-Math.PI / 2, 0, 0]}
                    scale={[tileSize, tileSize, 1]}
                    onClick={(event) => handleClick(event)}
                    onPointerOver={() => handleTileHover(x, y)}
                    onPointerOut={handleTileUnhover}
                >
                    <meshBasicMaterial color={"orange"} transparent opacity={0.5} />
                </Plane>
                {
                    !vesselAtSamePosition && hoveredTile
                    && (hoveredTile.x === x && hoveredTile.y === y)
                    && (
                        <Html position={[0, 1, 0]} style={{ pointerEvents: "none" }}>
                            <div
                                style={{
                                    background: "#191919",
                                    color: "#0EEBA8",
                                    paddingTop: "2px",
                                    paddingBottom: "2px",
                                    paddingRight: "6px",
                                    paddingLeft: "6px",
                                    textTransform: "uppercase",
                                    fontFamily: "Orbitron",
                                    fontSize: "12px",
                                    letterSpacing: "1px",
                                    borderRadius: "2px"
                                }}>
                                Exhausted
                            </div>
                        </Html>
                    )}
            </group>
        );
    });

    return <>{exhaustedTiles}</>;
};
