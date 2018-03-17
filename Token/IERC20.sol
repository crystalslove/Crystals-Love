pragma solidity ^0.4.21;

/* ----------------------------------------------------------------------------------------------
* Sample fixed supply token contract
* Enjoy. (c) BokkyPooBah 2017. The MIT Licence.
* ----------------------------------------------------------------------------------------------
*
* ERC Token Standard #20 Interface
* https://github.com/ethereum/EIPs/issues/20
*/
interface IERC20 {

	// Get the total token supply
	function 	totalSupply() external constant returns ( uint supply );

	// Get the account balance of another account with address _owner
	function 	balanceOf( address _owner ) external constant returns ( uint balance );

	// Send _value amount of tokens to address _to
	function 	transfer( address _to, uint _value ) external returns ( bool success );

	// Send _value amount of tokens from address _from to address _to
	function 	transferFrom( address _from, address _to, uint _value ) external returns ( bool success );

	// Allow _spender to withdraw from your account, multiple times, up to the _value amount.
	// If this function is called again it overwrites the current allowance with _value.
	// this function is required for some DEX functionality
	function 	approve( address _spender, uint _value ) external returns ( bool success );

	// Returns the amount which _spender is still allowed to withdraw from _owner
	function 	allowance( address _owner, address _spender ) external constant returns ( uint remaining );

	// Triggered when tokens are transferred.
	event 		Transfer( address indexed _from, address indexed _to, uint _value );

	// Triggered whenever approve(address _spender, uint _value) is called.
	event 		Approval( address indexed _owner, address indexed _spender, uint _value );
}
