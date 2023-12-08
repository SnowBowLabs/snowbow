// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {Ownable} from "solady/auth/Ownable.sol";
import "solady/utils/LibClone.sol";

import {ISnowbowProduct, ISnowbowProductDef} from "src/interfaces/ISnowbowProduct.sol";

contract SnowbowFactory is Ownable, ISnowbowProductDef {
    event ProductCreate(address);

    address internal _impl;

    constructor(address owner_) {
        _initializeOwner(owner_);
    }

    function createProduct(ProductInitArgs calldata args) public {
        // clone and initialize
        address product = LibClone.clone(_impl);
        ISnowbowProduct(product).initialize(args);

        emit ProductCreate(product);
    }

    function setImplementation(address impl) public onlyOwner {
        _impl = impl;
    }
}
