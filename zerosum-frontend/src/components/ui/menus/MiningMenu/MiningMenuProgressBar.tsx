import { Box, Progress, Text, Button } from "@chakra-ui/react";
import { useState, useEffect } from "react";

export const MiningMenuProgressBar = ({ miningEndTime, vessel }: { miningEndTime: number; vessel: Vessel }) => {
    const miningStartTime = miningEndTime - (60_000 * (1 - (Number(vessel?.speed || 0) * 0.05)));
    const [progressPercentage, setProgressPercentage] = useState(0);
    const [isMiningFinished, setIsMiningFinished] = useState(false); // new state

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
                setIsMiningFinished(true); // set mining finished to true when it's done
            }
        };

        updateProgress();  // Call immediately on component mount

        const interval = setInterval(updateProgress, 1000);

        return () => {
            clearInterval(interval);
        };
    }, [miningStartTime, miningEndTime]);

    // Limit the progress percentage to not exceed 100
    const displayedProgressPercentage = Math.min(Math.ceil(progressPercentage), 100);

    return (
        <Box position="relative" w="50%">
            <Progress
                colorScheme="samaTeal"
                bg={"black"}
                size="lg"
                rounded="sm"
                value={displayedProgressPercentage}
            />
            {isMiningFinished ? (
                <Button
                    position="absolute"
                    top="50%"
                    left="50%"
                    transform="translate(-50%, -50%)"
                    colorScheme="teal"
                    textShadow="1px 1px 0 black, -1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black"
                >
                    Finish Mining
                </Button>
            ) : (
                <Text
                    fontFamily={"Orbitron"}
                    letterSpacing={2}
                    position="absolute"
                    top="50%"
                    left="50%"
                    transform="translate(-50%, -50%)"
                    color="white"
                    textShadow="1px 1px 0 black, -1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black"
                >
                    {displayedProgressPercentage}%
                </Text>
            )}
        </Box>
    );
};
