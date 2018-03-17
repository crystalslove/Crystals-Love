pragma solidity ^0.4.21;

import "browser/SafeMathToken.sol";
import "browser/IERC20.sol";

contract 	ERC20 is SafeMathToken, IERC20 {
	uint	internal 	_totalSupply;
	string 	internal	_name;
	string	internal	_symbol;
	uint8	internal	_decimals;

	mapping ( address => uint )							internal _balanceOf;
	mapping ( address => mapping ( address => uint ) )	internal _allowance;

	function 	ERC20( string nameToken, string symbolToken, uint supply, uint8 decimals ) public {
		uint 	balance;

		balance = supply * 10 ** uint( decimals );
		_name = nameToken;
		_symbol = symbolToken;
		_balanceOf[msg.sender] = balance;
		_totalSupply = balance;
		_decimals = decimals;
	}

	function 	totalSupply() external constant returns ( uint ) {
		return _totalSupply;
	}

	function 	balanceOf( address user ) external constant returns ( uint ) {
		return _balanceOf[user];
	}

	function 	allowance( address owner, address spender ) external constant returns ( uint ) {
		return _allowance[owner][spender];
	}

	function 	transfer( address to, uint amount ) external returns ( bool ) {
		require(_balanceOf[msg.sender] >= amount);

		_balanceOf[msg.sender] = sub( _balanceOf[msg.sender], amount );
		_balanceOf[to] = add( _balanceOf[to], amount );

		emit Transfer( msg.sender, to, amount );
		return true;
	}

	function 	transferFrom( address from, address to, uint amount ) external returns ( bool ) {
		require( _balanceOf[from] >= amount );
		require( _allowance[from][msg.sender] >= amount );

		_allowance[from][msg.sender] = sub( _allowance[from][msg.sender], amount );
		_balanceOf[from] = sub( _balanceOf[from], amount );
		_balanceOf[to] = add( _balanceOf[to], amount );

		emit Transfer( from, to, amount );
		return true;
	}

	function 	approve( address spender, uint amount ) external returns ( bool ) {
		_allowance[msg.sender][spender] = amount;

		emit Approval( msg.sender, spender, amount );
		return true;
	}

	function 	name() external constant returns ( string ) {
		return _name;
	}

	function 	symbol() external constant returns ( string ) {
		return 	_symbol;
	}

	function 	decimals() external constant returns ( uint8 ) {
		return _decimals;
	}
}
