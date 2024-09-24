function asmLoops() public returns (uint_r) {
    assembly {
        let i := 0
    loop:
        i := add(i, 1)
        _r := add(_r, 1)
        jumpi(loop, lt(i, 10))
    }
}
