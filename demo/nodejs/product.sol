pragma solidity ^0.4.11;

contract Product {

    address owner;

    struct product {
        string name;
        uint256 price;
    }

    mapping (address => product) products;

    event Sold(bool sold);
    event Buy(address buyer, address seller);

    function Product(string _name) public payable {
        owner = msg.sender;
        products[owner].name = _name;
        products[owner].price = msg.value;
    }

    function buy() public payable {
        owner.transfer(products[owner].price);
        Sold(true);
        Buy(msg.sender, owner);
    }

}