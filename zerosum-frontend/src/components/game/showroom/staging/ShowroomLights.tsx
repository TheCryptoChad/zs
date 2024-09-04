import { Environment } from "@react-three/drei";
import { Object3D } from "three";

export const ShowroomLights = () => {
    //const directionalLight = useRef();

    //useHelper(directionalLight, DirectionalLightHelper, 1, "red");
    const target = new Object3D()
    target.position.set(10, 3, 32.5)

    return (
        <>
            <Environment preset="sunset" />
            <directionalLight
                target={target}
                //ref={directionalLight}
                intensity={0.7}
                position={[-30, 30, 50]} // Adjust the position to represent sunlight direction
                castShadow
                shadow-mapSize-width={4096} // Increase the shadow map size for better quality shadows
                shadow-mapSize-height={4096}
                shadow-camera-near={1}
                shadow-camera-far={300}
                shadow-camera-left={-75} // Adjust the frustum parameters to increase the coverage area
                shadow-camera-right={75}
                shadow-camera-top={75}
                shadow-camera-bottom={-75}
            />
        </>
    );
};