import { Box, Button, Divider, Heading, VStack } from "@chakra-ui/react"
import { ScreenBackdrop } from "../../utils/ScreenBackdrop"
import { API } from "../../../../api/api"
import { queryClient } from "../../../../main"
import { SettingsMenuData } from "./SettingsMenuData"

export const SettingsMenu = ({ handleBackdropClick }: { handleBackdropClick: () => void }) => {
    const handleLogout = async () => {
        await API.auth.logout()
        queryClient.invalidateQueries()
    }

    return (
        <ScreenBackdrop handleBackdropClick={handleBackdropClick}>
            <Box
                h={"auto"}
                overflowY={"auto"}
            >
                <VStack
                    bg={"samaBlack"}
                    px={8}
                    py={4}
                    rounded={"sm"}
                >
                    <Heading
                        fontFamily={"Orbitron"}
                        letterSpacing={2}
                        textTransform={"uppercase"}
                        color={"samaTeal.500"}
                        pb={4}
                    >
                        Menu
                    </Heading>
                    {SettingsMenuData.main.map(({ label, disabled, onClick }) => {
                        return (
                            <MenuButton key={label} label={label} disabled={disabled} onClick={onClick} />
                        )
                    })}
                    <Divider my={2} />
                    {SettingsMenuData.socials.map(({ label, onClick, disabled }) => {
                        return (
                            <MenuButton key={label} label={label} disabled={disabled} onClick={onClick} />
                        )
                    })}
                    <Divider my={2} />
                    <MenuButton label={"Logout"} disabled={false} onClick={handleLogout} />
                </VStack>
            </Box>
        </ScreenBackdrop>
    )
}

const MenuButton = ({ label, disabled, onClick }: { label: string, disabled: boolean, onClick: () => void | Window | null | Promise<void> }) => {
    const interactStyle = { bg: "#0EEBA8", color: "samaBlackFade" }

    return (
        <Button
            isDisabled={disabled}
            fontFamily={"Orbitron"}
            letterSpacing={1.5}
            fontSize={12}
            p={"12px"}
            w={60}
            textTransform={"uppercase"}
            border="1px solid #0EEBA8"
            _hover={!disabled ? interactStyle : {}}
            _active={!disabled ? interactStyle : {}}
            onClick={onClick}
        >
            {label}
        </Button>
    )
}