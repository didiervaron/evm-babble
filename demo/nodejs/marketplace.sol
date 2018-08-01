pragma solidity ^0.4.11;

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

    function Marketplace(string productName, uint productPrice) public {
        product = Product({
            owner: msg.sender,
            name: productName,
            price: productPrice,
            sold: false
        });
    }

    function buy() public payable {
        product.owner.transfer(product.price);
        emit Buy(msg.sender);
        product.sold = true;
        emit Sold(true);
    }
}