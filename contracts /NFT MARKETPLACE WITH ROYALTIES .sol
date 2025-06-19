// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Simple NFT Marketplace Contract
contract Project {
    
    // Owner of the marketplace
    address public owner;
    
    // Counter for marketplace items
    uint256 public itemCount = 0;
    
    // Structure to represent an NFT listing
    struct MarketItem {
        uint256 id;
        address seller;
        address buyer;
        uint256 price;
        string name;
        bool sold;
    }
    
    // Mapping to store all market items
    mapping(uint256 => MarketItem) public marketItems;
    
    // Events
    event ItemListed(uint256 id, address seller, uint256 price, string name);
    event ItemSold(uint256 id, address buyer, uint256 price);
    
    // Constructor - runs when contract is deployed
    constructor() {
        owner = msg.sender;
    }
    
    // Modifier to check if caller is owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    /**
     * Core Function 1: List an NFT for sale
     * @param _price Price of the NFT in wei
     * @param _name Name/description of the NFT
     */
    function listItem(uint256 _price, string memory _name) public {
        require(_price > 0, "Price must be greater than zero");
        require(bytes(_name).length > 0, "Name cannot be empty");
        
        itemCount++;
        
        marketItems[itemCount] = MarketItem(
            itemCount,
            msg.sender,      // seller
            address(0),      // no buyer yet
            _price,
            _name,
            false           // not sold yet
        );
        
        emit ItemListed(itemCount, msg.sender, _price, _name);
    }
    
    /**
     * Core Function 2: Buy an NFT
     * @param _itemId ID of the item to buy
     */
    function buyItem(uint256 _itemId) public payable {
        require(_itemId > 0 && _itemId <= itemCount, "Item does not exist");
        
        MarketItem storage item = marketItems[_itemId];
        
        require(!item.sold, "Item already sold");
        require(msg.value >= item.price, "Not enough payment");
        require(msg.sender != item.seller, "Cannot buy your own item");
        
        // Transfer payment to seller
        payable(item.seller).transfer(item.price);
        
        // If buyer paid more than price, return the excess
        if (msg.value > item.price) {
            payable(msg.sender).transfer(msg.value - item.price);
        }
        
        // Update item details
        item.buyer = msg.sender;
        item.sold = true;
        
        emit ItemSold(_itemId, msg.sender, item.price);
    }
    
   
    function getAvailableItems() public view returns (
        uint256[] memory ids,
        string[] memory names,
        uint256[] memory prices,
        address[] memory sellers
    ) {
        // Count unsold items
        uint256 unsoldCount = 0;
        for (uint256 i = 1; i <= itemCount; i++) {
            if (!marketItems[i].sold) {
                unsoldCount++;
            }
        }
        
        // Create arrays to return
        ids = new uint256[](unsoldCount);
        names = new string[](unsoldCount);
        prices = new uint256[](unsoldCount);
        sellers = new address[](unsoldCount);
        
        // Fill arrays with unsold items
        uint256 index = 0;
        for (uint256 i = 1; i <= itemCount; i++) {
            if (!marketItems[i].sold) {
                ids[index] = marketItems[i].id;
                names[index] = marketItems[i].name;
                prices[index] = marketItems[i].price;
                sellers[index] = marketItems[i].seller;
                index++;
            }
        }
    }
    
    // Additional helper functions
    
    /**
     * Get details of a specific item
     */
    function getItem(uint256 _itemId) public view returns (
        uint256 id,
        address seller,
        address buyer,
        uint256 price,
        string memory name,
        bool sold
    ) {
        require(_itemId > 0 && _itemId <= itemCount, "Item does not exist");
        
        MarketItem memory item = marketItems[_itemId];
        return (item.id, item.seller, item.buyer, item.price, item.name, item.sold);
    }
    
    /**
     * Get my listed items
     */
    function getMyListedItems() public view returns (uint256[] memory) {
        uint256 myItemCount = 0;
        
        // Count my items
        for (uint256 i = 1; i <= itemCount; i++) {
            if (marketItems[i].seller == msg.sender) {
                myItemCount++;
            }
        }
        
        // Create array and fill it
        uint256[] memory myItems = new uint256[](myItemCount);
        uint256 index = 0;
        
        for (uint256 i = 1; i <= itemCount; i++) {
            if (marketItems[i].seller == msg.sender) {
                myItems[index] = i;
                index++;
            }
        }
        
        return myItems;
    }
    
    /**
     * Get my purchased items
     */
    function getMyPurchasedItems() public view returns (uint256[] memory) {
        uint256 myItemCount = 0;
        
        // Count my purchased items
        for (uint256 i = 1; i <= itemCount; i++) {
            if (marketItems[i].buyer == msg.sender) {
                myItemCount++;
            }
        }
        
        // Create array and fill it
        uint256[] memory myItems = new uint256[](myItemCount);
        uint256 index = 0;
        
        for (uint256 i = 1; i <= itemCount; i++) {
            if (marketItems[i].buyer == msg.sender) {
                myItems[index] = i;
                index++;
            }
        }
        
        return myItems;
    }
    
    // Emergency withdraw function (only owner)
    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
    
    // Get contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

