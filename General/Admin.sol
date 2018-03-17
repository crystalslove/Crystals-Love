pragma solidity ^0.4.21;

contract Admin {

	address private _admin;

	function 	Admin( address admin ) public {
		if ( admin == address( 0x0 ) )
			require( false );
		_admin = admin;
	}

	function 	assertAdmin() internal view returns ( bool ) {
		if ( _admin != msg.sender )
			require( false );
		return true;
	}

	function 	getAdmin() public constant returns( address admin ) {
		return 	_admin;
	}
}
