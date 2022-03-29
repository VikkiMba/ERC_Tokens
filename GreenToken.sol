// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7;  

// import libraries so we can inherit functionalities
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GreenToken is ERC20, Ownable {
    constructor() ERC20("GreenToken", "GTK") {
        _mint(msg.sender, 1000_000 * 10 ** decimals());
    }

// Only the author of this contract can mint tokens for free
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    

    function buyToken(address  receiver) public payable {
        // ensures that this function would roll back if buyer doesn't have enough token
        require(msg.sender.balance >= msg.value, "Not enough ether");
        
        // gets ether from buyer
        uint256 amountToBuy = msg.value;

        // calculates the exchange rate of ether with token
        uint256 _amountToMint = (amountToBuy * 1000);
        
        /* mints new tokens for buyer
        also increment buyers balance with the tokens
        also increment total supply
        */
        _mint(receiver, _amountToMint);
     
    }


}