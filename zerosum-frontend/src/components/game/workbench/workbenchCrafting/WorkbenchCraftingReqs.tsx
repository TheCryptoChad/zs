import { Box, HStack } from "@chakra-ui/react";
import { WorkbenchCraftingSlot } from "./WorkbenchCraftingSlot";

export const WorkbenchCraftingReqs = ({ selectedItem, tokenBalances }: { selectedItem: Workbench.Craftable | null; tokenBalances: SquidBalancesResponse | undefined }) =>
	selectedItem && (
		<HStack gap={4}>
			{selectedItem.requirements.length > 0 ? (
				selectedItem.requirements.map((req: Workbench.Craftable, index: number) => {
					const token: Erc20Contract | Erc1155Token | undefined =
						req.id === 0
						? tokenBalances?.data.erc20Contracts.find((contract: Erc20Contract) => contract.address === req.address.toLowerCase())
						: (tokenBalances?.data.erc1155Contracts.find((contract: Erc1155Contract) => contract.address === req.address.toLowerCase()))?.tokens.find((token: Erc1155Token) => token.tokenId === req.id);
					const amount: number = !token || !token.owners.length ? 0 : (token as Erc20Contract).decimals ? Number((token as Erc20Contract).owners[0]?.balance) / 10 ** Number((token as Erc20Contract).decimals) : Number((token as Erc1155Token).owners[0]?.balance);
					return (
						<WorkbenchCraftingSlot
							key={index}
							currentAmount={amount}
							requiredItem={req}
							selectedItem={selectedItem}
						/>
					);
				})
			) : (
				<Box
					h={20}
					w={20}
				/>
			)}
		</HStack>
	);
