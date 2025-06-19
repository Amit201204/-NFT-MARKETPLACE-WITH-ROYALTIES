Here's a clean and professional `README.md` for your Solidity NFT marketplace contract:

---

# 🖼️ Simple NFT Marketplace Smart Contract

This Solidity smart contract implements a basic NFT marketplace where users can list and buy digital assets using ETH. It is designed to be simple, gas-efficient, and easily extendable for further features like token-based payments or metadata integration.

---

## 📄 Features

* ✅ List NFTs for sale with a price and name
* 💰 Buy listed NFTs by sending the correct amount of ETH
* 📋 View all available items
* 🔍 View individual item details
* 👤 Get all NFTs listed or purchased by the caller
* 🛑 Emergency withdrawal for the contract owner
* 💵 Track the contract's ETH balance

---

## 📦 Contract Details

**Contract Name**: `Project`
**Compiler Version**: `^0.8.0`
**License**: MIT

---

## 🔧 Functions

### 1. **Constructor**

```solidity
constructor()
```

Sets the deployer as the contract owner.

---

### 2. **listItem**

```solidity
function listItem(uint256 _price, string memory _name) public
```

Lists an item for sale.

* `_price`: Price of the NFT in wei
* `_name`: Name or description of the NFT

Emits: `ItemListed`

---

### 3. **buyItem**

```solidity
function buyItem(uint256 _itemId) public payable
```

Allows a user to purchase an unsold NFT by paying its listed price.

* `_itemId`: ID of the item to buy

Emits: `ItemSold`

---

### 4. **getAvailableItems**

```solidity
function getAvailableItems() public view returns (uint256[], string[], uint256[], address[])
```

Returns arrays of IDs, names, prices, and seller addresses for all unsold items.

---

### 5. **getItem**

```solidity
function getItem(uint256 _itemId) public view returns (uint256, address, address, uint256, string memory, bool)
```

Returns detailed info about a specific item.

---

### 6. **getMyListedItems**

```solidity
function getMyListedItems() public view returns (uint256[] memory)
```

Returns IDs of all NFTs listed by the caller.

---

### 7. **getMyPurchasedItems**

```solidity
function getMyPurchasedItems() public view returns (uint256[] memory)
```

Returns IDs of all NFTs purchased by the caller.

---

### 8. **withdraw**

```solidity
function withdraw() public onlyOwner
```

Allows the contract owner to withdraw the contract's balance. Use in emergencies.

---

### 9. **getBalance**

```solidity
function getBalance() public view returns (uint256)
```

Returns the current ETH balance of the contract.

---

## 🛡️ Access Control

* Only the **owner** (contract deployer) can call `withdraw`.

---

## 🚀 Deployment

1. Compile the contract using Solidity `^0.8.0`
2. Deploy using any Ethereum development environment like:

   * [Remix](https://remix.ethereum.org/)
 
3. Interact via web3 frontends or directly through a wallet like MetaMask.

---

## ⚠️ Notes

* This contract does **not** handle actual NFT tokens (ERC-721 or ERC-1155). It is a *marketplace layer* where you can list items with metadata (name/price). Token integration can be added later.
* All listings are paid in ETH.

---

## 📜 License

MIT License
Feel free to use, modify, and build upon this contract.

---
 Contract Address :0x19FF57Dba4109bA661976Ba5c8419504E2F3149a

