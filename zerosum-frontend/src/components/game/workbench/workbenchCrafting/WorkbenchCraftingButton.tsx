import { Button, Spinner, Tooltip, useToast } from "@chakra-ui/react";
import { useState } from "react";
import { approve, craft, getRequiredAmount } from "../workbenchUtils/functions/functions";

export const WorkbenchCraftingButton = ({
	selectedItem,
	tokenBalances,
	contracts,
	linkedAddress,
}: {
	selectedItem: Workbench.Craftable | null;
	tokenBalances: SquidBalancesResponse | undefined;
	contracts: Workbench.Contracts;
	linkedAddress: string | null | undefined;
}) => {
	const [pending, setPending] = useState(false);
	const [isApproved, setIsApproved] = useState(false);

	const toast = useToast();

	const isInvisible = !selectedItem || selectedItem?.requirements.length === 0;
	const isDisabled = selectedItem?.requirements.find((item: Workbench.Craftable) => {
		const token: Erc20Contract | Erc1155Token | undefined =
			item.id === 0
				? tokenBalances?.data.erc20Contracts.find((contract: Erc20Contract) => contract.address === item.address.toLowerCase())
				: (tokenBalances?.data.erc1155Contracts.find((contract: Erc1155Contract) => contract.address === item.address.toLowerCase()))?.tokens.find((token: Erc1155Token) => token.tokenId === item.id);
		const amount: number = !token ? 0 : (token as Erc20Contract).decimals ? Number((token as Erc20Contract).owners[0]?.balance) / 10 ** Number((token as Erc20Contract).decimals) : Number((token as Erc1155Token).owners[0]?.balance);

		return amount < getRequiredAmount(selectedItem.name, item);
	});

	const censorAddress = (address: string): string => {
		const firstHalf = address.substring(0, 5);
		const secondHalf = address.substring(address.length - 4, address.length);
		return `${firstHalf}...${secondHalf}`;
	};

	const handleClick = async () => {
		try {
			setPending(true);
			if (isApproved) {
				await craft(selectedItem?.blueprint ? selectedItem?.blueprint : 0, contracts, setPending);
				setIsApproved(false);
				setTimeout(() => {
					toast({
						title: `Success! Please wait for the new schematic to arrive in your wallet.`,
						status: "success",
						duration: 5_000,
						isClosable: true,
						variant: "success",
					});
				}, 2500);
			} else {
				await approve(selectedItem?.blueprint ? selectedItem?.blueprint : 0, contracts, setPending);
				setIsApproved(true);
			}
		} catch (error: any) {
			console.log(error);
			setPending(false);
			throw error;
		}
	};

	return (
		<Tooltip label={linkedAddress ? (contracts.signer?.address.toLowerCase() !== linkedAddress?.toLowerCase() ? `Switch to linked address: ${censorAddress(linkedAddress)}` : "") : ""}>
			<Button
				mx={4}
				h={10}
				mb={4}
				w={64}
				bg={isApproved ? "#453450" : "#25434F"}
				color="samaWhite"
				fontFamily={"Orbitron"}
				fontSize={"md"}
				letterSpacing={1.5}
				rounded={"sm"}
				isDisabled={!window.ethereum || pending || isDisabled || (linkedAddress && contracts.signer?.address.toLowerCase() !== linkedAddress?.toLowerCase())}
				borderColor={isApproved ? "#A876FF" : "samaTeal.500"}
				borderWidth={0.5}
				onClick={async () => await handleClick()}
				cursor={"pointer"}
				_hover={
					!pending
						? {
							background: isApproved ? "#A876FF" : "#0EEBA8",
							color: "#191919",
							transform: "translateY(-3px)",
							boxShadow: isApproved ? "0px 3px 10px #A876FF" : "0px 3px 10px #0EEBA8",
						}
						: {}
				}
				_active={{
					background: pending ? "#25434F" : "#0EEBA8",
					color: pending ? "samaWhite" : "#191919",
				}}
				transition="0.3s"
				transitionProperty="background, color, transform"
				textTransform={"uppercase"}
				visibility={isInvisible ? "hidden" : "visible"}
				opacity={isInvisible ? 0 : 1} // Corrected opacity range
				pointerEvents={isInvisible ? "none" : "auto"}
			>
				{!window.ethereum ? "No Wallet Detected" : pending ? <Spinner color="samaTeal.500" /> : isApproved ? "Craft" : "Approve"}
			</Button>
		</Tooltip>
	);
};
