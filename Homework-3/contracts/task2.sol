// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyERC1155 is ERC1155 {
    using Counters for Counters.Counter;
    Counters.Counter private _nonFungibleTokenIds;

    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC1155("https://ipfs.io/ipfs/{id}.json") {}

    function mintFungible(address account, uint256 id, uint256 amount) external {
        _mint(account, id, amount, "");
    }

    function mintNonFungible(address account, string memory tokenURI) external returns (uint256) {
        _nonFungibleTokenIds.increment();
        uint256 newId = _nonFungibleTokenIds.current();
        
        _mint(account, newId, 1, "");
        _setTokenURI(newId, tokenURI);

        return newId;
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal {
        _tokenURIs[tokenId] = _tokenURI;
    }

    function uri(uint256 tokenId) public view override returns (string memory) {
        return string(abi.encodePacked(super.uri(tokenId), _tokenURIs[tokenId]));
    }
}
