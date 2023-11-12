// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Marketplace {
    uint256 public itemCount = 0;

    struct Item {
        uint256 id;
        address owner;
        string name;
        string description;
        uint256 price;
        uint256 quantity;
    }

    mapping(uint256 => Item) public items;

    event ItemAdded(uint256 id, string name, uint256 price, uint256 quantity);
    event ItemPurchased(uint256 id, address buyer, uint256 quantity);

    function addItem(string memory _name, string memory _description, uint256 _price, uint256 _quantity) public {
        itemCount++;
        items[itemCount] = Item(itemCount, msg.sender, _name, _description, _price, _quantity);
        emit ItemAdded(itemCount, _name, _price, _quantity);
    }

    function purchaseItem(uint256 _id, uint256 _quantity) public payable {
        Item storage item = items[_id];
        require(_id > 0 && _id <= itemCount, "item does not exist");
        require(msg.value == item.price * _quantity, "Incorrect value");
        require(item.quantity >= _quantity, "Not enough items in stock");

        address payable seller = payable(item.owner); // Adresi `address payable` türüne dönüştürme
        seller.transfer(msg.value); // Para transferi
        item.quantity -= _quantity;

        emit ItemPurchased(_id, msg.sender, _quantity);
    }

    function removeItem(uint256 _id) public {
        require(msg.sender == items[_id].owner, "Only item owner can remove");
        delete items[_id];
    }
}
