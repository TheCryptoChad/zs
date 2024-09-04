// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";

// contract ZeroSumVessels is ERC721 {
//     using Counters for Counters.Counter;

//     mapping(address => bool) private _hasMinted;

//     Counters.Counter private _tokenIdCounter;

//     constructor() ERC721("Zero Sum Vessels", "ZSV") {}

//     function safeMint() public {
//         require(!_hasMinted[msg.sender], "You already minted");
//         uint256 tokenId = _tokenIdCounter.current() + 1;
//         _tokenIdCounter.increment();
//         _safeMint(msg.sender, tokenId);
//         _hasMinted[msg.sender] = true;
//     }

//     function hasMinted(address account) public view returns (bool) {
//         return _hasMinted[account];
//     }
// }