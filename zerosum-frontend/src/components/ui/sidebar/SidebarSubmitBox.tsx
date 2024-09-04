import { Heading, Button, Spinner, Box, Text, useToast } from "@chakra-ui/react"
import { ScreenBackdrop } from "../utils/ScreenBackdrop"
import { BrowserProvider, Contract } from "ethers"
import { VesselABI } from "../../../utils/abi/VesselContract"
import { queryClient } from "../../../main"
import { useQuery } from "react-query"
import { API } from "../../../api/api"
import { config } from "../../../utils/config"
import { isMobile } from "react-device-detect"
import { useNetwork, useSwitchNetwork } from "wagmi"
import { handleNetworkSwitching, mantaTestnet } from "../../../utils/chains/chains"

type SidebarSubmitBoxProps = {
    handleRegisterToggle: () => void
    setPending: (isPending: boolean) => void
    pending: boolean
}

export const SidebarSubmitBox = ({ handleRegisterToggle, setPending, pending }: SidebarSubmitBoxProps) => {
    const toast = useToast()

    const { data: userData } = useQuery({
        queryKey: 'user',
        queryFn: API.user.getSelf
    })

    const { isLoading } = useSwitchNetwork()
    const { chain } = useNetwork()


    const getButtonContent = () => {
        if (!window.ethereum) return "No Wallet Detected"
        if (chain?.id !== mantaTestnet.id) return "Wrong Network"
        if (pending || isLoading) return <Spinner color='samaTeal.500' />

        return "Submit"
    }

    const handleSubmit = async () => {
        try {
            setPending(true);

            const provider = new BrowserProvider(window.ethereum);
            const signer = await provider.getSigner();
            const contract = new Contract(config.contracts.vessels.address, VesselABI, signer);
            console.log(config.contracts.vessels.address)

            if (signer.address.toLowerCase() !== userData?.address) {
                toast({
                    title: `Error! You must mint with the same wallet connected to your account!.`,
                    status: "error",
                    duration: 10_000,
                    isClosable: true,
                });
                return
            }

            const tx = await contract.safeMint();
            await tx.wait();

            toast({
                title: `Success! Please await the vessel's arrival in your vessel list.`,
                status: "success",
                duration: 10_000,
                isClosable: true,
                variant: "success",
            });
            queryClient.invalidateQueries('faucet');
            setTimeout(() => queryClient.invalidateQueries('vessels'), 10000);

        } catch (error: any) {
            console.log(error);
            toast({
                title: `Error! Failed to mint a vessel, please try again later.`,
                status: "error",
                duration: 10_000,
                isClosable: true,
            });
            throw error;
        } finally {
            handleRegisterToggle()
        }
    }

    return (
        <ScreenBackdrop handleBackdropClick={handleRegisterToggle}>
            <Box
                className='gildedBorder'
                zIndex={101}
                color={"samaWhite"}
                bg="samaBlack"
                p={5}
                borderWidth={2}
                boxShadow="lg"
            >
                <Heading fontFamily={"Orbitron"} color={"samaTeal.500"} letterSpacing={2} textTransform={"uppercase"} mb={4}>Claim Vessel</Heading>
                <Text fontFamily={"Raleway"} mb={4}>Be aware you are only entitled to claim a single vessel.<br /><br />This mint is free-of-charge.</Text>
                <Button
                    isDisabled={!window.ethereum || pending}
                    pointerEvents={pending ? "none" : "auto"}
                    bg="#25434F"
                    color="samaWhite"
                    fontFamily={"Orbitron"}
                    fontSize={"md"}
                    letterSpacing={1.5}
                    rounded={"sm"}
                    borderColor={"samaTeal.500"}
                    borderWidth={0.5}
                    onClick={chain?.id !== mantaTestnet.id ? async () => await handleNetworkSwitching(mantaTestnet.id) : handleSubmit}
                    cursor={"pointer"}
                    _active={{
                        background: isMobile && "samaTeal.500"
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
                    {getButtonContent()}
                </Button>
            </Box>
        </ScreenBackdrop>
    )
}