import { Flex, Heading, Button, Spinner, Text, Tabs, TabList, TabPanels, Tab, TabPanel, SimpleGrid, TabIndicator } from "@chakra-ui/react";
import { isMobile } from "react-device-detect";
import { ScreenBackdrop } from "../../utils/ScreenBackdrop";
import { supportedChains } from "../../../../utils/chains/chains";
import { useEffect } from "react";
import { useQuery } from "react-query";
import { API } from "../../../../api/api";

export const GameHeaderNetworkModal = ({ pending, selectedNetworks, setIsNetworkOpen, setNetworks, setPending, setSelectedNetworks }: any) => {
	useEffect(() => {}, [selectedNetworks]);

	const { data } = useQuery<{[key: number]: Entity.Resources}>({
		queryKey: "all-resources",
		queryFn: API.resources.getAll,
	});

	return (
		<ScreenBackdrop handleBackdropClick={pending ? () => {} : () => setIsNetworkOpen(false)}>
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
					You can mint your resources on multiple networks.
					<br />
					<br />
					Select which networks you want to mint resources on.
					<br />
					<br />
					<b>
						Mainnets will require real funds to transact, if you select
						<br />
						a network, you won't be able to mint new resources
						<br />
						until the first batch has been successfully minted!
					</b>
				</Text>

				<Tabs align="center" variant="unstyled" isFitted>
					<TabList>
						<Tab _selected={{ color: 'samaTeal.500' }} _hover={{ color: 'samaTeal.500' }}>All Networks</Tab>
						<Tab _selected={{ color: 'samaTeal.500' }} _hover={{ color: 'samaTeal.500' }}>Mainnets</Tab>
						<Tab _selected={{ color: 'samaTeal.500' }} _hover={{ color: 'samaTeal.500' }}>Testnets</Tab>
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
										const disable = data ? Object.values(data?.[Number(chain.id)]).reduce((accumulator, currentValue) => { return Number(accumulator) + Number(currentValue)}, 0) === 0 : true;
										return (
											<Button
												key={index}
                                                justifySelf="center"
												_hover={{ background: "#0EEBA8", color: "#191919", transform: "translateY(-3px)", boxShadow: "0px 3px 10px #0EEBA8" }}
												bg={selectedNetworks[chain.id] === true ? "#0EEBA8" : "#25434F"}
												color={selectedNetworks[chain.id] === true ? "#191919" : "samaWhite"}
												fontFamily={"Orbitron"}
												fontSize={"sm"}
												isDisabled={disable}
												width={"180px"}
												letterSpacing={1.4}
												rounded={"sm"}
												borderColor={"samaTeal.500"}
												borderWidth={0.5}
												onClick={() => {
													selectedNetworks[chain.id] = !selectedNetworks[chain.id];
													setSelectedNetworks({ ...selectedNetworks });
												}}
											>
												{chain.name}
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
										const disable = data ? Object.values(data?.[Number(chain.id)]).reduce((accumulator, currentValue) => { return Number(accumulator) + Number(currentValue)}, 0) === 0 : true;
										return (
											<Button
												key={index}
                                                justifySelf="center"
												_hover={{ background: "#0EEBA8", color: "#191919", transform: "translateY(-3px)", boxShadow: "0px 3px 10px #0EEBA8" }}
												bg={selectedNetworks[chain.id] === true ? "#0EEBA8" : "#25434F"}
												color={selectedNetworks[chain.id] === true ? "#191919" : "samaWhite"}
												display={!["all", "mainnet"].includes(chain.type) ? "none" : "flex"}
												fontFamily={"Orbitron"}
												fontSize={"sm"}
												isDisabled={disable}
												width={"180px"}
												letterSpacing={1.4}
												rounded={"sm"}
												borderColor={"samaTeal.500"}
												borderWidth={0.5}
												onClick={() => {
													selectedNetworks[chain.id] = !selectedNetworks[chain.id];
													setSelectedNetworks({ ...selectedNetworks });
												}}
											>
												{chain.name}
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
										const disable = data ? Object.values(data?.[Number(chain.id)]).reduce((accumulator, currentValue) => { return Number(accumulator) + Number(currentValue)}, 0) === 0 : true;
										return (
											<Button
												key={index}
                                                justifySelf="center"
												_hover={{ background: "#0EEBA8", color: "#191919", transform: "translateY(-3px)", boxShadow: "0px 3px 10px #0EEBA8" }}
												bg={selectedNetworks[chain.id] === true ? "#0EEBA8" : "#25434F"}
												color={selectedNetworks[chain.id] === true ? "#191919" : "samaWhite"}
												display={!["all", "testnet"].includes(chain.type) ? "none" : "flex"}
												fontFamily={"Orbitron"}
												fontSize={"sm"}
												isDisabled={disable}
												width={"180px"}
												letterSpacing={1.4}
												rounded={"sm"}
												borderColor={"samaTeal.500"}
												borderWidth={0.5}
												onClick={() => {
													selectedNetworks[chain.id] = !selectedNetworks[chain.id];
													setSelectedNetworks({ ...selectedNetworks });
												}}
											>
												{chain.name}
											</Button>
										);
									})}
							</SimpleGrid>
						</TabPanel>
					</TabPanels>
				</Tabs>

				<Button
					isDisabled={pending || Object.values(selectedNetworks).every((value) => value === false)}
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
						await setNetworks();
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
					{pending ? <Spinner color="samaTeal.500" /> : "Set Networks"}
				</Button>
			</Flex>
		</ScreenBackdrop>
	);
};
