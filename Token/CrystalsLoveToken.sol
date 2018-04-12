pragma solidity ^0.4.20;

import "browser/PausableToken.sol";
import "browser/BurnableToken.sol";
import "browser/ERC827Token.sol";

contract CrystalsLove is PausableToken, BurnableToken, ERC827Token {
	string public constant name = "CRYSTALS";
	string public constant symbol = "CRS";
	uint8 public constant decimals = 18;

	uint256 public constant INITIAL_SUPPLY = 192000000 * (10 ** uint256(decimals));

	function CrystalsLove  () public {
		totalSupply_ = INITIAL_SUPPLY;
		balances[msg.sender] = INITIAL_SUPPLY;
		Transfer(0x0, msg.sender, INITIAL_SUPPLY);
	}
}
