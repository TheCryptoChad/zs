import { Heading, Image, Text, VStack } from "@chakra-ui/react";
import { getFormattedAmount } from "../workbenchUtils/functions/functions";

export const WorkbenchCraftingResult = ({ selectedItem, tokenBalances }: { selectedItem: Workbench.Craftable | null; tokenBalances: SquidBalancesResponse | undefined }) => {
	if (!selectedItem) return null;

	const token: Erc20Contract | Erc1155Token | undefined =
		selectedItem.id === 0
		? tokenBalances?.data.erc20Contracts.find((contract: Erc20Contract) => contract.address === selectedItem.address.toLowerCase())
		: (tokenBalances?.data.erc1155Contracts.find((contract: Erc1155Contract) => contract.address === selectedItem.address.toLowerCase()))?.tokens.find((token: Erc1155Token) => token.tokenId === selectedItem.id);
	const amount: number = !token || !token.owners.length ? 0 : (token as Erc20Contract).decimals ? Number((token as Erc20Contract).owners[0]?.balance) / 10 ** Number((token as Erc20Contract).decimals) : Number((token as Erc1155Token).owners[0]?.balance);

	return (
		<VStack
			h={"full"}
			justifyContent={"center"}
		>
			<Heading
				textTransform={"uppercase"}
				fontFamily={"Orbitron"}
				textColor={"samaTeal.500"}
				letterSpacing={1.5}
			>
				{selectedItem.name}
			</Heading>
			{selectedItem.src &&
				<Image
					src={selectedItem.src}
					position="relative"
					width="200px"
					height="200px"
					mb={10}
				/>
			}
			<VStack
				bg={"samaGrey"}
				p={3}
				rounded={"sm"}
				boxShadow="lg"
				borderWidth={0.5}
				borderColor={"samaBlack"}
			>
				<Text
					textColor={"samaWhite"}
					textTransform={"uppercase"}
					fontWeight={"bold"}
					mb={2}
					fontFamily={"Raleway"}
					letterSpacing={1}
				>
					Description
				</Text>
				<Text
					fontFamily={"Raleway"}
					textColor={"samaWhite"}
				>
					{selectedItem.description ?? "N/A"}
				</Text>
			</VStack>
			<Text
				mt={5}
				textTransform={"uppercase"}
				fontFamily={"Orbitron"}
				textColor={"samaTeal.500"}
				letterSpacing={1.5}
			>
				You Own: {getFormattedAmount(amount)}
			</Text>
		</VStack>
	);
};
