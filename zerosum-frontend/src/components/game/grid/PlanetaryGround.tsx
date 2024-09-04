import { Plane } from "@react-three/drei";
import { useLoader } from "@react-three/fiber";
import { RepeatWrapping, TextureLoader } from "three";

export const PlanetaryGround = ({ sizeX, sizeZ }: { sizeX: number, sizeZ: number }) => {
    const [
        alphaMap,
        colorMap,
        overlay,
        displacementMap,
        emissionMap,
        metallicMap,
        normalMap,
        roughnessMap
    ] = useLoader(TextureLoader, [
        './ground/GroundMaterial_Alpha.jpg',
        './ground/GroundMaterial_BaseColor.jpg',
        './ground/GroundMaterial_Overlay.png',
        './ground/GroundMaterial_Displacement.jpg',
        './ground/GroundMaterial_Emission.jpg',
        './ground/GroundMaterial_Metallic.jpg',
        './ground/GroundMaterial_Normal.jpg',
        './ground/GroundMaterial_Roughness.png'
    ]);

    const textures = [alphaMap, colorMap, displacementMap, emissionMap, metallicMap, normalMap, roughnessMap];
    textures.forEach(texture => {
        texture.wrapS = RepeatWrapping;
        texture.wrapT = RepeatWrapping;
        texture.repeat.set(10, 10);
    });

    const yOffset = -0.01; // Avoid z-fighting with PlanetaryGrid that overlays this

    return (
        <>
            <Plane
                args={[sizeX * 2, sizeZ * 2]}
                position={[
                    (0 * sizeX + sizeX / 2) + 1,
                    yOffset - 0.2,
                    (0 * sizeX + sizeZ / 2) + 1
                ]}
                rotation={[-Math.PI / 2, 0, 0]}
            >
                <meshStandardMaterial
                    attach="material"
                    alphaMap={alphaMap}
                    map={colorMap}
                    displacementMap={displacementMap}
                    emissiveMap={emissionMap}
                    metalnessMap={metallicMap}
                    normalMap={normalMap}
                    roughnessMap={roughnessMap}
                    metalness={0.0}
                />
            </Plane>
            <Plane
                args={[sizeX * 2, sizeZ * 2]}
                position={[
                    (0 * sizeX + sizeX / 2) + 1,
                    yOffset,
                    (0 * sizeX + sizeZ / 2) + 1
                ]}
                rotation={[-Math.PI / 2, 0, 0]}
            >
                <meshBasicMaterial
                    attach="material"
                    map={overlay}
                    transparent
                    opacity={0.9}
                />
            </Plane>
        </>
    );
};
