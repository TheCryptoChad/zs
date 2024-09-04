import { Flex, Heading, Button, Spinner, Text, Image, Tooltip } from "@chakra-ui/react";
import { Dispatch, SetStateAction, useEffect } from "react";
import { BrowserProvider, Contract, JsonRpcSigner } from "ethers";
import { ScreenBackdrop } from "../../utils/ScreenBackdrop";
import { addTokenToWallet } from "./AddTokenToWallet";
import { useNetwork } from "wagmi";
import { handleNetworkSwitching, mantaTestnet, supportedChains } from "../../../../utils/chains/chains";
import { isMobile } from "react-device-detect";
import { API } from "../../../../api/api";
import { useQuery } from "react-query";
import { queryClient } from "../../../../main";

type GameHeaderClaimModalProps = {
    data: Entity.Resources;
    claimResources: Function;
    isClaimOpen: boolean;
    setIsClaimOpen: Dispatch<SetStateAction<boolean>>;
    setPending: Dispatch<SetStateAction<boolean>>;
    setWeb3: Function;
    pending: boolean;
    userData: Entity.Self | undefined; 
    web3: { astraliteContract?: Contract; samariumContract?: Contract; calamariteContract?: Contract; signer?: JsonRpcSigner };
};

export const GameHeaderClaimModal = ({ data, claimResources, setIsClaimOpen, setPending, setWeb3, pending, userData, web3 }: GameHeaderClaimModalProps) => {
    const { chain } = useNetwork();

    useEffect(() => {
		if(window.ethereum) {
            (async () => await accountChanged())();
			window.ethereum.on("accountsChanged", async () => await accountChanged());
		}
		return () => {
			if(window.ethereum){
				window.ethereum.removeListener("accountsChanged", async () => await accountChanged());
			}
		};
	}, []);

    const accountChanged = async () => {
        const provider: BrowserProvider = new BrowserProvider((window as any).ethereum);
        web3.signer = await provider.getSigner();
        setWeb3({ ...web3 });
        queryClient.invalidateQueries("walletData");
        setWeb3({ ...web3 });
    }

    const { data: walletData } = useQuery({
        queryKey: "walletData",
        queryFn: () => {
            return userData?.address !== web3?.signer?.address.toLowerCase()
        },
        enabled: !!userData?.address
    });

    const censorAddress = (address: string): string => {
		if (!address) return "";
		const firstHalf = address.substring(0, 5);
		const secondHalf = address.substring(address.length - 4, address.length);
		return `${firstHalf}...${secondHalf}`;
	};

    return (
        <ScreenBackdrop handleBackdropClick={pending ? () => {} : () => {}}>
            <Flex
                h={"auto"}
                flexDirection="column"
                justifyContent="space-around"
                gap={isMobile ? 1 : 5}
                className="gildedBorder"
                zIndex={101}
                color={"samaWhite"}
                bg="samaBlack"
                p={5}
                borderWidth={2}
                boxShadow="lg"
            >
                <Heading
                    fontFamily={"Orbitron"}
                    color={"samaTeal.500"}
                    fontSize={isMobile ? "x-large" : "xx-large"}
                    letterSpacing={2}
                    textAlign="center"
                    textTransform={"uppercase"}
                    mb={4}
                >
                    Claim Resources
                </Heading>
                <Text
                    textAlign="center"
                    fontFamily={"Raleway"}
                    mb={4}
                >
                    Turn your in-game resources into blockchain-native tokens you can use 
                    <br />
                    for crafting upgrades for your vessel!
                    <br />
                    <br />
                    You will first be prompted to send ETH to an address, this is required
                    <br />
                    to cover gas costs to allocate minting rights to your address on the blockchain.
                    <br />
                    <br />
                    <b>Click on each resource to add it to your wallet.</b>
                </Text>
                <Flex
                    alignItems="center"
                    justifyContent="space-around"
                    mb={4}
                >
                    {Object.entries(data).map(([key]: [string, number], index: number) => {
                        if (index < 3) {
                            return (
                                <Image
                                    key={key}
                                    borderRadius="20%"
                                    _hover={{ boxShadow: "0px 0px 5px #FFFFFF", cursor: "pointer" }}
                                    onClick={Object.keys(supportedChains).includes(String(chain?.id)) ? () => addTokenToWallet(chain?.id, key) : async () => await handleNetworkSwitching(mantaTestnet.id)}
                                    src={`./resources/${key}.png`}
                                    h={isMobile ? 20 : 24}
                                />
                            )
                        }
                    })}
                </Flex>
                <Tooltip label={walletData ? `Switch to linked address: ${censorAddress(userData?.address || "")}` : ""}>
                    <Button
                        isDisabled={!window.ethereum || pending || walletData}
                        pointerEvents={pending ? "none" : "auto"}
                        bg="#25434F"
                        color="samaWhite"
                        fontFamily={"Orbitron"}
                        fontSize={"md"}
                        letterSpacing={1.5}
                        rounded={"sm"}
                        borderColor={"samaTeal.500"}
                        borderWidth={0.5}
                        onClick={async () => {
                            setPending(true);
                            claimResources();
                        }}
                        cursor={"pointer"}
                        _hover={{
                            background: "#0EEBA8",
                            color: "#191919",
                            transform: "translateY(-3px)",
                            boxShadow: "0px 3px 10px #0EEBA8",
                        }}
                        transition="0.3s"
                        textTransform={"uppercase"}
                    >
                        {!window.ethereum ? "No Wallet Detected" : pending ? <Spinner color="samaTeal.500" /> : "Claim"}
                    </Button>
                </Tooltip>
                <Flex justifyContent="center">
                    <Tooltip label="Cancelling mints will allow you to leave this screen, but you won't be able to claim these resources later.">
                        <Text textAlign="center" color="gray.600" _hover={{cursor: "pointer", color: "samaWhite"}} onClick={async () => {
                            await API.resources.clearPendingBalances();
                            setIsClaimOpen(false);
                        }}>
                            Cancel Mint
                        </Text>
                    </Tooltip>
                </Flex>
            </Flex>
        </ScreenBackdrop>
    );
};