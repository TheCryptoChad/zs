import { useFrame } from "@react-three/fiber";
import { useRef } from "react";
import { Group } from "three";
import { VesselDefaultGalleryModel } from "../../models/gallery/VesselDefaultGalleryModel";
import { VesselMantaGalleryModel } from "../../models/gallery/VesselMantaGalleryModel";

export const ShowroomVessel = () => {
    const vesselRef = useRef<Group>(null);

    useFrame((state) => {
        if (vesselRef.current) {
            // Add bobbing effect to the mesh
            vesselRef.current.position.y += Math.sin(state.clock.getElapsedTime()) * 0.00075; // Adjust multiplier for amplitude
        }
    });

    return (
        <group ref={vesselRef}>
            {
                import.meta.env.VITE_CHAIN_NAME === "manta"
                    ? <VesselMantaGalleryModel scale={1.5} position={[10, 3, 32.5]} />
                    : <VesselDefaultGalleryModel scale={1.5} position={[10, 3, 32.5]} />
            }
        </group>
    )
}