pragma solidity ^0.4.21;

library SafeMathSale {

	function mul( uint a, uint b ) internal pure returns ( uint ) {
		uint c;

		if ( a == 0 ) {
			return 0;
		}
		c = a * b;
		assert( c / a == b );
		return c;
	}

	function sub( uint a, uint b ) internal pure returns ( uint ) {
			assert( b <= a );
			return a - b;
	}

	function add( uint a, uint b ) internal pure returns ( uint ) {
		uint c;

		c = a + b;
		assert( c >= a );
		return c;
	}

}
