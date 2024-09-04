import * as THREE from "three";
import { useRef, useEffect, useMemo } from "react";
import { useGLTF, useAnimations } from "@react-three/drei";
import { SkeletonUtils, GLTF } from "three-stdlib";
import { useGraph } from "@react-three/fiber";

type GLTFResult = GLTF & {
    nodes: {
        manta_low: THREE.SkinnedMesh;
        Main: THREE.Bone;
    };
    materials: {
        ["Material.001"]: THREE.MeshStandardMaterial;
    };
};

export function VesselMantaModel(props: JSX.IntrinsicElements["group"]) {
    const group = useRef<THREE.Group>(null);
    const { scene, materials, animations } = useGLTF(
        "/ship_manta.glb"
    ) as GLTFResult;
    const clone = useMemo(() => SkeletonUtils.clone(scene), [scene])
    const { nodes } = useGraph(clone)

    const { actions } = useAnimations(animations, group);

    const manta_low = nodes.manta_low as THREE.SkinnedMesh;

    useEffect(() => {
        actions.Move?.play();
    }, [actions]);

    return (
        <group ref={group} {...props} dispose={null}>
            <group name="Scene">
                <group name="Manta_ship" rotation={[Math.PI / 2, 0, 0]}>
                    <skinnedMesh
                        name="manta_low"
                        geometry={manta_low.geometry}
                        material={materials["Material.001"]}
                        skeleton={manta_low.skeleton}
                        castShadow
                    />
                    <primitive object={nodes.Main} />
                </group>
            </group>
        </group>
    );
}

useGLTF.preload("/ship_manta.glb");
