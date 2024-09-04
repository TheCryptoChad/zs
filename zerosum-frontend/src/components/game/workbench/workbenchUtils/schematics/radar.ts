import { supportedChains } from "../../../../../utils/chains/chains";

export const radarUpgrades = (chainId: number, Astralite: Workbench.Craftable, Samarium: Workbench.Craftable, Calamarite: Workbench.Craftable): Workbench.Craftable[] => {
	const RadarLv1: Workbench.Craftable = {
		blueprint: 3,
		src: "workbench/radar/radar1.png",
		name: "Radar Upgrade Lv. 1",
		address: supportedChains[chainId].upgradesLv1,
		id: 3,
		description: "Scan all tiles adjacent to the vessel.",
		requirements: [Astralite, Samarium, Calamarite],
		reqAmount: {
			radar: {
				2: 1,
			},
		},
	};

	const RadarLv2: Workbench.Craftable = {
		blueprint: 6,
		src: "workbench/radar/radar2.png",
		name: "Radar Upgrade Lv. 2",
		address: supportedChains[chainId].upgradesLv2,
		id: 3,
		description: "Increases radar radius by 1 tile.",
		requirements: [RadarLv1, Astralite, Samarium, Calamarite],
		reqAmount: {
			radar: {
				3: 1,
			},
		},
	};

	const RadarLv3: Workbench.Craftable = {
		blueprint: 9,
		src: "workbench/radar/radar3.png",
		name: "Radar Upgrade Lv. 3",
		address: supportedChains[chainId].upgradesLv3,
		id: 3,
		description: "Increases radar radius by 2 tiles.",
		requirements: [RadarLv2, Astralite, Samarium, Calamarite],
		reqAmount: {
			radar: {
				4: 1,
			},
		},
	};

	const RadarLv4: Workbench.Craftable = {
		blueprint: 12,
		src: "workbench/radar/radar4.png",
		name: "Radar Upgrade Lv. 4",
		address: supportedChains[chainId].upgradesLv4,
		id: 3,
		description: "Increases radar radius by 3 tiles.",
		requirements: [RadarLv3, Astralite, Samarium, Calamarite],
		reqAmount: {
			radar: {
				5: 1,
			},
		},
	};

	const RadarLv5: Workbench.Craftable = {
		blueprint: 15,
		src: "workbench/radar/radar5.png",
		name: "Radar Upgrade Lv. 5",
		address: supportedChains[chainId].upgradesLv5,
		id: 3,
		description: "Increases radar radius by 5 tiles.",
		requirements: [RadarLv4, Astralite, Samarium, Calamarite],
		reqAmount: {},
	};

	return [RadarLv1, RadarLv2, RadarLv3, RadarLv4, RadarLv5];
};
