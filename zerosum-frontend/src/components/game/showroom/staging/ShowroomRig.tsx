import { PerspectiveCamera } from "@react-three/drei"
import { useFrame } from "@react-three/fiber"
import { useRef } from "react"
import { Camera, Vector3, MathUtils } from "three"

export const ShowroomRig = () => {
    const cameraRef = useRef<Camera>(null)
    const startPos: Vector3 = new Vector3(28, 5, 60)
    const endPos: Vector3 = new Vector3(21, 5, 50)

    useFrame(() => {
        if (!cameraRef.current) return

        if (cameraRef.current.position.distanceTo(endPos) > 0.05) {
            cameraRef.current.position.lerp(endPos, 0.005)
        }
    })

    return <PerspectiveCamera
        ref={cameraRef}
        makeDefault
        position={startPos}
        rotation={[0, MathUtils.degToRad(35), 0]}
    />
}