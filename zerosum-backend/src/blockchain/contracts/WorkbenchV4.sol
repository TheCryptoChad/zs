// //SPDX-License-Identifier: GPL-3.0-or-later

// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

// abstract contract WorkbenchV4 is
//     AccessControlEnumerable
// {
//     event BlueprintCollectionAdded(
//         uint256 blueprintId,
//         address blueprintCollectionAddress
//     );

//     event BlueprintCollectionTemplateChanged(address newTemplate);

//     function GOVERNANCE_ROLE() external view virtual returns (bytes32);
//     function ADMIN_ROLE() external view virtual returns (bytes32);

//     function numBlueprintCollections() external view virtual returns (uint256);

//     function blueprintCollectionTemplate() external view virtual returns (address);

//     function blueprintCollection(
//         uint256 _id
//     ) public view virtual returns (address);

//     function blueprintCollections(
//         uint256 _startIdInclusive,
//         uint256 _endIdExclusive
//     )
//         public
//         view
//         virtual
//         returns (address[] memory);


//     function addBlueprintCollection(
//         address _governor,
//         address _admin
//     ) external virtual returns (uint256);

//     function craft(
//         uint256 _blueprintCollectionId,
//         uint256 _blueprintId,
//         uint256 _amount
//     ) external payable virtual;

//     function craftSig(
//         uint256 _blueprintCollectionId,
//         bytes calldata _data,
//         bytes calldata _signature
//     ) external payable virtual;


//     function VERSION() external view virtual returns (uint8);
// }
