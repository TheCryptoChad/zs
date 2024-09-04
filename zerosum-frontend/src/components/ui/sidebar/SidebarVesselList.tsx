import { VStack, Text, Button, Spinner } from "@chakra-ui/react"
import { Vector3 } from "three";
import { useEventStore } from "../../../stores/useEventStore";
import { useQuery } from "react-query";
import { API } from '../../../api/api';
import { SidebarItem } from "./SidebarItem";
import { useState } from "react";
import { queryClient } from "../../../main";
import { BrowserProvider, ethers } from "ethers";
import { isMobile } from "react-device-detect";
import { useNetwork } from "wagmi";
import { handleNetworkSwitching, mantaTestnet } from "../../../utils/chains/chains";

type SidebarVesselListProps = {
    setDeployingVesselId: (vesselId: number) => void
    handleRegisterToggle: () => void
}

export const SidebarVesselList = ({ setDeployingVesselId, handleRegisterToggle }: SidebarVesselListProps) => {
    const [pending, setPending] = useState<boolean>(false);
    const { chain } = useNetwork()

    const { send } = useEventStore()

    const handleDeployClick = (vesselId: number) => {
        setDeployingVesselId(vesselId)
    }

    const { data: userData } = useQuery({
        queryKey: 'user',
        queryFn: API.user.getSelf
    });

    const { data: vessels, status } = useQuery({
        queryKey: 'vessels',
        queryFn: API.vessel.getAll,
        enabled: !!userData?.address
    });

    const handleUseFaucet = async () => {
        try {
            setPending(true);
            await API.user.useFaucet();
            await queryClient.invalidateQueries('user');
            setTimeout(async () => await queryClient.invalidateQueries('faucet'), 10000);
        } catch (error: any) {
            console.log(error);
            throw error;
        }
        setTimeout(() => setPending(false), 10000);
    }

    const handleGotoClick = (vesselPosition: Vector3) => {

        const event: Zustand.Event = {
            type: "GOTO",
            payload: vesselPosition,
            options: { instant: false }
        };

        send(event);
    };

    const checkFaucetEligibility = async () => {
        try {
            let isUserCritical = false;
            let hasOneHourPassed = false;

            if (userData?.address) {
                const provider = new BrowserProvider(window.ethereum);
                const balance = ethers.formatEther(await provider.getBalance(String(userData?.address)));
                const criticalBalance = 0.00075;
                isUserCritical = Number(balance) <= criticalBalance;
            }

            if (userData?.nextFaucetUse) {
                const date: Date = new Date();
                hasOneHourPassed = Number(userData?.nextFaucetUse) <= date.getTime();
            }

            return (isUserCritical && hasOneHourPassed);
        } catch (error) {
            console.log(error);
            throw error;
        }
    }

    const { data: faucetEligible } = useQuery({
        queryKey: 'faucet',
        queryFn: checkFaucetEligibility,
        enabled: !!userData?.address
    });

    return (
        <>
            <VStack
                height={status === 'success' && vessels.length > 0 ? "full" : "90%"}
                px={1}
                align="start"
                overflowY="auto"
                gap={1}
                mr={isMobile ? 0 : 1}
                mt={isMobile ? 1 : 0}
                css={{
                    '::-webkit-scrollbar': {
                        width: '10px',
                        background: "#191919DD"
                    },
                    '::-webkit-scrollbar-thumb': {
                        background: '#0EEBA8',
                        borderRadius: '3px',
                    },
                }}
            >
                {
                    status === 'success' && vessels.length > 0
                        ? vessels.map((vessel, key) => <SidebarItem key={key} vessel={vessel} handleDeployClick={() => handleDeployClick(vessel.id)} handleGotoClick={() => handleGotoClick(new Vector3(Number(vessel.x), 0, Number(vessel.y)))} />)
                        : <Text w="full" letterSpacing={1.5} mt={4} textAlign={"center"} fontFamily={"Orbitron"} textTransform={'uppercase'}>No vessels</Text>
                }
            </VStack>
            {status === 'success' &&
                <Button
                    mx={4}
                    h={10}
                    mb={4}
                    bg="#25434F"
                    color="samaWhite"
                    fontFamily={"Orbitron"}
                    fontSize={"md"}
                    isDisabled={pending}
                    letterSpacing={1.5}
                    rounded={"sm"}
                    borderColor={"samaTeal.500"}
                    borderWidth={0.5}
                    onClick={chain?.id !== mantaTestnet.id ? async () => await handleNetworkSwitching(mantaTestnet.id) : faucetEligible ? handleUseFaucet : handleRegisterToggle}
                    cursor={"pointer"}
                    _hover={{
                        background: "#0EEBA8",
                        color: "#191919",
                        transform: "translateY(-3px)",
                        boxShadow: "0px 3px 10px #0EEBA8",
                        cursor: "pointer"
                    }}
                    transition="0.3s"
                    textTransform={"uppercase"}
                    display={!faucetEligible && vessels.length > 0 ? "none" : "block"}
                >
                    {chain?.id !== mantaTestnet.id ? "Wrong Network" : pending ? <Spinner color="samaTeal.500"/> : faucetEligible ? "Use Faucet" : "Claim Vessel"}
                </Button>
            }
        </>
    )
}