pragma solidity ^0.4.21;

import "./PausableToken.sol";
import "./BurnableToken.sol";
import "./ERC827Token.sol";

contract CrystalsToken is PausableToken, BurnableToken, ERC827Token {
	string public constant name = "CRYSTALS";
	string public constant symbol = "CRS";
	uint8 public constant decimals = 18;

	uint256 public constant INITIAL_SUPPLY = 247000000 * (10 ** uint256(decimals));

	function CrystalsToken  () public {
		totalSupply_ = INITIAL_SUPPLY;
		balances[msg.sender] = INITIAL_SUPPLY;
		emit Transfer(0x0, msg.sender, INITIAL_SUPPLY);
	}
}
