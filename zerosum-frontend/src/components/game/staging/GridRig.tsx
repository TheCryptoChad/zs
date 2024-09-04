import { useThree } from "@react-three/fiber";
import { useEffect } from "react";
import { Vector3 } from "three";
import { degToRad } from "three/src/math/MathUtils.js";
import { useEventStore } from "../../../stores/useEventStore";
import { PerspectiveCamera } from "@react-three/drei";

export const GridRig = () => {
    const { event } = useEventStore();
    const { camera, size } = useThree();

    useEffect(() => {
        if (event?.type === "GOTO" && event?.options.instant) {
            // assuming event.options.payload is the new Vector3
            const adjustedPayload = new Vector3(parseInt(event.payload.x) + 0.5, 10, parseInt(event.payload.y) - 2.5);

            camera.position.copy(adjustedPayload);
            camera.updateProjectionMatrix(); // needed if camera parameters like aspect, fov, near or far have changed
        }
    }, [event, camera]); // you need to include 'camera' in the dependency array

    return (
        <PerspectiveCamera
            makeDefault
            aspect={size.width / size.height}
            fov={75}
            position={[50, 10, 40]}
            rotation={[degToRad(75), Math.PI, 0]}
        />
    )
}