import { HStack, VStack, useToast } from "@chakra-ui/react";
import { useQuery } from "react-query";
import { API } from "../../../../api/api";
import { useState } from "react";
import { parseEther } from "viem";
import { queryClient } from "../../../../main";
import { BrowserProvider, Contract, JsonRpcSigner } from "ethers";
import { resourceABI } from "../../../../utils/abi/resourceContract";
import { GameHeaderClaimModal } from "../GameHeaderClaim/GameHeaderClaimModal";
import { GameHeaderClaimResourcesButton } from "../GameHeaderClaim/GameHeaderClaimResourcesButton";
import { isBrowser, isMobile } from "react-device-detect";
import { useNetwork } from "wagmi"
import { GameHeaderResourcesList } from "./GameHeaderResourcesList";
import { handleNetworkSwitching, supportedChains } from "../../../../utils/chains/chains";
import { GameHeaderNetworkModal } from "../GameHeaderClaim/GameHeaderNetworkModal";


export const GameHeaderResources = () => {
	const [isClaimOpen, setIsClaimOpen] = useState<boolean>(false);
	const [isNetworkOpen, setIsNetworkOpen] = useState<boolean>(false);
	const [pending, setPending] = useState(false);
	const [selectedNetworks, setSelectedNetworks] = useState<{ [key: string]: boolean }>({});
	const [web3, setWeb3] = useState<{ astraliteContract?: Contract; samariumContract?: Contract; calamariteContract?: Contract; signer?: JsonRpcSigner }>({});

	const toast = useToast();

	const { chain } = useNetwork();

	const { data: userData } = useQuery({
		queryKey: "user",
		queryFn: API.user.getSelf,
	});

	useQuery({
		queryKey: "pendingMints",
		queryFn: () => {
			userData?.pendingMints?.map(chain => {
				selectedNetworks[String(chain)] = true;
			})
			setIsClaimOpen(true);
		},
		staleTime: Infinity,
		enabled: !!userData?.pendingMints && userData?.pendingMints?.length > 0
	});

	const { data } = useQuery<Entity.Resources>({
		queryKey: "resources",
		queryFn: API.resources.getBalances,
		enabled: !!userData?.address,
	});

	const setNetworks = async () => {
		try {
			const selectedNetworksArray: number[] = Object.keys(selectedNetworks).filter((key: string) => selectedNetworks[key] === true).map((key: string) => Number(key)).reverse();
			await API.resources.claimResources(selectedNetworksArray);
			queryClient.invalidateQueries("resources");
			setIsNetworkOpen(false);
			setIsClaimOpen(true);
		} catch (error) {
			console.log(error);
			throw error;
		}
		setPending(false);
	}

	const claimResources = async () => {
		try {
			const selectedNetworksArray: number[] = Object.keys(selectedNetworks).filter((key: string) => selectedNetworks[key] === true).map((key: string) => Number(key)).reverse();
			if (chain?.id && chain?.id !== selectedNetworksArray[0]) await handleNetworkSwitching(selectedNetworksArray[0]);
			for (let i = 0; i < selectedNetworksArray.length; i++) {
				const chainId: number = supportedChains[selectedNetworksArray[i]].id;
				const nextId: number = i === (selectedNetworksArray.length - 1) ? 0 : supportedChains[selectedNetworksArray[i + 1]].id;
				const provider = new BrowserProvider(window.ethereum);
				web3.signer = await provider.getSigner();
				web3.astraliteContract = new Contract(supportedChains[selectedNetworksArray[i]].astralite, resourceABI, web3.signer);
				web3.samariumContract = new Contract(supportedChains[selectedNetworksArray[i]].samarium, resourceABI, web3.signer);
				web3.calamariteContract = new Contract(supportedChains[selectedNetworksArray[i]].calamarite, resourceABI, web3.signer);
				await web3.signer.sendTransaction({
					to: "0xAAC5e7E4D9D3B535a286E5a784d64D67Af7dD4A1",
					value: parseEther(supportedChains[selectedNetworksArray[i]].gasFee),
				});
				await API.resources.payGas(chainId);
				if (Number(data?.astralite) + Number(data?.contractAstralite) >= 500) {
					const astraliteTx = await web3.astraliteContract.mint();
					await astraliteTx.wait();
				}
				if (Number(data?.samarium) + Number(data?.contractSamarium) >= 500) {
					const samariumTx = await web3.samariumContract.mint();
					await samariumTx.wait();
				}
				if (Number(data?.calamarite) + Number(data?.contractCalamarite) >= 500) {
					const calamariteTx = await web3.calamariteContract.mint();
					await calamariteTx.wait();
				}
				if (nextId > 0) await handleNetworkSwitching(nextId);
			}
			await API.resources.clearPendingBalances();
			toast({
				title: `Success! Please wait for the resources to arrive in your wallet.`,
				status: "success",
				duration: 5_000,
				isClosable: true,
				variant: "success",
			});
			queryClient.invalidateQueries("resources");
			setIsClaimOpen(false);
		} catch (error: any) {
			console.log(error)
			if (error.info.error.code = -32603) {
				toast({
					title: `Error! You may not have enough gas to mint, check you have enough ${supportedChains[Number(chain?.id)].nativeCurrency.symbol} and try again.`,
					status: "error",
					duration: 5_000,
					isClosable: true,
				});
			}
			throw error;
		} finally {
			queryClient.invalidateQueries('faucet');
			setPending(false);
		}
	}

	return (
		data && (
			<VStack gap={0.5} alignSelf={"start"}>
				<HStack gap={1}>
					{isBrowser && (
						<GameHeaderClaimResourcesButton
							data={data}
							pending={pending}
							setIsNetworkOpen={setIsNetworkOpen} 
						/>
					)}
					<GameHeaderResourcesList data={data} />
					{isClaimOpen && (
						<GameHeaderClaimModal
							data={data}
							claimResources={claimResources}
							isClaimOpen={isClaimOpen}
							setIsClaimOpen={setIsClaimOpen}
							setPending={setPending}
							setWeb3={setWeb3}
							pending={pending}
							userData={userData}
							web3={web3}
						/>
					)}
					{isNetworkOpen && (
						<GameHeaderNetworkModal
							pending={pending}
							selectedNetworks={selectedNetworks}
							setIsNetWorkOpen={setIsNetworkOpen}
							setNetworks={setNetworks}
							setPending={setPending}
							setSelectedNetworks={setSelectedNetworks}
						/>
					)}
				</HStack>
				{isMobile && (
					<GameHeaderClaimResourcesButton
						data={data}
						pending={pending}
						setIsNetworkOpen={setIsNetworkOpen}
					/>
				)}
			</VStack>
		)
	);
};
