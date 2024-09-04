import { Environment } from "@react-three/drei"
import { Canvas } from "@react-three/fiber"
import { PlanetaryGrid } from "./grid/PlanetaryGrid"
import { Grid3DControls } from "./staging/GridControls"
import { GridLights } from "./staging/GridLights"
import { GridRig } from "./staging/GridRig"
import { VesselInstances } from "./vessels/VesselInstances"


export const GameCanvas = () => {
    return (
        <Canvas shadows style={{ width: "100%", height: "100%", background: "#191919" }}>
            {/* <Perf position="bottom-right" /> */}
            <VesselInstances />
            <PlanetaryGrid />
            <GridRig />
            <GridLights />
            <Grid3DControls />
            <Environment preset="sunset" />
            {/* <EffectComposer>
                <DepthOfField focusDistance={0} focalLength={0.02} bokehScale={2} height={480} />
                <Bloom luminanceThreshold={0} luminanceSmoothing={1.2} height={300} />
                <Noise opacity={0.01} />
            </EffectComposer> */}
            <fog attach="fog" args={[0x0099cc, 1, 50]} />
        </Canvas>
    )
}
