import { supportedChains } from "../../../../../utils/chains/chains";

export const resourceItems = (chainId: number): Workbench.Craftable[] => {
  const Astralite: Workbench.Craftable = {
    blueprint: 0,
    src: "https://raw.githubusercontent.com/Rebelsama/assets/main/astralite.png",
    name: "Astralite",
    address: supportedChains[chainId].astralite,
    id: 0,
    description: "Astralite mined from the depths of Uranus.",
    requirements: [],
    reqAmount: {
      speed: {
        1: 5_000,
        2: 10_000,
        3: 25_000,
        4: 50_000,
        5: 120_000,
      },
      range: {
        1: 2_500,
        2: 5_000,
        3: 12_500,
        4: 25_000,
        5: 60_000,
      },
      radar: {
        1: 2_500,
        2: 5_000,
        3: 12_500,
        4: 25_000,
        5: 60_000,
      },
    },
  };

  const Samarium: Workbench.Craftable = {
    blueprint: 0,
    src: "https://raw.githubusercontent.com/Rebelsama/assets/main/samarium.png",
    name: "Samarium",
    description: "Samarium mined from the depths of Uranus.",
    address: supportedChains[chainId].samarium,
    id: 0,
    requirements: [],
    reqAmount: {
      speed: {
        1: 2_500,
        2: 5_000,
        3: 12_500,
        4: 25_000,
        5: 60_000,
      },
      range: {
        1: 5_000,
        2: 10_000,
        3: 25_000,
        4: 50_000,
        5: 120_000,
      },
      radar: {
        1: 2_500,
        2: 5_000,
        3: 12_500,
        4: 25_000,
        5: 60_000,
      },
    },
  };

  const Calamarite: Workbench.Craftable = {
    blueprint: 0,
    src: "https://raw.githubusercontent.com/Rebelsama/assets/main/calamarite.png",
    name: "Calamarite",
    description: "Calamarite mined from the depths of Uranus.",
    address: supportedChains[chainId].calamarite,
    id: 0,
    requirements: [],
    reqAmount: {
      speed: {
        1: 2_500,
        2: 5_000,
        3: 12_500,
        4: 25_000,
        5: 60_000,
      },
      range: {
        1: 2_500,
        2: 5_000,
        3: 12_500,
        4: 25_000,
        5: 60_000,
      },
      radar: {
        1: 5_000,
        2: 10_000,
        3: 25_000,
        4: 50_000,
        5: 120_000,
      },
    },
  };
  
  return [Astralite, Samarium, Calamarite];
};
