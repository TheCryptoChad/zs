import { ChakraProviderProps } from "@chakra-ui/react";
import { Contract } from "ethers";
import { Vector3 } from "three";
import { FallbackTransport } from "viem";
import { PublicClient, WebSocketPublicClient } from "wagmi";

declare global {
  type Vessel = {
    id: number;
    name: string;
    position: Vector3;
    isLocked: boolean;
    miningEndTime: number | null;
    range: number;
    speed: number;
    radar: number;
  };

  type Update = {
    version: string;
    title: string;
    changes: string;
    date: string;
  };

  namespace Auth {
    type PayloadContent = {
      uuid: string;
      gamerTag: string;
      iat: number;
      exp: number;
    };
  }

  type VesselStatus = "Idle" | "Mining" | "Docked" | "Finished Mining";

  namespace Entity {
    type Self = {
      uuid: string;
      address: string | null | undefined;
      nextFaucetUse: string;
      username: string;
      linkedUsername: boolean;
      pendingMints: number[] | null;
      referredBy: string | null;
      referrals: string[] | null;
      referralCode: string;
      pendingReferral: string;
    };

    type Resources = {
      astralite: number;
      samarium: number;
      calamarite: number;
      contractAstralite: number;
      contractSamarium: number;
      contractCalamarite: number;
    };

    type Tile = {
      x: number;
      y: number;
    };
  }

  namespace Workbench {
    type Craftable = {
      blueprint: number;
      name: string;
      address: string;
      id: number;
      src: string;
      description: string;
      requirements: CraftableRequirement[];
      reqAmount: { [key: string]: { [key: string]: number } };
    };

    type Contracts = {
      [signer?: string]: JsonRpcSigner;
      [samarium?: string]: Contract;
      [astralite?: string]: Contract;
      [calamarite?: string]: Contract;
      [upgradeLv1?: string]: Contract;
      [upgradeLv2?: string]: Contract;
      [upgradeLv3?: string]: Contract;
      [upgradeLv4?: string]: Contract;
      [upgradeLv5?: string]: Contract;
      [blueprintCollection?: string]: Contract;
    };
  }

  namespace Props {
    type ActionsMenuButton = {
      text: string;
      effect: () => void;
      disabled: boolean;
    };
  }

  namespace API {
    type RequestOptions = {
      method: string;
      endpoint: string;
      body?: string;
      headers?: Record<string, string>;
    };

    type VesselResponse = {
      id: number;
      name: string;
      isLocked: boolean;
      miningEndTime: number | null;
      ownerAddress: string;
      range: number;
      speed: number;
      radar: number;
      x: number | undefined;
      y: number | undefined;
    };
  }

  namespace Zustand {
    type VesselState = {
      selectedVessel: Vessel | null;
      selectVessel: (vessel: Vessel) => void;
      clearSelectedVessel: () => void;
      vessels: Map<number, Vessel>;
      addVessel: (vessel: Vessel) => void;
    };

    type SoundState = {
      sound: boolean;
      toggleSound: () => void;
    };

    type UserState = {
      uuid: string;
      address: string | null;
      updateUser: (state: Partial<Zustand.UserState>) => void;
    };

    type EventState = {
      event: Event | null;
      send: (event: Event) => void;
      clear: () => void;
    };

    type Event = {
      type: EventType;
      payload: EventPayload.GOTO | Vessel | null;
      // eslint-disable-next-line
      options?: any;
    };

    type EventType =
      | "GOTO"
      | "ACTIONSMENU_MOVE"
      | "ACTIONSMENU_MINE"
      | "ACTIONSMENU_SHOW"
      | "VESSEL_FOLLOW"
      | null;

    type EventPayload = {
      GOTO: {
        position: Vector3;
        instant: boolean;
      };
    };
  }

  namespace Config {
    type App = {
      contracts: {
        vessels: {
          address: HexString;
          // eslint-disable-next-line
          abi: any[];
        };
      };
      chakra: ChakraProviderProps;
      wagmi: Config<PublicClient<FallbackTransport>, WebSocketPublicClient>;
      rainbowKit: Theme;
    };

    type Contract = {
      address: HexString;
      abi: string[];
    };

    type HexString = `0x${string}`;
  }

  interface SquidBalancesResponse {
    data: {
      erc20Contracts: Erc20Contract[];
      erc1155Contracts: {
        address: string;
        tokens: {
          tokenId: number;
          owners: {
            address: string;
            balance: string;
          }[];
        }[];
      }[];
    };
  }

  interface Erc20Contract {
    address: string;
    decimals: number;
    owners: Owner[];
  }

  interface Erc1155Contract {
    address: string;
    tokens: Erc1155Token[];
  }

  interface Erc1155Token {
    tokenId: number;
    owners: Owner[];
  }

  interface Owner {
    address: string;
    balance: string;
  }

  interface Window {
    // eslint-disable-next-line
    ethereum: any;
  }
}

export {};
