import { Flex, Heading, Button, Spinner, Text, Tabs, TabList, TabPanels, Tab, TabPanel, SimpleGrid, TabIndicator } from "@chakra-ui/react";
import { isMobile } from "react-device-detect";
import { handleNetworkSwitching, supportedChains } from "../../../utils/chains/chains";
import { ScreenBackdrop } from "../../ui/utils/ScreenBackdrop";
import { useState } from "react";

export const WorkbenchNetworkModal = ({ setIsNetworkOpen }: any) => {
	const [pending, setPending] = useState<boolean>(false);

	const changeNetwork = async (id: number) => {
		try {
			setPending(true);
			await handleNetworkSwitching(id);
		} catch (error: any) {
			console.log(error);
		} finally {
			setIsNetworkOpen(false);
			setPending(false);
		}
	};

	return (
		<ScreenBackdrop handleBackdropClick={() => setIsNetworkOpen(false)}>
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
					Supported Networks
				</Heading>
				<Text
					textAlign="center"
					fontFamily={"Raleway"}
					mb={4}
				>
					You can choose which network to craft upgrades on.
					<br />
					<br />
					{`Keep in mind that resources for each network are separate (for now).`}
				</Text>

				<Tabs
					align="center"
					variant="unstyled"
					isFitted
				>
					<TabList>
						<Tab
							_selected={{ color: "samaTeal.500" }}
							_hover={{ color: "samaTeal.500" }}
						>
							All Networks
						</Tab>
						<Tab
							_selected={{ color: "samaTeal.500" }}
							_hover={{ color: "samaTeal.500" }}
						>
							Mainnets
						</Tab>
						<Tab
							_selected={{ color: "samaTeal.500" }}
							_hover={{ color: "samaTeal.500" }}
						>
							Testnets
						</Tab>
					</TabList>
					<TabIndicator
						color="samaTeal.500"
						mt="-1.5px"
						height="2px"
						bg="samaTeal.500"
						borderRadius="1px"
					/>
					<TabPanels>
						<TabPanel>
							<SimpleGrid
								columns={2}
								gap={5}
							>
								{Object.values(supportedChains)
									.reverse()
									.map((chain, index) => {
										const currentNetwork: number = Number(window.ethereum.networkVersion);
										return (
											<Button
												key={index}
												justifySelf="center"
												_hover={{ background: "#0EEBA8", color: "#191919", transform: "translateY(-3px)", boxShadow: "0px 3px 10px #0EEBA8" }}
												bg={currentNetwork === chain.id ? "#0EEBA8" : "#25434F"}
												color={currentNetwork === chain.id ? "#191919" : "samaWhite"}
												fontFamily={"Orbitron"}
												fontSize={"sm"}
												isDisabled={pending || currentNetwork === chain.id}
												width={"180px"}
												letterSpacing={1.4}
												rounded={"sm"}
												borderColor={"samaTeal.500"}
												borderWidth={0.5}
												onClick={async () => await changeNetwork(chain.id)}
											>
												{pending ? <Spinner color="samaTeal.500" /> : chain.name}
											</Button>
										);
									})}
							</SimpleGrid>
						</TabPanel>
						<TabPanel>
							<SimpleGrid
								columns={2}
								gap={5}
							>
								{Object.values(supportedChains)
									.reverse()
									.map((chain, index) => {
										const currentNetwork: number = Number(window.ethereum.networkVersion);
										return (
											<Button
												key={index}
												justifySelf="center"
												_hover={{ background: "#0EEBA8", color: "#191919", transform: "translateY(-3px)", boxShadow: "0px 3px 10px #0EEBA8" }}
												bg={currentNetwork === chain.id ? "#0EEBA8" : "#25434F"}
												color={currentNetwork === chain.id ? "#191919" : "samaWhite"}
												display={!["all", "mainnet"].includes(chain.type) ? "none" : "flex"}
												fontFamily={"Orbitron"}
												fontSize={"sm"}
												isDisabled={pending || currentNetwork === chain.id}
												width={"180px"}
												letterSpacing={1.4}
												rounded={"sm"}
												borderColor={"samaTeal.500"}
												borderWidth={0.5}
												onClick={async () => await changeNetwork(chain.id)}
											>
												{pending ? <Spinner color="samaTeal.500" /> : chain.name}
											</Button>
										);
									})}
							</SimpleGrid>
						</TabPanel>
						<TabPanel>
							<SimpleGrid
								columns={2}
								gap={5}
							>
								{Object.values(supportedChains)
									.reverse()
									.map((chain, index) => {
										const currentNetwork: number = Number(window.ethereum.networkVersion);
										return (
											<Button
												key={index}
												justifySelf="center"
												_hover={{ background: "#0EEBA8", color: "#191919", transform: "translateY(-3px)", boxShadow: "0px 3px 10px #0EEBA8" }}
												bg={currentNetwork === chain.id ? "#0EEBA8" : "#25434F"}
												color={currentNetwork === chain.id ? "#191919" : "samaWhite"}
												display={!["all", "testnet"].includes(chain.type) ? "none" : "flex"}
												fontFamily={"Orbitron"}
												fontSize={"sm"}
												isDisabled={pending || currentNetwork === chain.id}
												width={"180px"}
												letterSpacing={1.4}
												rounded={"sm"}
												borderColor={"samaTeal.500"}
												borderWidth={0.5}
												onClick={async () => await changeNetwork(chain.id)}
											>
												{pending ? <Spinner color="samaTeal.500" /> : chain.name}
											</Button>
										);
									})}
							</SimpleGrid>
						</TabPanel>
					</TabPanels>
				</Tabs>
			</Flex>
		</ScreenBackdrop>
	);
};
