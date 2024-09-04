// //SPDX-License-Identifier: GPL-3.0-or-later

// pragma solidity ^0.8.0;

// contract DomainV4 {
//     enum AssetType {
//         UNKNOWN,
//         NATIVE,
//         ERC20,
//         ERC721,
//         ERC1155,
//         NEW1,
//         NEW2,
//         NEW3,
//         NEW5,
//         NEW6,
//         NEW7,
//         NEW8
//     }

//     enum CraftMode {
//         NONE,
//         SELF,
//         OPERATOR_ONLY
//     }

//     struct Asset {
//         /* asset ID if any */
//         uint256 assetId;
//         /* asset contract address */
//         address assetAddress;
//         /* asset type */
//         AssetType assetType;
//     }

//     struct CallData {
//         address target;
//         bytes data;
//     }

//     struct Blueprint {
//         CraftMode mode;
//         address inputTarget;
//         uint256 availableToMint;
//         uint256[] inputAssetAmounts;
//         Asset[] inputAssets;
//         uint256[] outputAssetAmounts;
//         Asset[] outputAssets;
//         CallData[] outputCalldatas;
//     }
// }
