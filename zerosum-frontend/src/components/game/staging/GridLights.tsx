export const GridLights = () => {
    //const directionalLight = useRef();

    //useHelper(directionalLight, DirectionalLightHelper, 1, "red");

    return (
        <>
            <directionalLight
                //ref={directionalLight}
                intensity={0.5}
                position={[100, 75, 100]} // Adjust the position to represent sunlight direction
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
