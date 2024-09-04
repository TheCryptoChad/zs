import { Box, Button, Spinner, Tooltip } from "@chakra-ui/react";
import { Dispatch, SetStateAction } from "react";
import { isMobile } from "react-device-detect";
import { useSwitchNetwork } from "wagmi";

export const GameHeaderClaimResourcesButton = ({ data, pending, setIsNetworkOpen }: { data: Entity.Resources; pending: boolean; setIsNetworkOpen: Dispatch<SetStateAction<boolean>> }) => {
	const { isLoading  } = useSwitchNetwork();

	return (
		<Tooltip
			label={
				!Object.values(data)
					.slice(0, 3)
					.every((value: number, index: number) => {
						const totalClaimableAllowance: number = Number(value) + Number(Object.values(data)[index + 3]);
						return totalClaimableAllowance >= 500;
					})
					? "Collect 500 of each resource to claim."
					: ""
			}
		>
			<Box
				bg={"samaBlackFade"}
				p={isMobile ? 2 : 3}
				w={isMobile ? "full" : "auto"}
				rounded={"sm"}
				pointerEvents={"auto"}
			>
				<Button
					bg="#25434F"
					color="samaWhite"
					fontFamily={"Orbitron"}
					fontSize={"small"}
					isDisabled={
						pending || isLoading ||
						!Object.values(data)
							.slice(0, 3)
							.every((value: number, index: number) => {
								const totalClaimableAllowance: number = Number(value) + Number(Object.values(data)[index + 3]);
								return totalClaimableAllowance >= 500;
							})
					}
					w={isMobile ? "full" : "auto"}
					h={isMobile ? "32px" : "40px"}
					letterSpacing={1.5}
					rounded={"sm"}
					borderColor={"samaTeal.500"}
					borderWidth={0.5}
					onClick={() => setIsNetworkOpen(true)}
					cursor={"pointer"}
					_hover={
						(!pending && Object.values(data)
						.slice(0, 3)
						.every((value: number, index: number) => {
							const totalClaimableAllowance: number = Number(value) + Number(Object.values(data)[index + 3]);
							return totalClaimableAllowance >= 500;
						}))
							? {
									background: "#0EEBA8",
									color: "#191919",
									transform: "translateY(-3px)",
									boxShadow: "0px 3px 10px #0EEBA8",
							  }
							: { background: "#0EEBA8", color: "#191919" }
					}
					transition="0.3s"
					textTransform={"uppercase"}
				>
					{pending || isLoading ? <Spinner color="samaTeal.500" /> : "Claim"}
				</Button>
			</Box>
		</Tooltip>
	);
};
