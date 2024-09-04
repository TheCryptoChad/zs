import * as THREE from "three";
import { useGLTF } from "@react-three/drei";
import { GLTF } from "three-stdlib";
import { DissolveMaterial } from "../../game/shaders/DissolveMaterial"

type GLTFResult = GLTF & {
    nodes: {
        ship: THREE.Mesh;
        back: THREE.Mesh;
        front: THREE.Mesh;
        weapons: THREE.Mesh;
        wings: THREE.Mesh;
    };
    materials: {
        base_blue: THREE.MeshStandardMaterial;
    };
};

export function VesselDefaultGalleryModel(props: JSX.IntrinsicElements["group"]) {
    const { nodes, materials } = useGLTF("/ship_default.glb") as GLTFResult;

    return (
        <group {...props} dispose={null} castShadow>
            {Object.entries(nodes).map(([name, mesh]) => (
                <mesh
                    key={name}
                    castShadow
                    receiveShadow
                    geometry={mesh.geometry}
                /* onPointerOver={e => {
                    (e.eventObject as THREE.Mesh).material.color = new THREE.Color("#0EEBA8")
                    console.log((e.eventObject as THREE.Mesh).material)
                    e.stopPropagation()
                }}
                onPointerOut={(e) => {
                    (e.eventObject as THREE.Mesh).material.color = new THREE.Color("white")
                    e.stopPropagation()
                }} */
                >
                    <DissolveMaterial
                        baseMaterial={materials.base_blue}
                        thickness={0.1}
                        feather={16}
                        color={"#0EEBA8"}
                        intensity={12}
                    />
                </mesh>
            ))}
        </group>
    );
}

useGLTF.preload("/ship_default.glb");
