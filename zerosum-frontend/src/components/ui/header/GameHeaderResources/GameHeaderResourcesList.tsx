import { HStack, Tooltip, Image, Text } from "@chakra-ui/react";
import { addTokenToWallet } from "../GameHeaderClaim/AddTokenToWallet";
import { useNetwork } from "wagmi"
import { isMobile } from "react-device-detect";
import { handleNetworkSwitching, mantaTestnet, supportedChains } from "../../../../utils/chains/chains";

export const GameHeaderResourcesList = ({ data }: { data: Entity.Resources }) => {
	const { chain } = useNetwork()

	const formattedResourceValue = (amount: number): string => {
		if (amount < 1000) return amount.toString()

		return `${(amount / 1000).toFixed(1)}K`
	}

	return (
		<HStack
			bg={"samaBlackFade"}
			p={isMobile ? 0 : 2}
			rounded={"sm"}
			pointerEvents={"auto"}
			gap={0}
			alignItems={"start"}
		>
			{Object.entries(data).map(([key, value]: [string, number], index: number) => {
				if (index < 3) {
					const totalClaimableAllowance: number = Number(value) + Number(Object.values(data)[index + 3]);
					return (
						<Tooltip
							my={0.5}
							bg={"samaBlackFade"}
							color={"samaWhite"}
							rounded={"sm"}
							fontFamily={"Raleway"}
							textTransform={"capitalize"}
							label={key}
							key={key}
						>
							<HStack gap={1} p={2}>
								<Image
									borderRadius="5px"
									_hover={{ boxShadow: "0px 0px 5px #FFFFFF", cursor: "pointer" }}
									onClick={Object.keys(supportedChains).includes(String(chain?.id)) ? () => addTokenToWallet(chain?.id, key) : async () => await handleNetworkSwitching(mantaTestnet.id)}
									src={`./resources/${key}.png`}
									h={8}
								/>
								<Text fontSize={isMobile ? "sm" : "lg"} color={"samaWhite"}>{formattedResourceValue(totalClaimableAllowance)}</Text>
							</HStack>
						</Tooltip>
					)
				}
			})}
		</HStack>
	);
};
