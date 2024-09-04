// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// contract Samarium is ERC20, ERC20Burnable, Ownable {
//     mapping (address => uint) private mintAllowances;

//     constructor() ERC20("Samarium", "SMRM") {}

//     function mint() public {
//         uint balance = mintAllowances[msg.sender];
//         require(balance != 0, "No tokens to mint");
//         _mint(msg.sender, balance);
//         mintAllowances[msg.sender] = 0;
//     }

//     function increaseMintAllowance(address user, uint amount) public onlyOwner {
//         mintAllowances[user] += amount;
//     }

//     function checkMintAllowance(address user) public view returns (uint) {
//         return mintAllowances[user];
//     }
// }