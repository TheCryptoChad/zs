import { Button, Spinner, VStack } from "@chakra-ui/react";
import { ReactNode, Suspense, useState } from "react";
import { isMobile } from "react-device-detect";
import { WorkbenchNetworkModal } from "../workbenchNetworkModal";
import { supportedChains } from "../../../../utils/chains/chains";

export const WorkbenchCraftingPane = ({ children }: { children: ReactNode }) => {
	const [isNetworkOpen, setIsNetworkOpen] = useState<boolean>(false);

	return (
		<VStack
			flexGrow={1}
			height={"full"}
			justifyContent="center"
			gap={6}
			bg={"samaBlackFade"}
			rounded={"md"}
			position="relative"
		>
			<Button
				isDisabled={!window.ethereum}
				p={isMobile ? 1.5 : 2}
				bg="#25434F"
				color="samaWhite"
				fontFamily={"Orbitron"}
				fontSize={"small"}
				letterSpacing={1.5}
				rounded={"sm"}
				borderColor={"samaTeal.500"}
				borderWidth={0.5}
				cursor={"pointer"}
				_hover={{
					background: "#0EEBA8",
					color: "#191919",
					transform: "translateY(-3px)",
					boxShadow: "0px 3px 10px #0EEBA8",
				}}
				transition="0.3s"
				textTransform={"uppercase"}
				onClick={() => setIsNetworkOpen(true)}
				justifySelf="start"
				position="absolute"
				top="2%"
				left="2%"
			>
				{window.ethereum ? supportedChains[Number(window.ethereum.networkVersion || 0)]?.name || "Unsupported Network" : "No wallet detected"}
			</Button>
			<Suspense
				fallback={
					<Spinner
						w={16}
						h={16}
						thickness={"3px"}
						color={"samaTeal.500"}
					/>
				}
			>
				{children}
			</Suspense>
			{isNetworkOpen && <WorkbenchNetworkModal setIsNetworkOpen={setIsNetworkOpen} />}
		</VStack>
	);
};
