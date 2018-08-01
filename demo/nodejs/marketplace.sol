pragma solidity ^0.4.24;

contract Marketplace {

    struct Product {
        address owner;
        string name;
        uint price;
        bool sold;
    }

    Product product;

    event Sold(bool sold);
    event Buy(address buyer);

    modifier ownerFunction {
        require(product.owner == msg.sender);
        _;
    }

    constructor(string productName, uint productPrice) public {
        product = Product(msg.sender, productName, productPrice, false);
    }

    function buy() public payable {
        product.owner.transfer(product.price);
        emit Buy(msg.sender);
        product.sold = true;
        emit Sold(true);
    }
}