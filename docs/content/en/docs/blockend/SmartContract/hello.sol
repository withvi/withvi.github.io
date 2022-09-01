pragma solidity >=0.5.0 <0.6.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
    uint256 randNonce = 0;

    // Create attackVictoryProbability here

    function randMod(uint256 _modulus) internal returns (uint256) {
        randNonce++;
        return
            uint256(keccak256(abi.encodePacked(now, msg.sender, randNonce))) %
            _modulus;
    }

    // Create new function here
}
s