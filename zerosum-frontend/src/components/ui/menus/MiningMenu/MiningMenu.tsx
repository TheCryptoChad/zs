import { useState, useEffect } from "react";
import { Box, Heading, VStack, Image, Text } from "@chakra-ui/react";
import { useEventStore } from "../../../../stores/useEventStore";
import { ScreenBackdrop } from "../../utils/ScreenBackdrop";
import { useVesselsStore } from "../../../../stores/useVesselsStore";
import { API } from "../../../../api/api";
import { MiningMenuFinishButton } from "./MiningMenuFinishButton";
import { MiningMenuProgressBar } from "./MiningMenuProgressBar";
import { MiningMenuResources } from "./MiningMenuResources";
import { MiningMenuStartButton } from "./MiningMenuStartButton";
import { isMobile } from "react-device-detect";
import CloseIcon from "../../../../assets/icons/close_icon.svg"

export const MiningMenu = () => {
    const { event, clear } = useEventStore();
    const { clearSelectedVessel } = useVesselsStore();
    const [currentTime, setCurrentTime] = useState(new Date().getTime());

    const handleBackdropClick = () => {
        clearSelectedVessel();
        clear();
    };

    const [tileTypeData, setTileTypeData] = useState<{ tiletype: number, probabilities: Entity.Resources } | null>(null);

    useEffect(() => {
        if (event?.type !== 'ACTIONSMENU_MINE') return

        const fetchTileTypeData = async () => {
            if (event?.payload?.position) {
                const res = await API.tiles.getType(event.payload.id)
                setTileTypeData(res)
            }
        }
        fetchTileTypeData();
    }, [event?.payload, event?.type])

    useEffect(() => {
        const timer = setInterval(() => {
            setCurrentTime(new Date().getTime());
        }, 1000);

        return () => {
            clearInterval(timer);
        };
    }, []);

    return (event?.type === "ACTIONSMENU_MINE" && event.payload && tileTypeData) && (
        <ScreenBackdrop handleBackdropClick={handleBackdropClick}>
            <Box
                w={isMobile ? "90%" : "auto"}
                h={isMobile ? "auto" : "50%"}
                position="absolute"
                bgImage="backgrounds/mining_background.jpeg"
                backgroundPosition="center"
                bgSize="cover"
                rounded={"sm"}
                color={"samaWhite"}
                p={4}
                className="gildedBorder"
            >
                <VStack spacing={0} justifyContent="space-between" h="100%">
                    <Heading
                        fontFamily={"Orbitron"}
                        letterSpacing={3}
                        textTransform={"uppercase"}
                        textAlign={"center"}
                        stroke="1px black"  // Add black border to the text
                    >
                        Mining
                    </Heading>
                    <Text bg={"#191919AA"} px={2} rounded={"sm"} fontFamily={"Orbitron"} letterSpacing={2}>({event.payload.position.x}, {event.payload.position.z})</Text>
                    {isMobile && (
                        <Image
                            src={CloseIcon}
                            onClick={handleBackdropClick}
                            top={0}
                            right={0}
                            m={2}
                            pos={"absolute"}
                        />
                    )}
                    <MiningMenuResources probabilities={tileTypeData.probabilities} />
                    {event.payload.miningEndTime
                        && currentTime >= event.payload.miningEndTime
                        ? <MiningMenuFinishButton vessel={event.payload} />
                        : !event.payload.miningEndTime
                            ? <MiningMenuStartButton vessel={event.payload} />
                            : <MiningMenuProgressBar miningEndTime={event.payload.miningEndTime} vessel={event.payload} />
                    }
                </VStack>
            </Box>
        </ScreenBackdrop>
    )
};
