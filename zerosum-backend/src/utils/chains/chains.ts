export const supportedChains = [
    {
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
        contracts: {
            vessels: "0x2057545871283c4635F01FC1Ef1d181294bc3053",
            astralite: "0xA68964024D033AD6c7e56c43bd589aB6EE07e5B0",
            samarium: "0x1CFdb87dF1f4BFce063b83F39Fc044dBF50d40FB",
            calamarite: "0x02A458b7f22afF7C6c5E6f3bb47fEC15F589F02C",
        }
    },
    {
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
        contracts: {
            vessels: "",
            astralite: "0x1F334a2279D35C876dFaa25e7A425b982a00bE06",
            samarium: "0x34D0f1B38822fe0Ae2a0D98539dF59861047bc0e",
            calamarite: "0x957895bD645167aBF6Fc32dD17744DCf5ED02E81",
        }
    },
]