import { extendTheme } from "@chakra-ui/react";
import { connectorsForWallets, darkTheme } from "@rainbow-me/rainbowkit";
import { injectedWallet, metaMaskWallet } from "@rainbow-me/rainbowkit/wallets";
import { configureChains, createConfig, mainnet } from "wagmi";
import { publicProvider } from "wagmi/providers/public";
import { mantaTestnet, baseMainnet } from "./chains/chains";
import { VesselABI } from "./abi/VesselContract";

export const { chains, publicClient } = configureChains(
  [mantaTestnet, baseMainnet, mainnet],
  [publicProvider()],
);
const connectors = connectorsForWallets([
  {
    groupName: "Recommended",
    wallets: [
      injectedWallet({ chains }),
      metaMaskWallet({ chains, projectId: "..." }),
    ],
  },
]);

export const config: Config.App = {
  contracts: {
    vessels: {
      address: "0x2057545871283c4635F01FC1Ef1d181294bc3053",
      abi: VesselABI,
    },
  },
  chakra: extendTheme({
    font: {
      heading: `'Orbitron', sans-serif`,
      body: `'Raleway', sans-serif`,
    },
    colors: {
      samaTeal: {
        500: "#0EEBA8",
      },
      samaBlack: "#191919",
      samaGrey: "#2C2C2C",
      samaBlackFade: "#191919DD",
      samaBlue: {
        500: "#25434F",
      },
      samaWhite: "#FAF9F6",
      samaSpace01: "#1A202C",
      samaSpace02: "#171923",
      fullBlack50: "#00000060",
    },
    components: {
      Alert: {
        variants: {
          success: {
            container: {
              bg: "#25434F",
              color: "#FAF9F6",
              fontFamily: "Orbitron",
              letterSpacing: "1.5px",
              textTransform: "uppercase",
            },
          },
        },
      },
      Menu: {
        baseStyle: {
          list: {
            bg: "samaBlack",
            border: "1px solid samaTeal",
            color: "samaTeal.500",
          },
          item: {
            bg: "samaBlack",
            _hover: {
              bg: "samaTeal.500",
              color: "samaBlack",
            },
            _focus: {
              bg: "samaTeal.500",
              color: "samaBlack",
            },
          },
        },
      },
    },
  }),
  wagmi: createConfig({
    autoConnect: false,
    connectors,
    publicClient,
  }),
  rainbowKit: darkTheme({
    accentColor: "#FAF9F6",
    accentColorForeground: "#191919",
    borderRadius: "small",
    overlayBlur: "small",
  }),
};
