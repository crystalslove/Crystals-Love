pragma solidity ^0.4.21;

contract Token {
	function transfer( address _to, uint256 _value ) public returns ( bool success );
	function transferFrom( address _from, address _to, uint256 _value ) public returns ( bool success );
}

contract SafeMath {
	function safeAdd( uint a, uint b ) internal pure returns ( uint ) {
		uint 	c;

		c = a + b;
		assert( c >= a && c >= b );
		return c;
	}
}

contract Crystals is SafeMath {

	mapping ( bytes32 => mapping ( address => uint ) ) public _tokens;

	function 	depositEth() payable public {
 		assertQuantity( msg.value );
		_tokens[0][msg.sender] = safeAdd( _tokens[0][msg.sender], msg.value );
	//	Deposit( 0, msg.sender, msg.value, _tokens[0][msg.sender] );
 	}

	function 	withdrawEth( uint amount ) public {
		assertQuantity( amount );
		_tokens[0][msg.sender] = safeSub( _tokens[0][msg.sender], amount );
		msg.sender.transfer( amount );
	//	Withdraw( 0, msg.sender, amount, _tokens[0][msg.sender] );
	}

	function 	depositToken( address token, uint amount ) public {
		assertToken( token );
		assertQuantity( amount );
		_tokens[token][msg.sender] = safeAdd( _tokens[token][msg.sender], amount );
		if ( Token( token ).transferFrom( msg.sender, this, amount ) == false ) {
			assert( false );
		}
	//	Deposit( token, msg.sender, amount , _tokens[token][msg.sender] );
	}

	function 	withdrawToken( address token, uint amount ) public {
		assertToken( token );
		assertQuantity( amount );

		_tokens[token][msg.sender] = safeSub( _tokens[token][msg.sender], amount );
		if ( Token( token ).transfer( msg.sender, amount ) == false ) {
			assert( false );
		}
		//Withdraw( token, msg.sender, amount, _tokens[token][msg.sender] );
	}

	function 	assertQuantity( uint amount ) private pure {
		if ( amount == 0 ) {
			require( false );
		}
	}

	function 	assertToken( address token ) private pure {
		if ( token == 0 ) {
			require( false );
		}
	}
}
