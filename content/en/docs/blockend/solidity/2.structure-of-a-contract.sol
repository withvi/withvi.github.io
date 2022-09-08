// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.16;

/**
 * @dev State Variables
 */
contract SimpleStorage {
    // State variable
    uint256 storeData;
}

/**
 * @dev Functions can inside or outside the contract
 */
contract SimpleAuction {
    // Inside contract
    function bid() public payable {}
}

// Outside contract
function helper(uint256 x) pure returns (uint256) {
    return x * 2;
}

/**
 * @dev Function modifiers can be used to amend the semantics of functions in a declarative way
 */
contract Purchase {
    address public seller;

    // Modifier
    modifier onlySeller() {
        require(msg.sender == seller, "Only seller can call this.");
        _;
    }

    // Modifier usage
    function abort() public view onlySeller {}
}

/**
 * @dev Events are convenience interfaces with the EVM logging facilities.
 */
contract SimpleAuction_Event {
    // Event
    event HighestBidIncreased(address bidder, uint256 amount);

    function bid() public payable {
        // ...
        // Triggering event
        emit HighestBidIncreased(msg.sender, msg.value);
    }
}

/**
 * @dev Errors allow you to define descriptive names and data for failure situations.
 * Errors can be used in revert statements. In comparison to string descriptions, errors are much cheaper and allow you to encode additional data.
 */
/// Not enough funds for transfer. Requested `requested`, but only `available` available.
error NotEnoughFunds(uint256 requested, uint256 available);

contract Token {
    mapping(address => uint256) balances;

    function transfer(address to, uint256 amount) public {
        uint256 balance = balances[msg.sender];
        if (balance < amount) revert NotEnoughFunds(amount, balance);
        balances[msg.sender] -= amount;
        balances[to] += amount;
        // ...
    }
}

/**
 * @dev Enum Types can be used to create custom types with a finite set of 'constant values'.
 */
contract Purchase_Enum {
    // Enum
    enum State {
        Created,
        Locked,
        Inactive
    }
}

/**
 * @dev Struct Types are custom defined types that can group several variables
 */
contract Ballot {
    // Struct
    struct Voter {
        uint256 weight;
        bool voted;
        address delegates;
        uint256 vote;
    }
}
