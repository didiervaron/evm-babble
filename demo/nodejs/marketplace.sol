pragma solidity ^0.4.23;

contract Product {

    address owner;

    struct product {
        string name;
        uint256 price;
    }

    mapping (address => product) products;

    event Sold(bool sold);
    event Buy(address buyer);

    constructor(string _name) public payable {
        owner = msg.sender;
        products[owner].name = _name;
        products[owner].price = msg.value;
    }

    function buy() public payable {
        owner.transfer(products[owner].price);
        emit Sold(true);
        emit Buy(msg.sender);
    }

}