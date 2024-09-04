import { Box, Text, HStack, VStack, Heading, Divider, Button } from "@chakra-ui/react";
import { SidebarItemIcon } from "./SidebarItemIcon";
import { isMobile } from "react-device-detect";

interface SidebarItemProps {
    vessel: API.VesselResponse;
    handleDeployClick: () => void;
    handleGotoClick: () => void;
}

export const SidebarItem: React.FC<SidebarItemProps> = ({ vessel, handleDeployClick, handleGotoClick }) => {
    const getStatus = (): string => {
        if (!vessel.x || !vessel.y) {
            return "Docked";
        } else if (Number(vessel.miningEndTime) && Number(vessel.miningEndTime) > new Date().getTime()) {
            return "Mining";
        } else if (Number(vessel.miningEndTime) && Number(vessel.miningEndTime) < new Date().getTime()) {
            return "Finished Mining";
        } else {
            return "Idle";
        }
    };

    return (
        <Box h={"auto"} w={"full"} p={2} bg={"samaBlack"} rounded={"sm"}>
            <HStack spacing={4} h={"full"} w={"full"}>
                <SidebarItemIcon id={Number(vessel.id)}/>
                <VStack fontFamily={"Raleway"} alignItems={"start"} h={"full"} w={"full"} gap={4} py={1} justifyContent="space-between">
                    <Heading
                        size={"xs"}
                        fontFamily={"Orbitron"}
                        fontWeight={"bold"}
                        textAlign={"center"}
                        isTruncated
                        bgGradient="linear(to-t, samaBlue.500, samaTeal.500)"
                        bgClip="text"
                        alignSelf={"center"}
                        letterSpacing={1.5}
                        overflowWrap={'break-word'}
                    >
                        {vessel.name}
                    </Heading>
                    <HStack divider={<Divider orientation="vertical" />} justifyContent={"center"} w={"full"} alignItems={"center"}>
                        <Text>ID: {vessel.id}</Text>
                        <Text>Status: {getStatus()}</Text>
                    </HStack>
                    <Button
                        bg="#25434F"
                        color="samaWhite"
                        fontFamily={"Orbitron"}
                        fontSize={"small"}
                        letterSpacing={1.5}
                        h={6}
                        w={"full"}
                        rounded={"sm"}
                        borderColor={"samaTeal.500"}
                        borderWidth={0.5}
                        onClick={getStatus() === "Docked" ? handleDeployClick : handleGotoClick}
                        _active={{
                            background: "#0EEBA8",
                            color: "#191919",
                            transform: "translateY(-3px)",
                            boxShadow: "0px 3px 10px #0EEBA8"
                        }}
                        _hover={!isMobile ? {
                            background: "#0EEBA8",
                            color: "#191919",
                            transform: "translateY(-3px)",
                            boxShadow: "0px 3px 10px #0EEBA8"
                        } : {}}
                        transition="0.3s"
                        textTransform={"uppercase"}
                    >
                        {getStatus() === "Docked" ? "Deploy" : "Go to"}
                    </Button>
                </VStack>
            </HStack>
        </Box>
    )
}
