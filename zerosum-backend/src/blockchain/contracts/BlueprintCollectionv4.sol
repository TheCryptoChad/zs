// //SPDX-License-Identifier: GPL-3.0-or-later

// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

// import "./DomainV4.sol";

// abstract contract BlueprintCollectionV4 is
//     AccessControlEnumerable
// {
//     event BlueprintCrafted(
//         uint256 blueprintId,
//         address recipient,
//         uint256 amount
//     );

//     event BlueprintSigCrafted(
//         bytes32 tag,
//         uint256 blueprintId,
//         address recipient,
//         uint256 amount
//     );

//     event BlueprintAdded(uint256 blueprintId);

//     event BlueprintMintNumChanged(uint256 blueprintId, uint256 availableToMint);

//     event BlueprintInputTargetChanged(uint256 blueprintId, address inputTarget);


//     function GOVERNANCE_ROLE() external view virtual returns (bytes32);
//     function ADMIN_ROLE() external view virtual returns (bytes32);
//     function OPERATOR_ROLE() external view virtual returns (bytes32);

//     function numBlueprints() external view virtual returns (uint256);
//     function collectionIdentifier() external view virtual returns (uint256);

//     function VERSION() external view virtual returns (uint16);

//     function parent() external view virtual returns (address);

//     function isTagAlreadyUsed(bytes32 _tag) public view virtual returns (bool);

//     function blueprint(
//         uint256 _id
//     ) public view virtual;

//     function blueprints(
//         uint256 _startIdInclusive,
//         uint256 _endIdExclusive
//     )
//         public
//         view
//         virtual
//         returns (DomainV4.Blueprint[] memory);

//     function addBlueprint(
//         DomainV4.Blueprint calldata _bp
//     ) external virtual;

//     function setBlueprintMintsAvailable(
//         uint256 _bpId,
//         uint256 _availableToMint
//     ) external virtual;

//     function setBlueprintInputTarget(
//         uint256 _bpId,
//         address _inputTarget
//     ) external virtual;

//     function craft(
//         uint256 _bpId,
//         uint256 _amount
//     ) external payable virtual;

//     function craftSig(
//         bytes calldata data,
//         bytes calldata signature
//     ) external payable virtual;
// }
