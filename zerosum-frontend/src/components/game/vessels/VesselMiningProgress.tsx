import { Html } from "@react-three/drei";
import { useState, useEffect } from "react";
import { useEventStore } from "../../../stores/useEventStore";

export const VesselMiningProgress = ({ miningEndTime, shouldDisplay, vessel }: { miningEndTime: number, shouldDisplay: boolean, vessel: Vessel | null }) => {
    const miningStartTime = miningEndTime - 60_000;
    const [progressPercentage, setProgressPercentage] = useState(0);
    const { send } = useEventStore()

    const progressBarLength = 80;

    const handleClick = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        event.stopPropagation()
        send({ type: "ACTIONSMENU_MINE", payload: vessel });
    };

    useEffect(() => {
        const updateProgress = () => {
            const currentTime = Date.now();
            if (currentTime >= miningStartTime && currentTime <= miningEndTime) {
                const elapsedTime = currentTime - miningStartTime;
                const totalTime = miningEndTime - miningStartTime;
                const percentage = (elapsedTime / totalTime) * 100;
                setProgressPercentage(percentage);
            } else if (currentTime < miningStartTime) {
                setProgressPercentage(0);
            } else {
                setProgressPercentage(100);
            }
        };

        updateProgress();  // Call immediately on component mount

        const interval = setInterval(updateProgress, 1000);

        return () => {
            clearInterval(interval);
        };
    }, [miningStartTime, miningEndTime]);

    if (!vessel) return null

    return (
        shouldDisplay && (
            <Html
                zIndexRange={[1, 0]}
                center
                wrapperClass="parent"
                style={{ transform: 'translateX(-40px) translateY(-60px)', pointerEvents: "none" }}>
                {Math.ceil(progressPercentage) === 100 ? (
                    <button
                        onClick={(event) => handleClick(event)}
                        style={{
                            position: "relative",
                            fontFamily: "Orbitron",
                            letterSpacing: "1px",
                            fontSize: "10px",
                            fontWeight: "bold",
                            width: `${progressBarLength}px`,
                            textTransform: "uppercase",
                            border: "1px solid #0EEBA8",
                            backgroundColor: "#FAF9F6",
                            color: "#191919",
                            pointerEvents: "auto",
                            borderRadius: "2px",
                            transition: "background-color 0.3s ease, color 0.3s ease"
                        }}
                        onMouseOver={e => {
                            e.currentTarget.style.backgroundColor = "#0EEBA8";
                        }}
                        onMouseOut={e => {
                            e.currentTarget.style.backgroundColor = "#FAF9F6";
                        }}
                    >
                        Collect
                    </button>

                ) : (
                    <div style={{ position: "relative", borderWidth: "1px", borderColor: "#191919", borderRadius: "2px", height: "10px", width: `${progressBarLength + 2}px`, background: "black" }}>
                        <div style={{
                            backgroundColor: "#008080",
                            height: "100%",
                            width: `${(progressPercentage / 100) * progressBarLength}px`,
                            borderRadius: "2px"
                        }} />
                        <p style={{
                            fontSize: "10px",
                            fontFamily: "Orbitron",
                            letterSpacing: "2px",
                            position: "absolute",
                            top: "50%",
                            left: "50%",
                            transform: "translate(-50%, -50%)",
                            color: "white",
                            textShadow: "1px 1px 0 black, -1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black"
                        }}>
                            {`${Math.ceil(progressPercentage)}%`}
                        </p>
                    </div>
                )}
            </Html>
        )
    );
};