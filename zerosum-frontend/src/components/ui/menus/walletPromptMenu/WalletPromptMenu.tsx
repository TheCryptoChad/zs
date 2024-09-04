import { useToast, VStack, Heading, Button, Spinner, Box, Text, Center, Divider } from "@chakra-ui/react"
import { ConnectButton } from "@rainbow-me/rainbowkit"
import { useMutation } from "react-query"
import { useAccount, useSignMessage } from "wagmi"
import { queryClient } from "../../../../main"
import { ScreenBackdrop } from "../../utils/ScreenBackdrop"
import { API } from "../../../../api/api"
import { useEffect, useRef } from "react"

export const WalletPromptMenu = () => {
    const { isConnected, address } = useAccount()
    const vStackRef = useRef<HTMLDivElement>(null);

    useEffect(() => {
        if (isConnected && vStackRef.current) {
            const element = vStackRef.current;
            element.scrollTop = element.scrollHeight;
        }
    }, [isConnected]);

    const message = `
Welcome to Zero Sum!

This signature request will not cause a blockchain transaction and will not cause any gas fees.
    `
    const toast = useToast()

    const { mutate } = useMutation((newData: { address: Config.HexString, message: string, data: Config.HexString }) => API.user.registerAddress(newData.address, newData.message, newData.data), {
        onSuccess: () => {
            // Invalidate and refetch
            queryClient.invalidateQueries('user')

            toast({
                title: `Successfully linked address: ${address} to account`,
                status: "success",
                duration: 5000,
                isClosable: true,
                containerStyle: {
                    width: ["90%", "60%"]
                }
            })
        },
        onError: (e: {
            address: Config.HexString;
            message: string;
            data: Config.HexString;
        }) => {
            toast({
                title: e.message,
                status: "error",
                duration: 5000,
                isClosable: true,
                containerStyle: {
                    width: ["90%", "60%"]
                }
            })
        }
    })

    const { isLoading, signMessage } = useSignMessage({
        message: message,
        onSuccess(data) {
            if (address && message && data) {
                mutate({
                    address: address,
                    message: message,
                    data: data
                })
            }
        }
    })

    return (
        <ScreenBackdrop>
            <Center>
                <Box
                    w={["90%", "420px"]}
                    textAlign={"center"}
                    mx={"auto"}
                    pt={8} pb={"4"} px={6}
                    className="gildedBorder"
                    bg={"samaBlack"}
                    color={"samaWhite"}
                >
                    <VStack ref={vStackRef} overflowY={"auto"}>
                        <Heading fontFamily={"Orbitron"} letterSpacing={1.5}>
                            Missing Wallet
                        </Heading>
                        <Divider my={2} />
                        <Text mb={4} fontFamily={"Raleway"}>
                            In order to ensure a seamless gaming experience and to claim your in-game resources, we kindly ask you to sign an off-chain message.<br /><br />This is a crucial step for verifying your unique identity and ensuring the security of your game account.
                        </Text>
                        <Text h={6} fontFamily={"Raleway"} color={"red"}>{ }</Text>
                        <ConnectButton showBalance={false} />
                        <Button
                            isDisabled={isLoading}
                            fontFamily={"Orbitron"}
                            letterSpacing={2}
                            onClick={() => signMessage()}
                            w={"167.5px"}
                            py={2.5}
                            bg={"samaWhite"}
                            visibility={
                                isConnected
                                    ? "visible"
                                    : "collapse"
                            }>
                            {(isLoading) ? <Spinner color='samaBlue.500' /> : "LINK"}
                        </Button>
                    </VStack>
                </Box>
            </Center>
        </ScreenBackdrop>
    )
}