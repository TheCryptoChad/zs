// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.9;

// import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
// import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// contract ZSUpgradesLv4 is ERC1155, ERC1155Burnable, Ownable {
//     constructor() ERC1155("") {}

//     function mint(address account, uint256 id, uint256 amount, bytes memory data)
//         public
//         onlyOwner
//     {
//         _mint(account, id, amount, data);
//     }

//     function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
//         public
//         onlyOwner
//     {
//         _mintBatch(to, ids, amounts, data);
//     }

//     function _beforeTokenTransfer(
//         address operator,
//         address from,
//         address to,
//         uint256[] memory ids,
//         uint256[] memory amounts,
//         bytes memory data
//     ) pure override internal {
//         require(from == address(0) || to == address(0), "This a Soulbound token.");
//     }
// }