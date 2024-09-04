import { supportedChains } from "../../../../../utils/chains/chains";

export const rangeUpgrades = (chainId: number, Astralite: Workbench.Craftable, Samarium: Workbench.Craftable, Calamarite: Workbench.Craftable): Workbench.Craftable[] => {
	const RangeLv1: Workbench.Craftable = {
		blueprint: 2,
		src: "workbench/range/range1.png",
		name: "Range Upgrade Lv. 1",
		address: supportedChains[chainId].upgradesLv1,
		id: 2,
		description: "Increases movement range by 1 tile.",
		requirements: [Astralite, Samarium, Calamarite],
		reqAmount: {
			range: {
				2: 1,
			},
		},
	};

	const RangeLv2: Workbench.Craftable = {
		blueprint: 5,
		src: "workbench/range/range2.png",
		name: "Range Upgrade Lv. 2",
		address: supportedChains[chainId].upgradesLv2,
		id: 2,
		description: "Increases movement range by 2 tiles.",
		requirements: [RangeLv1, Astralite, Samarium, Calamarite],
		reqAmount: {
			range: {
				3: 1,
			},
		},
	};

	const RangeLv3: Workbench.Craftable = {
		blueprint: 8,
		src: "workbench/range/range3.png",
		name: "Range Upgrade Lv. 3",
		address: supportedChains[chainId].upgradesLv3,
		id: 2,
		description: "Increases movement range by 3 tiles.",
		requirements: [RangeLv2, Astralite, Samarium, Calamarite],
		reqAmount: {
			range: {
				4: 1,
			},
		},
	};

	const RangeLv4: Workbench.Craftable = {
		blueprint: 11,
		src: "workbench/range/range4.png",
		name: "Range Upgrade Lv. 4",
		address: supportedChains[chainId].upgradesLv4,
		id: 2,
		description: "Increases movement range by 4 tiles.",
		requirements: [RangeLv3, Astralite, Samarium, Calamarite],
		reqAmount: {
			range: {
				5: 1,
			},
		},
	};

	const RangeLv5: Workbench.Craftable = {
		blueprint: 14,
		src: "workbench/range/range5.png",
		name: "Range Upgrade Lv. 5",
		address: supportedChains[chainId].upgradesLv5,
		id: 2,
		description: "Increases movement range by 5 tiles.",
		requirements: [RangeLv4, Astralite, Samarium, Calamarite],
		reqAmount: {},
	};

	return [RangeLv1, RangeLv2, RangeLv3, RangeLv4, RangeLv5];
};
