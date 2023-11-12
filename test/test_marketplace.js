const Marketplace = artifacts.require("Marketplace");

contract("Marketplace", (accounts) => {
  it("should deploy the contract", async () => {
    const marketplaceInstance = await Marketplace.deployed();
    assert(marketplaceInstance.address !== '', "Marketplace contract was not deployed");
  });
});
