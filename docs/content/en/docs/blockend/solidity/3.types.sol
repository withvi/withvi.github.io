// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.16;

/**
Value Types

  Booleans

  Integers

  Address
    address: Holds a 20 byte value (size of an Ethereum address).
      .balance(uint)
      .code(bytes memory)
      .codehash(bytes32)
      .call(bytes memory) returns (bool, bytes memory)
      .delegatecalls(bytes memory) returns (bool, bytes memory)
      .staticccall(bytes memory) returns (bool, bytes memory)
    address payable: Same as address, but with the additional members transfer and send. is an address you can send Ether to
      .transfer(uint amount)
      .send(uint amount) returns (bool)

Contract Types

Fixed-size byte arrays. bytes1, bytes2, bytes3, ..., bytes32
  .length yields the fixed length of the byte array (read-only).
Dynamically-sized byte array
  bytes: Dynamically-sized byte array. Not a value-type!
  string: Dynamically-sized UTF-8-encoded string. Not a value-type!

Address Literals

Rational and Integer Literals

String Literals and Types

Unicode Literals







Hexadecimal Literals

Enums
  enum ActionChoices { GoLeft, GoRight, GoStraight, SitStill }

User Defined Value Types
  type myDefinedValueTypes is uint256;

Function Types
 */