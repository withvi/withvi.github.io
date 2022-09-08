/**
* @title SPDX License Identifier
* @dev Trust in smart contracts can be better established if their source code is available.
*/
// SPDX-License-Identifier: UNLICENSED
// SPDX-License-Identifier: UNLICENSE
// SPDX-License-Identifier: MIT


/**
* @title Pragmas 
* @dev Define pragma version, abi-coder version
*/
pragma solidity >=0.5.0 <0.7.4;
pragma solidity ^0.5.2;

pragma solidity 0.7.4;
pragma abicoder v2;
// pragma experimental ABIEncoderV2;

pragma solidity 0.8.0;
pragma abicoder v1;

pragma experimental SMTChecker;

/**
* @title Importing other Source Files
* @dev 
*/
import "filename";

import "filename" as symbolName;
// import * as symbolName from "filename";

import {symbol1 as alias, symbol2} from "filename";

/**
* @title Comments
* @dev 
*/
// This is a single-line comment.

/*
This is a
multi-line comment.
*/

/// NatSpec Contract
/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

/// NatSpec Statevarible
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details
/// @return Documents the return variables of a contract’s function state variable
/// @inheritdoc	Copies all missing tags from the base function (must be followed by the contract name)

/// NatSpec Function
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details
/// @param Documents a parameter just like in doxygen (must be followed by parameter name)
/// @return Documents the return variables of a contract’s function state variable
/// @inheritdoc	Copies all missing tags from the base function (must be followed by the contract name)

/// NatSpec Event
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details
/// @param Documents a parameter just like in doxygen (must be followed by parameter name)