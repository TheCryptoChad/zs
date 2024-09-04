// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";

// contract ZeroSumReferrals is ERC721 {
//     using Counters for Counters.Counter;

//     mapping(address => address) private _hasBeenReferred;
//     mapping(address => address[]) private _referrals;
//     mapping(uint => bool) private _nonces;

//     Counters.Counter private _tokenIdCounter;

//     address private owner = 0xAAC5e7E4D9D3B535a286E5a784d64D67Af7dD4A1;

//     event Referral(address indexed referrer, address indexed referral);

//     constructor() ERC721("Zero Sum Referrals", "ZSR") {}

//     function _beforeTokenTransfer(address from, address to, uint256 tokenId,  uint256 batchSize) pure override internal {
//         require(from == address(0) || to == address(0), "This a Soulbound token.");
//     }

//     function safeMint(address referrer, string memory message, uint nonce, bytes memory signedMessage) public {
//         require(_hasBeenReferred[msg.sender] == address(0), "You've already been referred");
//         require(msg.sender != referrer, "You can't refer yourself");
//         require(!_nonces[nonce], "Repeated nonce");

//         verifySignature(message, nonce, signedMessage);

//         uint256 tokenId = _tokenIdCounter.current() + 1;
//         _tokenIdCounter.increment();
//         _safeMint(msg.sender, tokenId);

//         _hasBeenReferred[msg.sender] = referrer;
//         _referrals[referrer].push(msg.sender);
//         _nonces[nonce] = true;
        
//         emit Referral(referrer, msg.sender);
//     }

//     function verifySignature(string memory message, uint nonce, bytes memory signedMessage) internal view {
//         require(signedMessage.length == 65, "Invalid signature length");

//         bytes32 messageHash = keccak256(abi.encodePacked(message, nonce));
//         bytes32 signedMessageHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash));
//         bytes32 r;
//         bytes32 s;
//         uint8 v;

//         assembly {
//             r := mload(add(signedMessage, 32))
//             s := mload(add(signedMessage, 64))
//             v := byte(0, mload(add(signedMessage, 96)))
//         }

//         require(ecrecover(signedMessageHash, v, r, s) == owner, "Unauthorized call");
//     }

//     function hasBeenReferred(address account) public view returns (address) {
//         return _hasBeenReferred[account];
//     }

//     function referrals(address account) public view returns (address[] memory) {
//         return _referrals[account];
//     }
// }