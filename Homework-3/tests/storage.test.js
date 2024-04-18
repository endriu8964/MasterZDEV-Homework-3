const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MyERC1155", function() {
    let token;
    let owner;
    let addr1;
    let addr2;

    beforeEach(async function() {
        [owner, addr1, addr2] = await ethers.getSigners();

        const MyERC1155 = await ethers.getContractFactory("MyERC1155");
        token = await MyERC1155.deploy();
        await token.deployed();
    });

    it("should mint a fungible token", async function() {
        await token.mintFungible(owner.address, 1, 100);
        const balance = await token.balanceOf(owner.address, 1);
        expect(balance).to.equal(100);
    });

    it("should mint a non-fungible token", async function() {
        const tokenId = await token.mintNonFungible(owner.address, "ipfs://QmSomeHash/metadata.json");
        const balance = await token.balanceOf(owner.address, tokenId);
        expect(balance).to.equal(1);
    });
});
