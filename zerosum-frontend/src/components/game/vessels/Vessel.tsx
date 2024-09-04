import { RootState, useFrame } from "@react-three/fiber";
import { useRef, useEffect, useState } from "react";
import { Vector3, Quaternion } from "three";
import { useVesselsStore } from "../../../stores/useVesselsStore";
import { useEventStore } from "../../../stores/useEventStore";
import { useNavigate } from "react-router-dom";
import { VesselDefaultModel } from "../../models/VesselDefaultModel";
import { VesselMantaModel } from "../../models/VesselMantaModel";
import ActionsMenu from "../menus/actions/ActionsMenu";
import { VesselMiningProgress } from "./VesselMiningProgress";
import { useQuery } from "react-query";
import { API } from "../../../api/api"

export const Vessel = ({ vessel }: { vessel: Vessel }) => {
    const { selectedVessel, selectVessel, clearSelectedVessel } = useVesselsStore();
    const { send, event, clear } = useEventStore()
    const navigate = useNavigate();

    const goToShowroom = (vessel: Vessel) => {
        clearSelectedVessel()
        clear()
        navigate("/view", { state: { vessel } });
    }

    const { data } = useQuery<Entity.Tile[]>({
        queryKey: "exhausted-tiles",
        queryFn: API.tiles.getAllExhausted,
    });

    const vesselGroupRef = useRef<THREE.Group>(null);
    const htmlGroupRef = useRef<THREE.Group>(null);

    const tileOffset = 0.5;
    const offsetPosition = new Vector3(tileOffset, tileOffset, tileOffset);

    const targetRotation = new Quaternion(); // Declare the targetRotation outside the function

    const [isMenuDisplayed, setIsMenuDisplayed] = useState(true)

    useEffect(() => setIsMenuDisplayed(event?.type === "ACTIONSMENU_SHOW"), [event]);

    useEffect(() => {
        vesselGroupRef.current?.position.set(
            vessel.position.x + tileOffset,
            tileOffset,
            vessel.position.z + tileOffset
        );
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);


    useEffect(() => {
        htmlGroupRef.current?.position.set(
            vessel.position.x + tileOffset - 1,
            tileOffset,
            vessel.position.z + tileOffset
        );
    }, [vessel.position.x, vessel.position.z]);

    const [hasArrived, setHasArrived] = useState(false)

    useEffect(() => {
        setHasArrived(false)
    }, [vessel.position])

    let targetPosition = new Vector3()

    const updatePosition = (state: RootState) => {
        if (!vesselGroupRef.current?.position) return

        if (
            vesselGroupRef.current?.position.x - 0.5 === vessel.position.x &&
            vesselGroupRef.current?.position.z - 0.5 === vessel.position.z
        ) return
        if (vesselGroupRef.current) {
            targetPosition = vessel.position.clone().add(offsetPosition);
            if (!vessel.position.equals(vesselGroupRef.current.position)) {
                // Calculate the target rotation
                const targetDirection = targetPosition.clone().sub(vesselGroupRef.current.position);
                targetDirection.y = 0; // Ensure rotation only around Y-axis
                targetRotation.setFromUnitVectors(new Vector3(0, 0, 1), targetDirection.normalize());

                // Rotate towards the target rotation
                vesselGroupRef.current.quaternion.slerp(targetRotation, 0.02);

                // Check if the rotation has almost completed
                const rotationAccuracy = 0.01; // 0.1% accuracy
                const angle = vesselGroupRef.current.quaternion.angleTo(targetRotation);
                const rotationCompleted = angle <= rotationAccuracy;

                if (rotationCompleted) {
                    // Perform the lerp
                    vesselGroupRef.current.position.lerp(targetPosition, 0.01);

                    if (event?.type === 'VESSEL_FOLLOW') {
                        const targetCameraPosition = new Vector3(vesselGroupRef.current.position.x + 0.5, 10, vesselGroupRef.current.position.z - 2.5);
                        state.camera.position.lerpVectors(state.camera.position, targetCameraPosition, 0.05);
                    }


                    if (vesselGroupRef.current.position.distanceTo(targetPosition) < 0.5 && !hasArrived) {
                        setHasArrived(true)

                        if (vessel.miningEndTime === null) {
                            selectVessel(vessel)
                            send({ type: "ACTIONSMENU_SHOW", payload: null })
                        } else {
                            clear()
                            clearSelectedVessel()
                        }
                    }
                }
            }
        }
    };

    const bobLoop = (state: RootState) => {
        if (vesselGroupRef.current) {
            // Add bobbing effect to the mesh
            vesselGroupRef.current.position.y += Math.sin(state.clock.getElapsedTime()) * 0.00075; // Adjust multiplier for amplitude
        }
    };

    useFrame((state) => {
        updatePosition(state);
        bobLoop(state);
    });

    return (
        <>
            <group ref={vesselGroupRef}>
                <VesselMiningProgress
                    shouldDisplay={vessel.miningEndTime !== null && vessel.id !== selectedVessel?.id}
                    miningEndTime={vessel.miningEndTime ?? 0}
                    vessel={vessel}
                />
                {
                    import.meta.env.VITE_CHAIN_NAME === "manta"
                        ? <VesselMantaModel key={vessel.id} position={[0, 0, 0.5]} scale={0.1} />
                        : <VesselDefaultModel key={vessel.id} scale={0.1} />
                }
            </group>
            <group >
                <ActionsMenu
                    actionMenuButtonProps={[
                        { text: "Move", effect: () => send({ type: "ACTIONSMENU_MOVE", payload: vessel }), disabled: false },
                        {
                            text: "Mine", effect: () => send({ type: "ACTIONSMENU_MINE", payload: vessel }), disabled: data?.some(
                                item => item.x == vessel.position.x && item.y == vessel.position.z
                            ) ?? false
                        },
                        { text: "View", effect: () => goToShowroom(vessel), disabled: false }
                    ]}
                    shouldDisplay={isMenuDisplayed && selectedVessel?.id === vessel.id}
                    position={[vessel.position.x + tileOffset - 1, tileOffset, vessel.position.z + tileOffset]}
                />
            </group>
        </>
    );
};
