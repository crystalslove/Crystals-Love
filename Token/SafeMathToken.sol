pragma solidity ^0.4.21;

contract SafeMathToken {
	function add( uint a, uint b ) internal pure returns ( uint ) {
		uint c;

		c = a + b;
		assert( c >= a ); /* defence Owerflow */
		return c;
	}

	function sub( uint a, uint b ) internal pure returns ( uint ) {
			assert( b <= a ); /* defence Owerflow */
			return a - b;
	}
}
