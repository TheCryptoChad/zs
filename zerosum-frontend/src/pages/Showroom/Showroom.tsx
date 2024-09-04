import { Canvas } from "@react-three/fiber";
import { useLocation, useNavigate } from "react-router-dom";
import { Button } from "@chakra-ui/react";
import { useEventStore } from "../../stores/useEventStore";
import { ShowroomVessel } from "../../components/game/showroom/ShowroomVessel";
import "./showroom.css"
import { OrbitControls, Stage } from "@react-three/drei";
import { MaintenaceBanner } from "../../components/ui/maintenance/MaintenanceBanner";

export const Showroom = () => {
    const navigate = useNavigate()
    const location = useLocation();
    const vessel = location.state?.vessel

    const { send } = useEventStore()

    return (
        <>
            {import.meta.env.VITE_MAINTENANCE_MODE === "true" && <MaintenaceBanner />}
            <Button
                m={6}
                px={8}
                bg={"samaBlack"}
                color={"samaWhite"}
                className="gildedBorder"
                pos={"absolute"}
                zIndex={100}
                onClick={() => {
                    navigate("/game");
                    send({ type: "GOTO", payload: vessel.position, options: { instant: true } })
                    return
                }}
            >
                Back
            </Button>
            <Canvas
                shadows
                style={{
                    width: "100%",
                    height: "100%",
                    background: "#191919",
                    opacity: 0,
                    touchAction: "none",
                    animation: "fade-in 5s ease 1s forwards"
                }}>
                {/* <Perf position="top-right" /> */}
                <color attach="background" args={['#003366']} />
                <Stage
                    intensity={0.5}
                    preset="rembrandt"
                    shadows={{ type: 'accumulative', color: '#003366', colorBlend: 2, opacity: 1 }}
                    adjustCamera={1}
                    environment="city">
                    <ShowroomVessel />
                </Stage>
                <OrbitControls minPolarAngle={0} maxPolarAngle={Math.PI / 1.9} makeDefault />
            </Canvas>
        </>
    );
};
