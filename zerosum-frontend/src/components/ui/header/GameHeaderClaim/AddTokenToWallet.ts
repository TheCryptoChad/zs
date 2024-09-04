import { handleNetworkSwitching, supportedChains } from "../../../../utils/chains/chains";

export const addTokenToWallet = async (
  chainId: number | undefined,
  token: string,
  id?: number
): Promise<void> => {
  if (!chainId) return;

  const decimals = 0;
  let address = "";
  let symbol = "";
  let image = "";

  switch (token) {
    case "astralite":
      address = supportedChains[chainId].astralite;
      symbol = "ASTRLT";
      image = `https://raw.githubusercontent.com/Rebelsama/assets/main/${token}.png`;
      break;
    case "samarium":
      address = supportedChains[chainId].samarium;
      symbol = "SMRM";
      image = `https://raw.githubusercontent.com/Rebelsama/assets/main/${token}.png`;
      break;
    case "calamarite":
      address = supportedChains[chainId].calamarite;
      symbol = "CLMRT";
      image = `https://raw.githubusercontent.com/Rebelsama/assets/main/${token}.png`;
      break;
    case "ship":
      await handleNetworkSwitching(chainId);
      address = supportedChains[chainId].vessels;
      symbol = "ZSV";
      image = `https://raw.githubusercontent.com/Rebelsama/assets/main/${token}.png`;
  }

  try {
    await window.ethereum.request({
      method: "wallet_watchAsset",
      params: {
        type: token === "ship" ? "ERC721" : "ERC20",
        options: {
          address: address,
          symbol: symbol,
          decimals: decimals,
          image: image,
          tokenId: id ? String(id) : "0",
        },
      },
    });
  } catch (error: any) {
    console.log(error);
    throw error;
  }
};
