import { useState, useEffect, Fragment } from "react";
import { useSearchParams, useNavigate } from "react-router-dom";
import { Button, VStack, Image, Text, Spacer, Alert, AlertIcon, CloseButton, useDisclosure, Modal, ModalBody, ModalCloseButton, ModalContent, ModalHeader, ModalOverlay, Accordion, AccordionButton, AccordionIcon, AccordionItem, AccordionPanel, Box, UnorderedList, ListItem, Flex, Circle, useToast } from "@chakra-ui/react";
import { API } from "../api/api";

import { Helpers } from "../utils/helpers";
import { MaintenaceBanner } from "../components/ui/maintenance/MaintenanceBanner";
import { useQuery } from "react-query";
import NetworkSlider from "../components/ui/login/NetworkSlider";
import { isMobile } from "react-device-detect";

export const Login = () => {
	const navigate = useNavigate();
	const [searchParams] = useSearchParams();
	const error = searchParams.get('error');
	const [showError, setShowError] = useState(!!error);
	const [newUpdate, setNewUpdate] = useState<boolean>(false);

	const { isOpen, onOpen, onClose } = useDisclosure();

	const toast = useToast();

	if(isMobile && !toast.isActive("mobile-warn")){
		toast({
			id: "mobile-warn",
			title: `Warning! Mobile use of ZeroSum is experimental, proceed with caution.`,
			duration: 5_000,
			position: "top",
			isClosable: true,
			status: "warning",
			variant: "subtle"
		})
	}

	useEffect(() => {
		if (error) {
			setShowError(true);
		}
	}, [error]);

	if (location.pathname !== '/') {
		return null;
	}

	const referralParams: URLSearchParams = new URLSearchParams(window.location.search);
	const pendingReferral: string | null = referralParams.get("referral");
	if (pendingReferral) localStorage.setItem("pendingReferral", pendingReferral);
	
	const connectSocialPortal = () => {
		try {
			if (!Helpers.auth.isJWTExpired()) return navigate("/game")

			window.location.href =
				`${import.meta.env.VITE_BRIDGE_URL}/oauth?client_id=${import.meta.env.VITE_BRIDGE_APP_ID}` +
				`&redirect_uri=${encodeURIComponent(`${import.meta.env.VITE_FRONTEND_CALLBACK_URL}`)}` +
				`&response_type=code&scope=${encodeURIComponent("user:gamer_tag.read user:uuid.read")}`;

		} catch (error: any) {
			console.log(error);
			throw error;
		}
	};

	const {data} = useQuery<Update[]>({
		queryKey: 'changelog',
		queryFn: () => API.update.getAll()
	})

	useQuery<void>({
		queryKey: 'dates',
		queryFn: () => compareDates("render"),
		enabled: !!data?.[0].date
	})

	const compareDates = (type: "render" | "modal"): void => {
		const lastChangelogDateArray: string[] | undefined = data?.[0].date.split('/');
		const lastSavedDateArray: string[] | undefined = localStorage.getItem("lastSavedDate")?.split('/');

		if(!lastSavedDateArray) {
			localStorage.setItem("lastSavedDate", data?.[0].date!);
			setNewUpdate(true);
			return;
		}

		const lastChangelogDate: Date = new Date(`${lastChangelogDateArray?.[2]}-${lastChangelogDateArray?.[1]}-${lastChangelogDateArray?.[0]}`);
		const lastSavedDate: Date = new Date(`${lastSavedDateArray?.[2]}-${lastSavedDateArray?.[1]}-${lastSavedDateArray?.[0]}`);

		if(lastChangelogDate > lastSavedDate) {
			if(type === "modal") {
				localStorage.setItem("lastSavedDate", data?.[0].date!);
				setNewUpdate(false);
				return;
			} else {
				setNewUpdate(true);
				return;
			}
		} else {
			setNewUpdate(false);
			return;
		}
	};

	const handleCloseError = () => {
		setShowError(false);
		navigate("/");
	};

	const getErrorMessage = () => {
		if (error === "session") {
			return "Your session has expired. Please login again.";
		}
		return "World server is currently down. Try again later.";
	};

	return (
		<Fragment>
			<VStack
				bgImage="url(login/bg.png)"
				backgroundSize="cover"
				backgroundPosition="center"
				width="100%"
				height="100vh"
				display="flex"
				alignItems="center"
				justifyContent="space-between"
			>
				{import.meta.env.VITE_MAINTENANCE_MODE === "true" && <MaintenaceBanner />}
				{showError && (
					<Alert
						status="error"
						position="absolute"
						top="20px"
						w={["90%", "90%", "60%", "50%"]}
						rounded={"sm"}
						bg={"samaBlackFade"}
						color={"samaWhite"}
					>
						<AlertIcon />
						{getErrorMessage()}
						<CloseButton position="absolute" right="8px" top="8px" onClick={handleCloseError} />
					</Alert>
				)}
				<Image mt={10} src="/login/zs_logo.png" height="7.5%" />
				<VStack w="100%">
					<VStack
						className="gildedBorder"
						w={["70%", "30%"]}
						color={"samaWhite"}
						bg={"samaBlackFade"}
						gap={2}
						py={4}
						mb={10}
						boxShadow="5px 5px 5px rgba(0, 0, 0, 0.7)"
					>
						<Spacer />
						<Text fontFamily={"Raleway"} textAlign={"center"} mb={[2, 4]}>Please login to continue</Text>
						<Button
							bg="#25434F"
							color="white"
							fontFamily={"Orbitron"}
							letterSpacing={1.5}
							px={8}
							mb={[0, 4]}
							onClick={connectSocialPortal}
							_hover={{
								background: "#0EEBA8",
								color: "#191919",
								transform: "translateY(-3px)",
								boxShadow: "0px 3px 10px #0EEBA8"
							}}
							transition="0.3s"
						>
							ENTER
						</Button>
					</VStack>
					<Flex
						alignItems="center"
						justifyContent="space-between"
						width={["70%", "30%"]}
						gap={5}
						flexDirection={{base: "column", lg: "row"}}
					>
						<Box m={0} p={0} width="100%" position="relative" transition="0.3s" _hover={{transform: "translateY(-3px)"}}>
							<Button
								bg="#25434F"
								color="samaWhite"
								fontFamily={"Orbitron"}
								fontSize={"small"}
								letterSpacing={1.5}
								rounded={"sm"}
								borderColor={"samaTeal.500"}
								borderWidth={0.5}
								width="100%"
								onClick={() => window.open("https://docs.google.com/document/d/1NIXu3g1t6MGTFp8vqmGV7GPlKksbCk5k0lQGgqyfC6g/edit?usp=sharing", "_blank")}
								cursor={"pointer"}
								_hover={{ background: "#0EEBA8", color: "#191919", transform: "translateY(-3px)", boxShadow: "0px 3px 10px #0EEBA8" }}
								transition="0.3s"
								textTransform={"uppercase"}
							>
								TUTORIAL
							</Button>
						</Box>
						<Box m={0} p={0} width="100%" position="relative" transition="0.3s" _hover={{transform: "translateY(-3px)"}}>
							<Button
								bg="#25434F"
								color="samaWhite"
								fontFamily={"Orbitron"}
								fontSize={"small"}
								letterSpacing={1.5}
								rounded={"sm"}
								width="100%"
								borderColor={"samaTeal.500"}
								borderWidth={0.5}
								onClick={() => {
									onOpen();
									compareDates("modal");
								}}
								cursor={"pointer"}
								_hover={{ background: "#0EEBA8", color: "#191919", boxShadow: "0px 3px 10px #0EEBA8" }}
								transition="0.3s"
								textTransform={"uppercase"}
							>
								CHANGELOG
							</Button>
							{newUpdate && <Circle bg="red" size={5} position="absolute" top="-22%" left="95%"/>}
						</Box>
					</Flex>
				</VStack>
				<NetworkSlider />
			</VStack>
			<Modal isOpen={isOpen} onClose={onClose} size="xl" isCentered scrollBehavior="inside">
				<ModalOverlay />
				<ModalContent
					fontFamily={"Orbitron"}
					color={"samaTeal.500"}
					className="gildedBorder"
					bg="samaBlack"
					p={5}
					borderWidth={2}
					boxShadow="lg"
					maxH="50vh"
				>
					<ModalCloseButton />
					<ModalHeader>
						Changelog
					</ModalHeader>
					<ModalBody>
						<Accordion allowToggle>
							{data?.map((update: Update, index: number) => {
								return (
									<AccordionItem
										key={index}
									>
										<AccordionButton>
											<Box>
												{`v${update.version} - ${update.title} (${update.date})`}
											</Box>
											<AccordionIcon />
										</AccordionButton>
										<AccordionPanel>
											<UnorderedList>
												{update.changes.split(". ").map((change: string, subindex: number) =>{
													if(change !== ". "){
														return (
															<ListItem
																key={subindex}
																color="samaWhite"
																fontFamily={"Raleway"}
															>
																{change}
															</ListItem>
														)
													}
												})}
											</UnorderedList>
										</AccordionPanel>
									</AccordionItem>
								)
							})}
						</Accordion>
					</ModalBody>
				</ModalContent>
			</Modal>
		</Fragment>
	);
};
