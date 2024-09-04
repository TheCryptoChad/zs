import { supportedChains } from "../../../../../utils/chains/chains";

export const speedUpgrades = (chainId: number, Astralite: Workbench.Craftable, Samarium: Workbench.Craftable, Calamarite: Workbench.Craftable): Workbench.Craftable[] => {
	const SpeedLv1: Workbench.Craftable = {
		blueprint: 1,
		src: "workbench/speed/speed1.png",
		name: "Speed Upgrade Lv. 1",
		address: supportedChains[chainId].upgradesLv1,
		id: 1,
		description: "Increases mining speed by 5%.",
		requirements: [Astralite, Samarium, Calamarite],
		reqAmount: {
			speed: {
				2: 1,
			},
		},
	};

	const SpeedLv2: Workbench.Craftable = {
		blueprint: 4,
		src: "workbench/speed/speed2.png",
		name: "Speed Upgrade Lv. 2",
		address: supportedChains[chainId].upgradesLv2,
		id: 1,
		description: "Increases mining speed by 10%.",
		requirements: [SpeedLv1, Astralite, Samarium, Calamarite],
		reqAmount: {
			speed: {
				3: 1,
			},
		},
	};

	const SpeedLv3: Workbench.Craftable = {
		blueprint: 7,
		src: "workbench/speed/speed3.png",
		name: "Speed Upgrade Lv. 3",
		address: supportedChains[chainId].upgradesLv3,
		id: 1,
		description: "Increases mining speed by 15%.",
		requirements: [SpeedLv2, Astralite, Samarium, Calamarite],
		reqAmount: {
			speed: {
				4: 1,
			},
		},
	};

	const SpeedLv4: Workbench.Craftable = {
		blueprint: 10,
		src: "workbench/speed/speed4.png",
		name: "Speed Upgrade Lv. 4",
		address: supportedChains[chainId].upgradesLv4,
		id: 1,
		description: "Increases mining speed by 20%.",
		requirements: [SpeedLv3, Astralite, Samarium, Calamarite],
		reqAmount: {
			speed: {
				5: 1,
			},
		},
	};

	const SpeedLv5: Workbench.Craftable = {
		blueprint: 13,
		src: "workbench/speed/speed5.png",
		name: "Speed Upgrade Lv. 5",
		address: supportedChains[chainId].upgradesLv5,
		id: 1,
		description: "Increases mining speed by 25%.",
		requirements: [SpeedLv4, Astralite, Samarium, Calamarite],
		reqAmount: {},
	};

	return [SpeedLv1, SpeedLv2, SpeedLv3, SpeedLv4, SpeedLv5];
};
