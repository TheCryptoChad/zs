import { Box, HStack, Image, Spacer, VStack } from "@chakra-ui/react"
import { GameHeaderResources } from "./GameHeaderResources/GameHeaderResources"
import { isMobile } from "react-device-detect"
import { useState } from "react"
import { SettingsMenu } from "../menus/settingsMenu/SettingsMenu"
import { GameHeaderButtons } from "./GameHeaderButtons"
import { GameHeaderUpgrades } from "./GameHeaderUpgrades"

export const GameHeader = () => {
    const [hasSettingsMenu, setHasSettingsMenu] = useState(false);

    return (
        <Box w="full" pointerEvents={"none"} left={0} top={0} position={"absolute"} fontFamily={"Orbitron"}>
            <HStack p={2}>
                <Image
                    h={isMobile ? 12 : 16}
                    w={isMobile ? 12 : 16}
                    src="logo_trnsp.png"
                    alignSelf={"start"}
                />
                <Spacer />
                {isMobile &&
                    <VStack gap={0.5} alignSelf={"start"}>
                        <GameHeaderUpgrades />
                        <GameHeaderResources />
                    </VStack>
                }
                {!isMobile && 
                    <>
                        <GameHeaderResources />
                        <GameHeaderUpgrades />
                    </>
                }
                <GameHeaderButtons handleBackdropClick={() => setHasSettingsMenu(true)} />
                {hasSettingsMenu && <SettingsMenu handleBackdropClick={() => setHasSettingsMenu(false)} />}
            </HStack>
        </Box>
    )
}
