import { HStack } from "@chakra-ui/react";
import { useEffect, useState } from "react";
import { WorkbenchCraftingPane } from "../components/game/workbench/workbenchCrafting/WorkbenchCraftingPane";
import { WorkbenchResourceSearchbar } from "../components/game/workbench/workbenchResource/WorkbenchResourcSearchbar";
import { WorkbenchResourcePane } from "../components/game/workbench/workbenchResource/WorkbenchResourcePane";
import { WorkbenchResourceGridList } from "../components/game/workbench/workbenchResource/WorkbenchResourceGridList";
import { WorkbenchCraftingButton } from "../components/game/workbench/workbenchCrafting/WorkbenchCraftingButton";
import { WorkbenchCraftingResult } from "../components/game/workbench/workbenchCrafting/WorkbenchCraftingResult";
import { WorkbenchCraftingReqs } from "../components/game/workbench/workbenchCrafting/WorkbenchCraftingReqs";
import { BrowserProvider, Contract } from "ethers";
import { API } from "../api/api";
import { useQuery } from "react-query";
import { queryClient } from "../main";
import { handleNetworkSwitching, mantaTestnet, supportedChains } from "../utils/chains/chains";
import { MaintenaceBanner } from "../components/ui/maintenance/MaintenanceBanner";
import { resourceItems } from "../components/game/workbench/workbenchUtils/resources/resources";
import { speedUpgrades } from "../components/game/workbench/workbenchUtils/schematics/speed";
import { radarUpgrades } from "../components/game/workbench/workbenchUtils/schematics/radar";
import { rangeUpgrades } from "../components/game/workbench/workbenchUtils/schematics/range";


export const Workbench = () => {
	const [refresh, setRefresh] = useState<boolean>(true);
	const [selectedItem, setSelectedItem] = useState<Workbench.Craftable | null>(null);
	const [searchTerm, setSearchTerm] = useState("");
	const [contracts] = useState<Workbench.Contracts>({});
	const [schematics, setSchematics] = useState<Workbench.Craftable[]>([]);
	const [resources, setResources] = useState<Workbench.Craftable[]>([]);

	useEffect(() => { }, [refresh]);

	useEffect(() => {
		try {
			if(window.ethereum){
				(async () => {
					if(!Object.keys(supportedChains).includes(window.ethereum.networkVersion)) await handleNetworkSwitching(mantaTestnet.id);
				})();
				window.ethereum.on("chainChanged", async () => {
					if(!Object.keys(supportedChains).includes(window.ethereum.networkVersion)) await handleNetworkSwitching(mantaTestnet.id);
					queryClient.invalidateQueries("balances");
				});

				window.ethereum.on("accountsChanged", async () => {
					const provider: BrowserProvider = new BrowserProvider((window as any).ethereum);
					contracts.signer = await provider.getSigner();
					setRefresh(!refresh);
					queryClient.invalidateQueries("balances");
				});
				return () => {
					window.ethereum.removeListener("chainChanged", async () => {
						if(!Object.keys(supportedChains).includes(window.ethereum.networkVersion)) await handleNetworkSwitching(mantaTestnet.id);
						queryClient.invalidateQueries("balances");
					});

					window.ethereum.removeListener("accountsChanged", async () => {
						const provider: BrowserProvider = new BrowserProvider((window as any).ethereum);
						contracts.signer = await provider.getSigner();
						setRefresh(!refresh);
						queryClient.invalidateQueries("balances");
					});
				};
			}
		} catch (error: any) {
			console.log(error);
		}
	}, []);

	const connectWallet = async (): Promise<SquidBalancesResponse | undefined> => {
		try {
			setSelectedItem(null);
			const { erc20Abi, erc1155Abi, blueprintCollectionAbi } = await API.blockchain.getAbi();
			const provider: BrowserProvider = new BrowserProvider((window as any).ethereum);
			const chain: number = Number(window.ethereum.networkVersion || 3_441_005);
			contracts.signer = await provider.getSigner();
			contracts.astralite = new Contract(supportedChains[chain].astralite, erc20Abi, contracts.signer);
			contracts.samarium = new Contract(supportedChains[chain].samarium, erc20Abi, contracts.signer);
			contracts.calamarite = new Contract(supportedChains[chain].calamarite, erc20Abi, contracts.signer);
			contracts.upgradeLv1 = new Contract(supportedChains[chain].upgradesLv1, erc1155Abi, contracts.signer);
			contracts.upgradeLv2 = new Contract(supportedChains[chain].upgradesLv2, erc1155Abi, contracts.signer);
			contracts.upgradeLv3 = new Contract(supportedChains[chain].upgradesLv3, erc1155Abi, contracts.signer);
			contracts.upgradeLv4 = new Contract(supportedChains[chain].upgradesLv4, erc1155Abi, contracts.signer);
			contracts.upgradeLv5 = new Contract(supportedChains[chain].upgradesLv5, erc1155Abi, contracts.signer);
			contracts.blueprintCollection = new Contract(supportedChains[chain].blueprintCollection, blueprintCollectionAbi, contracts.signer);
			const resources = resourceItems(chain);
			const speed = speedUpgrades(chain, resources[0], resources[1], resources[2]);
			const range = rangeUpgrades(chain, resources[0], resources[1], resources[2]);
			const radar = radarUpgrades(chain, resources[0], resources[1], resources[2]);
			setResources(resources);
			setSchematics([...speed, ...range, ...radar]);
			const response = await fetch(`${import.meta.env.VITE_SQUID_URL}`, {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({
					query: `
						query MyQuery($address: String!, $chainId: Int!) {
							erc20Contracts(where: {chainId_eq: $chainId}) {
								address
								decimals
								owners(where: {address_eq: $address}) {
									address
									balance
								}
							}
							erc1155Contracts(where: {chainId_eq: $chainId}) {
								address
								tokens {
									tokenId
									owners(where: {address_eq: $address}) {
										address
										balance
									}
								}
							}
						}
					`,
					variables: {
						address: userData?.address,
						chainId: chain
					}
				})
			});
			if (response.ok) {
				const data = await response.json();
				setRefresh(!refresh);
				return data;
			} else {
				throw new Error(`HTTP error! Status: ${response.status}`);
			}
		} catch (error: any) {
			console.log(error);
		}
	};

	const { data: userData } = useQuery<Entity.Self>("user", API.user.getSelf, { staleTime: Infinity });

	const { data: tokenBalances } = useQuery<SquidBalancesResponse | undefined>({
		queryKey: "balances",
		queryFn: async () => {
			return await connectWallet();
		},
		staleTime: Infinity,
		enabled: !!userData?.address
	});

	return (
			<HStack
				h={"full"}
				w={"full"}
				p={4}
				bgImage="url(backgrounds/workbench_background.jpeg)"
				backgroundSize="cover"
				backgroundPosition="center"
			>
				{import.meta.env.VITE_MAINTENANCE_MODE === "true" && <MaintenaceBanner />}
				<WorkbenchResourcePane>
					<WorkbenchResourceSearchbar setSearchTerm={setSearchTerm} />
					<WorkbenchResourceGridList
						searchTerm={searchTerm}
						setSelectedItem={setSelectedItem}
						selectedItem={selectedItem}
						schematics={schematics}
						resources={resources}
						tokenBalances={tokenBalances}
					/>
				</WorkbenchResourcePane>
				<WorkbenchCraftingPane>
					<WorkbenchCraftingResult
						selectedItem={selectedItem}
						tokenBalances={tokenBalances}
					/>
					<WorkbenchCraftingReqs
						selectedItem={selectedItem}
						tokenBalances={tokenBalances}
					/>
					<WorkbenchCraftingButton
						selectedItem={selectedItem}
						tokenBalances={tokenBalances}
						contracts={contracts}
						linkedAddress={userData?.address}
					/>
				</WorkbenchCraftingPane>
			</HStack>
	);
};
