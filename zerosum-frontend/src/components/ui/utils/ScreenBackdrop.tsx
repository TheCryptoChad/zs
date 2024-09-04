import { VStack } from "@chakra-ui/react";

export const ScreenBackdrop = ({ handleBackdropClick, children }: { handleBackdropClick?: () => void, children: JSX.Element }) => {
    const handleParentClick = (event: React.MouseEvent<HTMLElement>) => {
        event.preventDefault()

        if (event.target === event.currentTarget && handleBackdropClick) {
            handleBackdropClick()
        }
    }
    return (
        <VStack
            position="fixed"
            top="0"
            left="0"
            w="100vw"
            h="100vh"
            zIndex={1000}
            p={4}
            backdropFilter="auto"
            backdropBlur="sm"
            onClick={handleParentClick}
            bg="fullBlack50"
            alignItems="center"
            justifyContent="center"
            pointerEvents={"auto"}
        >
            {children}
        </VStack>
    );
}
