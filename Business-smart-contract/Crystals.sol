pragma solidity ^0.4.23;

contract Token {
	function transfer(address _to, uint256 _value) public returns (bool success);
	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
}

contract SafeMath {
	function safeAdd(uint a, uint b) internal pure returns (uint) {
		uint 	c;

		c = a + b;
		assert(c >= a && c >= b);
		return c;
	}
	function safeSub( uint a, uint b ) internal pure returns ( uint ) {
			assert( b <= a );
			return a - b;
	}
}

contract Crystals is SafeMath {
	struct Strongbox{
		address executor;
		uint 	amount;		
	}

	mapping(address => uint) public _balanceOf;
	mapping(bytes32 => mapping(address => Strongbox)) private _strongBoxList;
	
    address 					private	_addressTokenSmartContract;
	event BalanceOrder(address user, address executor, uint amountOrder);
	event CancelOrder(address user, address executor, uint amountOrder);
	event SendTokensForExecutor(address user, address executor, uint amountOrder);

	constructor (address token) public {
		_addressTokenSmartContract = token;
	}
			
	function 	getAddressTokenSmartContract() public constant returns (address) {
		return _addressTokenSmartContract;
	}

	function 	withdrawTokensFromWallet(uint amount) public {
		require (amount != 0);
		_balanceOf[msg.sender] = safeSub(_balanceOf[msg.sender], amount);
		if (Token(getAddressTokenSmartContract()).transfer(msg.sender, amount) == false) {
			revert();
		}
	}

	function 	addTokensForOrderWithDeposit(address executor, uint amountAdd) public {
		require (amountAdd > 0);
		require (executor != (0x0));
		require (executor != msg.sender);

		bytes32 hash = sha256(this, executor, msg.sender);
		uint amountOld = getAmount(hash, msg.sender);
	    require(amountOld > 0);
		setStrongBox(hash, executor, msg.sender, safeAdd(amountOld, amountAdd));
		if (Token(getAddressTokenSmartContract()).transferFrom(msg.sender, this, amountAdd) == false) {
			revert();
		}
		emit BalanceOrder(msg.sender, executor, safeAdd(amountOld, amountAdd));
	}

	function 	cancelOrder(address executor) public {
		require (executor != (0x0));
		require (executor != msg.sender);

		bytes32 hash = sha256(this, executor, msg.sender);
		uint amount = getAmount(hash, msg.sender);
		require(amount != 0);
		setStrongBox(hash, executor, msg.sender, 0);
		if (Token(getAddressTokenSmartContract()).transfer(msg.sender, amount) == false) {
			revert();
		}
		emit CancelOrder(msg.sender, executor, amount);
	}

	function 	sendTokensForExecutor(address executor) public {
		require(executor != (0x0));
		require (executor != msg.sender);

		bytes32 hash = sha256(this, executor, msg.sender);
		uint amount = getAmount(hash, msg.sender);
		require (amount != 0);
		setStrongBox(hash, executor, msg.sender, 0);
		_balanceOf[executor] = safeAdd(_balanceOf[executor], amount);
		emit SendTokensForExecutor(msg.sender, executor, amount);
	}

	// tx.origin need for approve ERC827.
	function 	createOrderWithDeposit(address executor, uint amount) public {
		require (amount > 0);
		require (executor != (0x0));
		require (executor != tx.origin);

		bytes32 hash = sha256(this, executor, tx.origin);
		require(getAmount(hash, tx.origin) == 0);
		setStrongBox(hash, executor, tx.origin, amount);
		if (Token(getAddressTokenSmartContract()).transferFrom(tx.origin, this, amount) == false) {
			revert();
		}
		emit BalanceOrder(tx.origin, executor, amount);
	}

	/* Strongbox */
	function 	getExecutor(bytes32 hash, address user) public constant returns (address) {
		return _strongBoxList[hash][user].executor;
	}
	function 	getAmount(bytes32 hash, address user) public constant returns (uint) {
		return _strongBoxList[hash][user].amount;
	}

	function 	setStrongBox(bytes32 hash, address executor, address user, uint amount) private {
		_strongBoxList[hash][user].executor = executor;
		_strongBoxList[hash][user].amount = amount;
	}
}