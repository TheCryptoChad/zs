import { Chain } from "viem";

export const handleNetworkSwitching = async (id: number): Promise<void> => {
  try {
    await window.ethereum.request({
      method: "wallet_addEthereumChain",
      params: [
        {
          chainName: supportedChains[id].name,
          chainId: `0x${id.toString(16)}`,
          nativeCurrency: supportedChains[id].nativeCurrency,
          rpcUrls: [supportedChains[id].rpcUrl],
        },
      ],
    });
  } catch (error: any) {
    console.log(error);
    throw error;
  }
};

export const mantaTestnet = {
  id: 3_441_005,
  name: "manta-testnet",
  network: "manta-testnet",
  nativeCurrency: {
    decimals: 18,
    name: "Manta Network",
    symbol: "ETH",
  },
  rpcUrls: {
    public: { http: ["https://manta-testnet.calderachain.xyz/http"] },
    default: { http: ["https://manta-testnet.calderachain.xyz/http"] },
  },
  blockExplorers: {
    default: {
      name: "CalderaExplorer",
      url: "https://manta-testnet.calderaexplorer.xyz/",
    },
  },
  testnet: true,
} as const satisfies Chain;

export const baseMainnet = {
  id: 8_453,
  name: "Base Mainnet",
  network: "Base Mainnet",
  nativeCurrency: {
    decimals: 18,
    name: "Base Mainnet",
    symbol: "ETH",
  },
  rpcUrls: {
    public: { http: ["https://mainnet.base.org"] },
    default: { http: ["https://mainnet.base.org"] },
  },
  blockExplorers: {
    default: {
      name: "BaseScan",
      url: "https://basescan.org",
    },
  },
  testnet: false,
} as const satisfies Chain;

export const supportedChains: {
  [key: number]: {
    id: number;
    name: string;
    nativeCurrency: { name: string; decimals: number; symbol: string };
    rpcUrl: string;
    explorerUrl: string;
    type: string;
    gasFee: string;
    workbench: string;
    blueprintCollection: string;
    vessels: string;
    referrals: string;
    astralite: string;
    samarium: string;
    calamarite: string;
    upgradesLv1: string;
    upgradesLv2: string;
    upgradesLv3: string;
    upgradesLv4: string;
    upgradesLv5: string;
  };
} = {
  3_441_005: {
    id: 3_441_005,
    name: "Manta Testnet",
    nativeCurrency: { name: "Manta Testnet", decimals: 18, symbol: "ETH" },
    rpcUrl: "https://manta-testnet.calderachain.xyz/http",
    explorerUrl: "https://manta-testnet.calderaexplorer.xyz/api",
    type: "testnet",
    gasFee: "0.00025",
    workbench: "0xbC0d0c5E67fC0d7834a0e3B8Acf741d1F5b78ca5",
    blueprintCollection: "0x5B0E7a91503F1650899434236717167E7C617b90",
    vessels: "0x2057545871283c4635F01FC1Ef1d181294bc3053",
    referrals: "0x357bcd187c2CCF1636cf53782F74404Ab8f0a35d",
    astralite: "0xA68964024D033AD6c7e56c43bd589aB6EE07e5B0",
    samarium: "0x1CFdb87dF1f4BFce063b83F39Fc044dBF50d40FB",
    calamarite: "0x02A458b7f22afF7C6c5E6f3bb47fEC15F589F02C",
    upgradesLv1: "0xFc08741dde5fe426184e65e14E90Ecf110FBDf44",
    upgradesLv2: "0x26eFd11455e2B4bA1e0ca7184c408fEe4E4098d0",
    upgradesLv3: "0x003108E1C054549C257855308752426e5bC2baF4",
    upgradesLv4: "0x34AfB1A3DA1fec708bB1493E95419788E7eC1156",
    upgradesLv5: "0x5a41069AFd6Ff3dFCB0ED28847EAB9F5721b0e08",
  },
  8_453: {
    id: 8_453,
    name: "Base Mainnet",
    nativeCurrency: { name: "Base Mainnet", decimals: 18, symbol: "ETH" },
    rpcUrl: "https://mainnet.base.org",
    explorerUrl: "https://base.blockscout.com/api",
    type: "mainnet",
    gasFee: "0.0004",
    workbench: "0x56f33FaAc598f6761bE886506bD41eC2304D74af",
    blueprintCollection: "0x8DC2643ffDD0a9E9c0cBcf24b6cD5E3dB60C9cC4",
    vessels: "",
    referrals: "",
    astralite: "0x1F334a2279D35C876dFaa25e7A425b982a00bE06",
    samarium: "0x34D0f1B38822fe0Ae2a0D98539dF59861047bc0e",
    calamarite: "0x957895bD645167aBF6Fc32dD17744DCf5ED02E81",
    upgradesLv1: "0x445ad3A1aa00871d8B7E683d7480c62830cE1CDB",
    upgradesLv2: "0x9Cf5C5550B05dFF901BDD44a1966237A60359265",
    upgradesLv3: "0x788fB79C4e529cF94abcaD35439344FE1c9D8B97",
    upgradesLv4: "0x1248c6fBd58DBa974313D7aF6c84Bf93272Aa26A",
    upgradesLv5: "0xAD4250593846b25006b614a5890d151b9393b033",
  },
};
