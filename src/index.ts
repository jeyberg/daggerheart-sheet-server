import { PrismaClient } from "@prisma/client";
import express from "express";

const prisma = new PrismaClient();
const app = express();

app.use(express.json());

// GET
app.get("/api/class/all", async (req, res) => {
  const classes = await prisma.class.findMany({
    include: {
      features: true,
      items: true,
      subclasses: { include: { features: true } },
    },
  });

  res.json(classes);
});

app.get("/api/subclass/:originClass", async (req, res) => {
  const originClass = req.params.originClass;

  const subclasses = await prisma.subclass.findMany({
    where: {
      originClass,
    },
    include: { features: true },
  });

  res.json(subclasses);
});

app.get("/api/item/starting-items", async (req, res) => {
  const items = await prisma.item.findMany({
    where: {
      isStartingItem: true,
    },
    include: { feature: true },
  });

  res.json(items);
});

app.get("/api/weapon/all", async (req, res) => {
  const tier = req.query.tier ? +req.query.tier : 0;
  const weapon = await prisma.weapon.findMany({
    where: {
      tier,
    },
    include: { feature: true },
  });

  res.json(weapon);
});

app.get("/api/armor/all", async (req, res) => {
  const tier = req.query.tier ? +req.query.tier : 0;
  const armor = await prisma.armor.findMany({
    where: {
      tier,
    },
    include: { feature: true },
  });

  res.json(armor);
});

app.get("/api/ancestry/all", async (req, res) => {
  const ancestries = await prisma.ancestry.findMany({
    include: { features: true },
  });

  res.json(ancestries);
});

app.get("/api/community/all", async (req, res) => {
  const communities = await prisma.community.findMany({
    include: { feature: true },
  });

  res.json(communities);
});

// Server start
const server = app.listen(3000, () => console.log("server ready"));
