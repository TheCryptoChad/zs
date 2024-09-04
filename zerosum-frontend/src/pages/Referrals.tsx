import { Box, Button, Grid, Heading, Spinner, Table, Image, TableContainer, Tbody, Td, Th, Thead, Tr, VStack, Text, Tooltip, Input, Flex } from "@chakra-ui/react";
import { useEffect, useState } from "react";
import { useQuery } from "react-query";
import { API } from "../api/api";
import { isMobile } from "react-device-detect";
import { MaintenaceBanner } from "../components/ui/maintenance/MaintenanceBanner";
import { JsonRpcSigner, Contract, BrowserProvider } from "ethers";
import { handleNetworkSwitching, supportedChains } from "../utils/chains/chains";
import { queryClient } from "../main";
import { CopyIcon } from "@chakra-ui/icons";
import Arrow from "../assets/icons/arrow.png";

export const Referrals = () => {
	const [pending, setPending] = useState<boolean>(false);
	const [web3, setWeb3] = useState<{ contract?: Contract; signer?: JsonRpcSigner }>({});

	useEffect(() => {
		if(window.ethereum){
			window.ethereum.on("accountsChanged", async () => {
				const provider: BrowserProvider = new BrowserProvider((window as any).ethereum);
				web3.signer = await provider.getSigner();
				setWeb3({ ...web3 });
				if (web3.signer?.address.toLowerCase() === userData?.address?.toLowerCase()) queryClient.invalidateQueries("referrer");
			});
		}
		return () => {
			if(window.ethereum){
				window.ethereum.removeListener("accountsChanged", async () => {
					const provider: BrowserProvider = new BrowserProvider((window as any).ethereum);
					web3.signer = await provider.getSigner();
					setWeb3({ ...web3 });
					if (web3.signer?.address.toLowerCase() === userData?.address?.toLowerCase()) queryClient.invalidateQueries("referrer");
				});
			}
		};
	}, []);

	const { data: userData, isLoading: isUserLoading } = useQuery<Entity.Self>("user", API.user.getSelf, { staleTime: Infinity });

	const { data: referrerData } = useQuery({
		queryKey: "referrer",
		queryFn: async (): Promise<{address: string, messageWithNonce: string, signedMessage: string} | undefined> => {
			const { referralAbi } = await API.blockchain.getAbi();
			const provider: BrowserProvider = new BrowserProvider((window as any).ethereum);
			web3.signer = await provider.getSigner();
			web3.contract = new Contract(supportedChains[3_441_005].referrals, referralAbi, web3.signer);
			const referralCode: string | undefined = userData?.pendingReferral;
			if (referralCode) {
				const {address, messageWithNonce, signedMessage} = await API.user.getReferral(referralCode);
				return {address, messageWithNonce, signedMessage};
			}
			return undefined;
		},
		staleTime: Infinity,
		enabled: !!userData?.pendingReferral
	});

	const censorAddress = (address: string): string => {
		if (!address) return "";
		const firstHalf = address.substring(0, 5);
		const secondHalf = address.substring(address.length - 4, address.length);
		return `${firstHalf}...${secondHalf}`;
	};

	const mintReferralNft = async (): Promise<void> => {
		try {
			setPending(true);
			if (Number(window.ethereum.networkVersion) !== 3_441_005) await handleNetworkSwitching(3_441_005);
			const message: string = referrerData?.messageWithNonce.substring(0, 21) || "";
			const nonce: bigint = BigInt(referrerData?.messageWithNonce.substring(21) || "");
			
			const tx = await web3.contract?.safeMint(referrerData?.address, message, nonce, referrerData?.signedMessage);
			if (tx) {
				await tx.wait();
				queryClient.invalidateQueries("user");
			} else {
				throw Error("Transaction failed");
			}
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	};

	return (
		<Box
			h={"full"}
			overflowY={"auto"}
			position="relative"
		>
			<Button
                w={isMobile ? 9 : 10}
                h={isMobile ? 9 : 10}
                p={isMobile ? 1.5 : 2}
                bg="#25434F"
                color="samaWhite"
                fontFamily={"Orbitron"}
                fontSize={"small"}
                letterSpacing={1.5}
                rounded={"sm"}
                borderColor={"samaTeal.500"}
                borderWidth={0.5}
                onClick={() => window.location.href = "/game"}
                cursor={"pointer"}
                _hover={{
                    background: "#0EEBA8",
                    color: "#191919",
                    transform: "translateY(-3px)",
                    boxShadow: "0px 3px 10px #0EEBA8",
                }}
                transition="0.3s"
                textTransform={"uppercase"}
                position="absolute"
                top="5%"
                left="5%"
            >
                <Image src={Arrow} />
            </Button>
			{import.meta.env.VITE_MAINTENANCE_MODE === "true" && <MaintenaceBanner />}
			<VStack p={8}>
				<Heading
					textTransform={"uppercase"}
					letterSpacing={2}
					fontFamily={"Orbitron"}
					textColor={"samaTeal.500"}
					mb={5}
				>
					Referrals
				</Heading>
				{isUserLoading ? (
					<Spinner
						mt={5}
						color="samaTeal.500"
					/>
				) : (
					<>
						<Text
							textAlign="center"
							my={5}
							color={"samaWhite"}
						>
							Invite new players or refer ZeroSum veterans to mint a referral NFT. <br />
							Accumulate referrals to climb the leaderboard and earn in-game bonuses!
						</Text>
						{userData?.referralCode && (
							<Flex
								width="35%"
								mb={5}
								color="samaWhite"
								alignItems="center"
								justifyContent="space-evenly"
								gap={3}
							>
								<Input
									disabled
									id="referral-link"
									flex={1}
									value={`https://zerosum.moonsama.com/?referral=${userData?.referralCode}`}
								/>
								<CopyIcon
									p={2}
									boxSize={10}
									bg={"#25434F"}
									rounded={"md"}
									borderColor={"samaTeal.500"}
									borderWidth={0.5}
									_active={{ background: isMobile && "samaTeal.500" }}
									_hover={{ cursor: "pointer", background: "#0EEBA8", color: "#191919", transform: "translateY(-3px)", boxShadow: "0px 3px 10px #0EEBA8" }}
									transition="0.3s"
									aria-label="copy"
									onClick={async () => await navigator.clipboard.writeText((document.getElementById("referral-link") as HTMLInputElement).value)}
								/>
							</Flex>
						)}
						{referrerData && !userData?.referredBy ? (
							<Tooltip placement="top" label={`${web3.signer?.address.toLowerCase() !== userData?.address ? `Switch to linked address: ${censorAddress(userData?.address || "")}` : userData?.address === referrerData?.address ? "You can't refer yourself" : ""}`}>
								<Button
									mb={5}
									bg={"#25434F"}
									color={"samaWhite"}
									fontFamily={"Orbitron"}
									fontSize={"xs"}
									width={"200px"}
									letterSpacing={1.4}
									rounded={"sm"}
									borderColor={"samaTeal.500"}
									borderWidth={0.5}
									onClick={async () => await mintReferralNft()}
									_hover={{ background: "#0EEBA8", color: "#191919", transform: "translateY(-3px)", boxShadow: "0px 3px 10px #0EEBA8" }}
									transition="0.3s"
									textTransform={"uppercase"}
									isDisabled={pending || web3.signer?.address.toLowerCase() !== userData?.address || userData?.address === referrerData?.address}
								>
									{pending ? <Spinner color="samaTeal.500" /> : "Mint Referral NFT"}
								</Button>
							</Tooltip>
						) : (
							<Grid
								mb={4}
								templateColumns="repeat(2, 1fr)"
								gap={2}
								color="samaWhite"
								alignItems="center"
							>
								<Text
									color="#0EEBA8"
									fontSize="1.5em"
								>
									Referred By:
								</Text>
								<Text fontSize="1.5em">{userData?.referredBy && censorAddress(userData?.referredBy)}</Text>
							</Grid>
						)}
						<TableContainer
							fontFamily={"Raleway"}
							letterSpacing={1}
							textColor={"samaWhite"}
						>
							<Table variant="simple">
								<Thead>
									<Tr>
										<Th
											textAlign="center"
											color="#0EEBA8"
											fontSize="1.5em"
										>
											Your Referrals
										</Th>
									</Tr>
								</Thead>
								<Tbody>
									{userData?.referrals?.map((referral: string, index: number) => {
										return (
											<Tr
												color="samaWhite"
												key={index}
											>
												<Td textAlign="center">{censorAddress(referral)}</Td>
											</Tr>
										);
									})}
								</Tbody>
							</Table>
						</TableContainer>
					</>
				)}
			</VStack>
		</Box>
	);
};
