import { Plane } from "@react-three/drei";
import { Vector3 } from "three";
import { useQuery } from "react-query";
import { API } from "../../../api/api";
import { isMobile } from "react-device-detect";

export const PlanetarySelectTile = ({ position }: { position: number[] }) => {
    const { data } = useQuery<Entity.Tile[]>({
        queryKey: "exhausted-tiles",
        queryFn: API.tiles.getAllExhausted,
        staleTime: Infinity
    });

    // Check if a similar item can be found in data
    const isSimilarItemFound = data?.some((tile: { x: number; y: number }) => {
        return tile.x == position[0] && tile.y == position[2];
    });

    const opacity = isSimilarItemFound || event?.type === 'ACTIONSMENU_SHOW' ? 0 : 0.5; // Set opacity to 0 if a similar item is found, otherwise set it to 0.5

    const tileOffset = 0.5; // Required to center in tile

    const offsetPosition = [position[0] + tileOffset, 0.0005, position[2] + tileOffset];

    return (
        <Plane
            position={new Vector3(...offsetPosition)}
            scale={0.97}
            rotation={[-Math.PI / 2, 0, 0]}
        >
            <meshBasicMaterial color={"white"} transparent opacity={isMobile ? 0 : opacity} />
        </Plane>
    );
};
