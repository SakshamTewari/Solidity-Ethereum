pragma solidity ^0.8.0;

contract Assembly {
    function nativeLoops() public returns (uint _r) {
        for (uint i = 0; i < 10; i++) {
            _r++;
        }
    }

    function asmLoops() public returns (uint_r) {
        assembly {
            let i := 0
        loop:
            i := add(i, 1)
            _r := add(_r, 1)
            jumpi(loop, lt(i, 10))
        }
    }
}
