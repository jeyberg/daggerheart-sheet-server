import { PrismaClient } from '@prisma/client';
import express from 'express';

const prisma = new PrismaClient();
const app = express();

app.use(express.json());

// GET
app.get("/class/all", async (req, res) => {
    const classes = await prisma.class.findMany({
        include: { features: true, items: true, subclasses: true}
    });

    res.json(classes);
});

app.get("/subclass/:origin_class", async (req, res) => {
    const origin_class = req.params.origin_class;

    const subclasses = prisma.subclass.findMany({
        where: {
            origin_class
        }
    });

    res.json(subclasses);
});

app.get("/item/starting-items", async (req, res) => {
    const items = await prisma.item.findMany({
        where: {
            OR: [{ name: 'Minor Health Potion' }, { name: 'Minor Stamina Potion' }]
        },
        include: { feature: true }
    });

    res.json(items);
});

app.get("/weapon/all", async (req, res) => {
    const weapon = await prisma.weapon.findMany({
        include: { feature: true }
    });

    res.json(weapon);
});

app.get("/armor/all", async (req, res) => {
    const armor = await prisma.armor.findMany({
        include: { feature: true }
    });

    res.json(armor);
});


// Server start
const server = app.listen(3000, () => console.log('server ready'));