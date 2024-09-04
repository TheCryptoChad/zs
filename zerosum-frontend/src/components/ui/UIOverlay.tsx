import { Box } from "@chakra-ui/react"
import { GameHeader } from "./header/GameHeader"
import { API } from "../../api/api"
import { useQuery } from "react-query"
import { WalletPromptMenu } from "./menus/walletPromptMenu/WalletPromptMenu"
import { MiningMenu } from "./menus/MiningMenu/MiningMenu"
import { Sidebar } from "./sidebar/Sidebar"

export const UIOverlay = () => {
    const { data, status } = useQuery('user', API.user.getSelf, {
        staleTime: Infinity
    })

    return (
        /* Outer Box should not be clickable or can't interact with canvas */
        <Box h={"100vh"} w={"100vw"} zIndex={100} left={0} top={0} position={"absolute"} pointerEvents={"none"}>
            {/* Inner Box should be clickable so we may interact with the components */}
            <Box pointerEvents="auto">
                {
                    status === "success" && !data.address
                        ? <WalletPromptMenu />
                        : <UIContent />
                }
            </Box>
        </Box>
    )
}

const UIContent = () => {
    return (
        <>
            <GameHeader />
            <MiningMenu />
            <Sidebar />
        </>
    )
}