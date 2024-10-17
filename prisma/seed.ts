import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();
const data = require("./seed-data.json");

async function main() {
  for (let community of data.communities) {
    const result = await prisma.community.create({ data: community });
    console.log(result);
  }

  for (let ancestry of data.ancestries) {
    const result = await prisma.ancestry.create({ data: ancestry });
    console.log(result);
  }

  for (let playerClass of data.class) {
    const result = await prisma.class.create({ data: playerClass });
    console.log(result);
  }

  for (let item of data.item) {
    const result = await prisma.item.create({ data: item });
    console.log(result);
  }

  for (let armor of data.armor) {
    const result = await prisma.armor.create({ data: armor });
    console.log(result);
  }

  for (let weapon of data.weapon) {
    const result = await prisma.weapon.create({ data: weapon });
    console.log(result);
  }
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
