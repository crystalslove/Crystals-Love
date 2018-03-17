pragma solidity ^0.4.21;

import 	"browser/Admin.sol";

contract 	WhiteList is Admin {

	mapping( address => bool ) internal		_moderator;
	mapping( address => bool ) internal		_listAuthorizedUser;
	mapping( address => uint ) internal		_balanceAvailabeEth;

	/*
	** Construct.
	** If @param admin == 0x0, then revert transaction.
	*/
	function 	WhiteList( address admin ) public Admin( admin ){
		assertNULL( admin );
	}

	/*
	** Add the user to the whitelist.
	** The function is available only moderator.
	** If user == 0x0, then revert transaction.
	**/
	function 	setAuthorizeUser( address user, uint amountEth ) public {
		assertNULL( user );
		assertModerator();

		_listAuthorizedUser[user] = true;
		_balanceAvailabeEth[user] = amountEth;
	}

	/*
 	** The function is available only admin.
	** Function sets value in mapping moderator.
	** If msg.sender != admin, then revert transaction.
	** If @param true, then user moderator.
	** If @param false, then user no moderator.
	** If user = 0x0, then revert transaction.
	*/
	function	changeStatusModerator( address user, bool status ) public {
		assertAdmin();
		assertNULL( user );

		_moderator[user] = status;
	}

	function 	getAuthorizeUser( address user ) public constant returns ( bool ) {
		return 	_listAuthorizedUser[user];
	}

	function 	getModerator( address user ) public constant returns ( bool ) {
		return 	_moderator[user];
	}

	function 	getBalanceAbailabeEthereum( address user ) public constant returns ( uint ) {
		return 	_balanceAvailabeEth[user];
	}

	function 	assertModerator() view internal {
		if ( _moderator[msg.sender] == false )
			require( false );
	}

	function 	assertUserAuthorized( address user ) view internal {
		if ( _listAuthorizedUser[user] == false )
			require( false );
	}

	function    assertNULL( address user ) pure internal {
		if ( user == address( 0x0 ) )
			 require( false );
	}
}
