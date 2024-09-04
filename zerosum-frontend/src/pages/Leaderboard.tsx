import {
	Box,
	Button,
	Grid,
	Heading,
	Image,
	Spinner,
	Switch,
	Table,
	TableContainer,
	Tbody,
	Td,
	Th,
	Thead,
	Tr,
	VStack,
	FormLabel,
	Menu,
	MenuList,
	MenuItem,
	MenuButton,
	Flex,
	Tooltip,
} from "@chakra-ui/react";
import { Dispatch, SetStateAction, useState } from "react";
import { useQuery } from "react-query";
import { API } from "../api/api";
import TrophyIcon from "../assets/icons/trophy_icon.svg";
import { isMobile } from "react-device-detect";
import { supportedChains } from "../utils/chains/chains";
import { MaintenaceBanner } from "../components/ui/maintenance/MaintenanceBanner";
import { QuestionOutlineIcon } from "@chakra-ui/icons";
import Arrow from "../assets/icons/arrow.png";

type LeaderboardUserStat = {
	position: number;
	image: string;
	address: Config.HexString;
	stat: number;
};

type Dashboard = {
	[key: string]: number;
};

type LoginTracker = {
	date: number;
	totalLogins: number;
};

type Resource = "astralite" | "samarium" | "calamarite" | "all";
type Stat = "amount" | "tx" | "faucet" | "gas";
type LoginType = "total" | "consecutive" | "daily" | "referrals" | "";

export const Leaderboard = () => {
	const [resource, setResource] = useState<Resource>("all");
	const [stat, setStat] = useState<Stat>("amount");
	const [chain, setChain] = useState<number>(0);
	const [loginType, setLoginType] = useState<LoginType>("");

	const { data: leaderboardData, isLoading: isLeaderboardLoading } = useQuery<LeaderboardUserStat[]>(
		["stats", resource, stat, chain],
		() => API.stats.fetchStats(resource, stat, "leaderboard", chain),
		{ staleTime: Infinity }
	);

	const { data: dashboardData, isLoading: isDashboardLoading } = useQuery<Dashboard>(["dashboard", chain], () => API.stats.fetchStats(resource, stat, "dashboard", chain), { staleTime: Infinity });

	const { data: loginData, isLoading: isLoginLoading } = useQuery<LeaderboardUserStat[] | LoginTracker[]>(["login", loginType], () => API.stats.fetchLogins(loginType), { staleTime: Infinity });

	const { data: userData } = useQuery<Entity.Self>("user", API.user.getSelf, { staleTime: Infinity });

	const isUser = (partialAddr: string): boolean => {
		if (!partialAddr) return false;
		const partialAddrInitial = partialAddr.substring(0, 5);
		const userAddrInitial = userData?.address?.substring(0, 5);

		const partialAddrFinal = partialAddr.substring(partialAddr.length - 4, partialAddr.length);
		const userAddrFinal = userData?.address?.substring(userData?.address?.length - 4, userData?.address?.length);

		return (partialAddrInitial === userAddrInitial && partialAddrFinal === userAddrFinal) || userData?.username === partialAddr;
	};

	const determineGlobalStat = (resource: string, stat: string): string => {
		try {
			if (!dashboardData) return "";

			if (resource === "all") {
				return (
					Number(dashboardData[`astralite${stat.charAt(0).toUpperCase() + stat.slice(1)}`]) +
					Number(dashboardData[`samarium${stat.charAt(0).toUpperCase() + stat.slice(1)}`]) +
					Number(dashboardData[`calamarite${stat.charAt(0).toUpperCase() + stat.slice(1)}`])
				).toLocaleString();
			}

			const columnName: string = ["amount", "tx"].includes(stat) ? `${resource}${stat.charAt(0).toUpperCase() + stat.slice(1)}` : stat === "faucet" ? "faucetUses" : "gasTx";
			return Number(dashboardData[columnName]).toLocaleString();
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	};

	const formatDate = (timestamp: number): string => {
		const date: Date = new Date(timestamp);
		const day: string = date.getDate().toString().padStart(2, "0");
		const month: string = (date.getMonth() + 1).toString().padStart(2, "0");
		const year: number = date.getFullYear();
		return `${day}/${month}/${year}`;
	};

	const chains = [{ name: "All Networks", id: 0 }, ...Object.values(supportedChains)];

	const data = loginType ? loginData : leaderboardData;

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
				>
					Leaderboard
				</Heading>
				<Image
					src={TrophyIcon}
					my={12}
				/>
				<Menu isLazy>
					<MenuButton
						as={Button}
						display="flex"
						justifyContent="center"
						alignItems="center"
						_hover={{ bg: "samaTeal.500", color: "samaBlack", transform: "translateY(-3px)", boxShadow: "0px 3px 10px #0EEBA8" }}
						_active={{ bg: "samaTeal.500", color: "samaBlack", transform: "translateY(-3px)", boxShadow: "0px 3px 10px #0EEBA8" }}
						mb={4}
						bg={"#25434F"}
						color={"samaWhite"}
						fontFamily={"Orbitron"}
						fontSize={"xs"}
						width={"200px"}
						letterSpacing={1.4}
						rounded={"sm"}
						borderColor={"samaTeal.500"}
						borderWidth={0.5}
					>
						{chains.find((chains) => chains.id === chain)?.name?.toUpperCase()}
					</MenuButton>
					<MenuList my={0}>
						{chains.map((chainItem, index) => {
							if (chainItem.id !== 2109) {
								return (
									<MenuItem
										key={index}
										textTransform="capitalize"
										color={chainItem.id === chain ? "samaWhite" : ""}
										bg={chainItem.id === chain ? "samaTeal.500" : ""}
										onClick={() => {
											setResource("astralite");
											setStat("amount");
											setChain(chainItem.id);
											setLoginType("");
										}}
									>
										{chainItem.name}
									</MenuItem>
								);
							}
						})}
					</MenuList>
				</Menu>
				<Grid
					mb={4}
					templateColumns={{ base: "repeat(2, 1fr)", md: `${chain === 3_441_005 ? "repeat(5, 1fr)" : "repeat(4, 1fr)"}` }}
					gap={2}
				>
					<FilterButton
						name="amounts"
						active={!loginType && stat === "amount"}
						setResource={setResource}
						setStat={setStat}
						setLoginType={setLoginType}
					/>
					<FilterButton
						name="transactions"
						active={!loginType && stat === "tx"}
						setResource={setResource}
						setStat={setStat}
						setLoginType={setLoginType}
					/>
					{chain === 3_441_005 && (
						<FilterButton
							name="faucet calls"
							active={!loginType && stat === "faucet"}
							setResource={setResource}
							setStat={setStat}
							setLoginType={setLoginType}
						/>
					)}
					<FilterButton
						name="gas"
						active={!loginType && stat === "gas"}
						setResource={setResource}
						setStat={setStat}
						setLoginType={setLoginType}
					/>
					<FilterButton
						name="user"
						active={Boolean(loginType)}
						setResource={setResource}
						setStat={setStat}
						setLoginType={setLoginType}
					/>
				</Grid>
				<Grid
					display={["amount", "tx"].includes(stat) && !loginType ? "grid" : "none"}
					mb={4}
					templateColumns={{ base: "repeat(2, 1fr)", md: "repeat(4, 1fr)" }}
					gap={2}
				>
					<FilterButton
						name="all"
						active={resource === "all"}
						setResource={setResource}
						setStat={setStat}
						setLoginType={setLoginType}
					/>
					<FilterButton
						name="astralite"
						active={resource === "astralite" && ["amount", "tx"].includes(stat)}
						setResource={setResource}
						setStat={setStat}
						setLoginType={setLoginType}
					/>
					<FilterButton
						name="samarium"
						active={resource === "samarium"}
						setResource={setResource}
						setStat={setStat}
						setLoginType={setLoginType}
					/>
					<FilterButton
						name="calamarite"
						active={resource === "calamarite"}
						setResource={setResource}
						setStat={setStat}
						setLoginType={setLoginType}
					/>
				</Grid>
				<Grid
					display={loginType ? "grid" : "none"}
					mb={4}
					templateColumns={{ base: "repeat(2, 1fr)", md: "repeat(4, 1fr)" }}
					gap={2}
				>
					<FilterButton
						name="daily users"
						active={loginType === "daily"}
						setResource={setResource}
						setStat={setStat}
						setLoginType={setLoginType}
					/>
					<FilterButton
						name="total logins"
						active={loginType === "total"}
						setResource={setResource}
						setStat={setStat}
						setLoginType={setLoginType}
					/>
					<FilterButton
						name="consecutive logins"
						active={loginType === "consecutive"}
						setResource={setResource}
						setStat={setStat}
						setLoginType={setLoginType}
					/>
					<FilterButton
						name="referrals"
						active={loginType === "referrals"}
						setResource={setResource}
						setStat={setStat}
						setLoginType={setLoginType}
					/>
				</Grid>
				{isLeaderboardLoading || isDashboardLoading || isLoginLoading ? (
					<Spinner
						mt={10}
						color="samaTeal.500"
					/>
				) : (
					<TableContainer
						fontFamily={"Raleway"}
						letterSpacing={1}
						textColor={"samaWhite"}
					>
						<Table variant="simple">
							<Thead>
								<Tr>
									<Th fontSize="1.5em">{!loginType && "Total: "}</Th>
									<Th
										color="#0EEBA8"
										fontSize="1.5em"
									>
										{!loginType && determineGlobalStat(resource, stat)}
									</Th>
									<Th
										display="flex"
										flexDirection="row"
										alignItems="center"
										justifyContent="center"
										gap={2}
									>
										<FormLabel
											mt={1.5}
											htmlFor="username-toggle"
											_hover={{ cursor: "pointer" }}
										>
											Username:
										</FormLabel>
										<Switch
											id="username-toggle"
											defaultChecked={userData?.linkedUsername}
											colorScheme="samaTeal"
											size="lg"
											onChange={async () => {
												await API.user.linkUsername();
												location.reload();
											}}
										/>
										<Tooltip label="Making your Moonama Username visible also enables your Customizer Avatar.">
											<QuestionOutlineIcon
												boxSize={5}
												_hover={{ cursor: "pointer", color: "samaWhite" }}
											/>
										</Tooltip>
									</Th>
								</Tr>
								<Tr>
									<Th>{loginType === "daily" ? "Date" : "#"}</Th>
									<Th>{loginType !== "daily" && "Address"}</Th>
									<Th isNumeric>{stat === "amount" || loginType ? "Amount" : stat === "faucet" ? "Calls" : "Txs"}</Th>
								</Tr>
							</Thead>
							<Tbody>
								{data?.map((userStat: any, index: number) => {
									return (
										<Tr
											textColor={isUser(userStat.address) ? "samaTeal.500" : "white"}
											key={index}
										>
											<Td>{loginType === "daily" ? formatDate(Number(userStat.date)) : userStat.position}</Td>
											<Td>
												{loginType !== "daily" && (
													<Flex
														gap={2}
														alignItems="center"
														justifyContent="flex-start"
													>
														<Image
															borderRadius="20%"
															src={userStat.address === "TheCryptoChad" ? "/ots_teaser.png" : userStat.image}
															boxSize={10}
														/>
														{userStat.address}
														{isUser(userStat.address) ? " (you)" : ""}
													</Flex>
												)}
											</Td>
											<Td isNumeric>{loginType === "daily" ? Number(userStat.totalLogins)?.toLocaleString() : (userStat.stat || 0)?.toLocaleString()}</Td>
										</Tr>
									);
								})}
							</Tbody>
						</Table>
					</TableContainer>
				)}
			</VStack>
		</Box>
	);
};

const FilterButton = ({
	name,
	active,
	setResource,
	setStat,
	setLoginType,
}: {
	name: string;
	active: boolean;
	setResource: Dispatch<SetStateAction<Resource>>;
	setStat: Dispatch<SetStateAction<Stat>>;
	setLoginType: Dispatch<SetStateAction<LoginType>>;
}) => {
	const activeStyles = {
		background: "#0EEBA8",
		color: "#191919",
		transform: "translateY(-3px)",
		boxShadow: "0px 3px 10px #0EEBA8",
	};

	return (
		<Button
			bg={active ? activeStyles.background : "#25434F"}
			color={active ? activeStyles.color : "samaWhite"}
			fontFamily={"Orbitron"}
			fontSize={"xs"}
			width={"200px"}
			letterSpacing={1.4}
			rounded={"sm"}
			borderColor={"samaTeal.500"}
			borderWidth={0.5}
			onClick={() => {
				switch (name) {
					case "amounts":
						setStat("amount");
						setLoginType("");
						break;
					case "transactions":
						setStat("tx");
						setLoginType("");
						break;
					case "faucet calls":
						setResource("astralite");
						setStat("faucet");
						setLoginType("");
						break;
					case "gas":
						setResource("astralite");
						setStat("gas");
						setLoginType("");
						break;
					case "user":
						setLoginType("daily");
						break;
					case "all":
						setResource("all");
						setLoginType("");
						break;
					case "astralite":
						setResource("astralite");
						setLoginType("");
						break;
					case "samarium":
						setResource("samarium");
						setLoginType("");
						break;
					case "calamarite":
						setResource("calamarite");
						setLoginType("");
						break;
					case "total logins":
						setLoginType("total");
						break;
					case "consecutive logins":
						setLoginType("consecutive");
						break;
					case "daily users":
						setLoginType("daily");
						break;
					case "referrals":
						setLoginType("referrals");
						break;
				}
			}}
			_active={{
				background: isMobile && "samaTeal.500",
			}}
			_hover={!isMobile ? activeStyles : {}}
			transition="0.3s"
			textTransform={"uppercase"}
		>
			{name}
		</Button>
	);
};
