import { Contract } from "ethers";
import { queryClient } from "../../../../../main";

export const getFormattedAmount = (amount: number) => {
  if (amount < 1000) return amount;
  const divided = amount / 1000;
  return (divided % 1 === 0 ? Math.floor(divided) : divided.toFixed(1)) + "K";
};

export const getRequiredAmount = (
  name: string,
  schematic: Workbench.Craftable,
): number => {
  const splitName: string[] = name.split(" ");
  const upgradeType: string = splitName[0].toLowerCase();
  const upgradeLevel: string = splitName[splitName.length - 1];
  return schematic.reqAmount[upgradeType][upgradeLevel];
};

export const craft = async (
  blueprint: number,
  contracts: Workbench.Contracts,
  setPending: Function,
): Promise<void> => {
  try {
    await contracts.blueprintCollection!.craft(BigInt(blueprint), BigInt(1));
    setTimeout(async () => {
      queryClient.invalidateQueries("balances");
    }, 12500);
  } catch (error) {
    console.error(error);
    throw error;
  } finally {
    setTimeout(() => setPending(false), 12500);
  }
};

export const approve = async (
  blueprint: number,
  contracts: Workbench.Contracts,
  setPending: Function,
): Promise<void> => {
  try {
    let contractsAndAmounts: [Contract | undefined, number, number, number] = [
      undefined,
      0,
      0,
      0,
    ];
    switch (blueprint) {
      case 1:
        contractsAndAmounts = [undefined, 5_000, 2_500, 2_500];
        break;
      case 2:
        contractsAndAmounts = [undefined, 2_500, 5_000, 2_500];
        break;
      case 3:
        contractsAndAmounts = [undefined, 2_500, 2_500, 5_000];
        break;
      case 4:
        contractsAndAmounts = [contracts.upgradeLv1, 10_000, 5_000, 5_000];
        break;
      case 5:
        contractsAndAmounts = [contracts.upgradeLv1, 5_000, 10_000, 5_000];
        break;
      case 6:
        contractsAndAmounts = [contracts.upgradeLv1, 5_000, 5_000, 10_000];
        break;
      case 7:
        contractsAndAmounts = [contracts.upgradeLv2, 25_000, 12_500, 12_500];
        break;
      case 8:
        contractsAndAmounts = [contracts.upgradeLv2, 12_500, 25_000, 12_500];
        break;
      case 9:
        contractsAndAmounts = [contracts.upgradeLv2, 12_500, 12_500, 25_000];
        break;
      case 10:
        contractsAndAmounts = [contracts.upgradeLv3, 50_000, 25_000, 25_000];
        break;
      case 11:
        contractsAndAmounts = [contracts.upgradeLv3, 25_000, 50_000, 25_000];
        break;
      case 12:
        contractsAndAmounts = [contracts.upgradeLv3, 25_000, 25_000, 50_000];
        break;
      case 13:
        contractsAndAmounts = [contracts.upgradeLv4, 120_000, 60_000, 60_000];
        break;
      case 14:
        contractsAndAmounts = [contracts.upgradeLv4, 60_000, 120_000, 60_000];
        break;
      case 15:
        contractsAndAmounts = [contracts.upgradeLv4, 60_000, 60_000, 120_000];
        break;
    }
    if (contractsAndAmounts[0])
      await contractsAndAmounts[0].setApprovalForAll(
        contracts.blueprintCollection!.target,
        true,
      );
    const astraliteTx = await contracts.astralite!.approve(
      contracts.blueprintCollection!.target,
      BigInt(contractsAndAmounts[1]),
    );
    const samariumTx = await contracts.samarium!.approve(
      contracts.blueprintCollection!.target,
      BigInt(contractsAndAmounts[2]),
    );
    const calamariteTx = await contracts.calamarite!.approve(
      contracts.blueprintCollection!.target,
      BigInt(contractsAndAmounts[3]),
    );
    await astraliteTx!.wait();
    await samariumTx!.wait();
    await calamariteTx!.wait();
  } catch (error) {
    console.error(error);
    throw error;
  } finally {
    setTimeout(() => setPending(false), 5000);
  }
};
