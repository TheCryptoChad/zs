import { Plane, useTexture } from "@react-three/drei";
import { Vector3 } from "three";
import { useVesselsStore } from "../../../stores/useVesselsStore";
import { useEventStore } from "../../../stores/useEventStore";
import { ThreeEvent } from "@react-three/fiber";
import { API } from "../../../api/api";
import { useMutation, useQuery } from "react-query";
import { queryClient } from "../../../main";
import { useToast } from "@chakra-ui/react";

export const PlanetaryMoveZone = ({ position }: { position: Vector3 }) => {
	const { selectedVessel, clearSelectedVessel } = useVesselsStore();
	const { send } = useEventStore();
	const toast = useToast();

	const { data } = useQuery<Entity.Tile[]>({
		queryKey: "exhausted-tiles",
		queryFn: API.tiles.getAllExhausted,
	});

	const { data: radarData } = useQuery<{ type: number; x: number; y: number }[]>({
		queryKey: "radar",
		queryFn: () => API.tiles.radarScan(Number(selectedVessel?.id)),
	});

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

	const tileOffset = 0.5;

	const handleClick = async (event: ThreeEvent<MouseEvent>) => {
		const posX = Math.floor(event.point.x);
		const posY = Math.floor(event.point.z);

		if (selectedVessel) {
			const params = { vesselId: selectedVessel.id, x: posX, y: posY };
			mutate(params);
		}
	};

	const radarResult = (type: number) => {
		switch (type) {
			case 1:
				return useTexture("/tiles/tile_all.png");
			case 2:
				return useTexture("/tiles/tile_astralite.png");
			case 3:
				return useTexture("/tiles/tile_samarium.png");
			case 4:
				return useTexture("/tiles/tile_calamarite.png");
			case 5:
				return useTexture("/tiles/tile_astralite.png");
			case 6:
				return useTexture("/tiles/tile_samarium.png");
			case 7:
				return useTexture("/tiles/tile_calamarite.png");
		}
	};

	const gapSize = 0.01; // Adjust this to the size of the gap you want
	const tileSize = 0.99; // Adjust this to make the tiles smaller

	// Filter out the tiles that match the coordinates in data
	const filteredTiles = [];
	const range = selectedVessel?.range ?? 0
	console.log(selectedVessel)
	for (let dx = -range; dx <= range; dx++) {
		for (let dz = -range; dz <= range; dz++) {
			const proposedX = position.x + dx;
			const proposedZ = position.z + dz;

			if (Math.sqrt(dx * dx + dz * dz) <= range && proposedX >= 1 && proposedX <= 100 && proposedZ >= 1 && proposedZ <= 100) {
				const adjustedX = position.x + dx * (1 + gapSize);
				const adjustedZ = position.z + dz * (1 + gapSize);

				// Check if a similar item can be found in data
				const isSimilarItemFound = data?.some((tile: { x: number; y: number }) => tile.x == proposedX && tile.y == proposedZ);

				if (!isSimilarItemFound) {
					const tile = radarData?.find((tile: { type: number; x: number; y: number }) => tile.x == proposedX && tile.y == proposedZ);
					const texture = radarResult(tile?.type ? tile?.type : 1);
					if (!texture) return
					texture.flipY = false;
					filteredTiles.push(
						<Plane
							key={`${dx}_${dz}`}
							position={[adjustedX + tileOffset, 0.0004, adjustedZ + tileOffset]}
							rotation={[-Math.PI / 2, 0, 0]}
							onClick={(event) => handleClick(event)}
							scale={tileSize} // Apply scaling to make tiles smaller
						>
							{
								tile
									? <meshBasicMaterial transparent opacity={0.5} toneMapped={false} map={texture} />
									: <meshBasicMaterial color={"teal"} transparent opacity={0.5} />
							}
						</Plane>
					)
					texture.needsUpdate = true
				}
			}
		}
	}

	return <>{filteredTiles}</>;
};

useTexture.preload("/tiles/tile_all.png");
useTexture.preload("/tiles/tile_astralite.png");
useTexture.preload("/tiles/tile_samarium.png");
useTexture.preload("/tiles/tile_calamarite.png");