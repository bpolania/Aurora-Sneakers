import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const SneakerFactory = await ethers.getContractFactory("SneakerFactory");
  const sneakerFactory = await SneakerFactory.deploy(deployer.address);
  const Treasury = await ethers.getContractFactory("Treasury");
  const treasury = await Treasury.deploy(deployer.address);
  console.log("SneakerFactory contract deployed at:", sneakerFactory.address);
  console.log("Treasury contract deployed at:", treasury.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

