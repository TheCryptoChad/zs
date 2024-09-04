import { Plane } from "@react-three/drei";
import { useEffect, useState } from "react";
import { PlanetarySelectTile } from "./PlanetarySelectTile";
import { PlanetaryGround } from "./PlanetaryGround";
import { Vector3 } from "three";
import { useFrame, ThreeEvent } from "@react-three/fiber";
import { useEventStore } from "../../../stores/useEventStore";
import { PlanetaryMoveZone } from "./PlanetaryMoveZone";
import { PlanetaryExhaustedTiles } from "./PlanetaryExhaustedTiles";
import { isBrowser } from "react-device-detect";
import { useVesselsStore } from "../../../stores/useVesselsStore";

export const PlanetaryGrid = () => {
    const { event, send, clear } = useEventStore();
    const { vessels, selectedVessel, selectVessel, clearSelectedVessel } = useVesselsStore()

    const [hoverTile, setHoverTile] = useState<number[] | null>(null);
    const [isGoto, setIsGoto] = useState(false);

    const segmentsSize = 1;
    const segmentsX = 100;
    const segmentsZ = 100;
    const sizeX = segmentsSize * segmentsX;
    const sizeZ = segmentsSize * segmentsZ;
    const gridOffset = 1;

    useEffect(() => {
        setIsGoto(event?.type === "GOTO" && !event?.options.instant);
    }, [event]);

    useFrame((state) => {
        if (isGoto && event?.type) {
            const payloadPosition = event?.payload as Vector3;
            const targetPosition = new Vector3(payloadPosition.x + 0.5, 10, payloadPosition.z - 2.5);
            state.camera.position.lerpVectors(state.camera.position, targetPosition, 0.05);

            if (state.camera.position.distanceTo(targetPosition) < 0.01) {
                setIsGoto(false);
            }
        }
    });

    const handlePointerMove = (event: ThreeEvent<PointerEvent | MouseEvent>) => {
        const intersectionPoint = event.point;
        const tileX = Math.floor(intersectionPoint.x);
        const tileZ = Math.floor(intersectionPoint.z);
        setHoverTile([tileX, 0, tileZ]);
    };

    const handlePointerOut = () => {
        setHoverTile(null);
    };

    const handleClick = (event: ThreeEvent<PointerEvent | MouseEvent>) => {
        let vesselFound = false;
        const intersectionPoint = event.point;
        const tileX = Math.floor(intersectionPoint.x);
        const tileZ = Math.floor(intersectionPoint.z);

        vessels.forEach((vessel) => {
            if (vessel.position.x === tileX && vessel.position.z === tileZ) {
                vesselFound = true;
                if (selectedVessel?.id === vessel.id) return;


                selectVessel({ ...vessel });
                send({ type: "ACTIONSMENU_SHOW", payload: null });
            }
        });

        if (!vesselFound) {
            clear();
            clearSelectedVessel();
        }
    };

    return (
        <>
            {hoverTile && isBrowser ? <PlanetarySelectTile position={hoverTile} /> : null}
            {event?.type === "ACTIONSMENU_MOVE" ? <PlanetaryMoveZone position={(event.payload as Vessel).position} /> : null}
            <Plane
                receiveShadow
                args={[sizeX, sizeZ]}
                position={[
                    (sizeX / 2) + gridOffset,
                    0,
                    (sizeZ / 2) + gridOffset
                ]}
                rotation={[-Math.PI / 2, 0, 0]}
                onPointerMove={handlePointerMove}
                onClick={handleClick}
                onPointerLeave={handlePointerOut}
            >
                <shadowMaterial opacity={0.25} />
            </Plane>
            <PlanetaryExhaustedTiles />
            <PlanetaryGround sizeX={sizeX} sizeZ={sizeZ} />
        </>
    );
};
