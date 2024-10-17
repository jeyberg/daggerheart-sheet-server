-- CreateEnum
CREATE TYPE "Domain" AS ENUM ('arcana', 'blade', 'bone', 'codex', 'grace', 'midnight', 'sage', 'splendor', 'valor');

-- CreateEnum
CREATE TYPE "Trait" AS ENUM ('agility', 'strength', 'finesse', 'instinct', 'presence', 'knowledge');

-- CreateEnum
CREATE TYPE "Range" AS ENUM ('melee', 'very_close', 'close', 'far', 'very_far');

-- CreateEnum
CREATE TYPE "FeatureType" AS ENUM ('class_base', 'class_hope', 'ancestry', 'community', 'subclass_foundation', 'subclass_specialization', 'subclass_mastery', 'domain_card', 'armor', 'weapon', 'item');

-- CreateTable
CREATE TABLE "Feature" (
    "id" SERIAL NOT NULL,
    "type" "FeatureType" NOT NULL,
    "name" TEXT,
    "description" TEXT NOT NULL,
    "effects" TEXT[],
    "appendix" TEXT,
    "ancestryId" TEXT,
    "classId" TEXT,
    "subclassId" TEXT,

    CONSTRAINT "Feature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Community" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "featureId" INTEGER NOT NULL,

    CONSTRAINT "Community_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ancestry" (
    "name" TEXT NOT NULL,

    CONSTRAINT "Ancestry_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "Item" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "featureId" INTEGER,
    "classId" TEXT,

    CONSTRAINT "Item_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Weapon" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "trait" "Trait" NOT NULL,
    "range" "Range" NOT NULL,
    "damage" TEXT NOT NULL,
    "burden" INTEGER NOT NULL,
    "featureId" INTEGER,
    "is_magical" BOOLEAN NOT NULL,
    "is_secondary" BOOLEAN NOT NULL,
    "tier" INTEGER NOT NULL,

    CONSTRAINT "Weapon_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Armor" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "base_score" INTEGER NOT NULL,
    "featureId" INTEGER,

    CONSTRAINT "Armor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Class" (
    "name" TEXT NOT NULL,
    "domains" "Domain"[],
    "evasion_score" INTEGER NOT NULL,
    "major_threshold" INTEGER NOT NULL,
    "severe_threshold" INTEGER NOT NULL,
    "background_questions" TEXT[],
    "connections" TEXT[],

    CONSTRAINT "Class_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "Subclass" (
    "origin_class" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "spellcast_trait" "Trait",

    CONSTRAINT "Subclass_pkey" PRIMARY KEY ("name")
);

-- CreateIndex
CREATE UNIQUE INDEX "Community_name_key" ON "Community"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Community_featureId_key" ON "Community"("featureId");

-- CreateIndex
CREATE UNIQUE INDEX "Item_featureId_key" ON "Item"("featureId");

-- CreateIndex
CREATE UNIQUE INDEX "Weapon_featureId_key" ON "Weapon"("featureId");

-- CreateIndex
CREATE UNIQUE INDEX "Armor_featureId_key" ON "Armor"("featureId");

-- AddForeignKey
ALTER TABLE "Feature" ADD CONSTRAINT "Feature_ancestryId_fkey" FOREIGN KEY ("ancestryId") REFERENCES "Ancestry"("name") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feature" ADD CONSTRAINT "Feature_classId_fkey" FOREIGN KEY ("classId") REFERENCES "Class"("name") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feature" ADD CONSTRAINT "Feature_subclassId_fkey" FOREIGN KEY ("subclassId") REFERENCES "Subclass"("name") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Community" ADD CONSTRAINT "Community_featureId_fkey" FOREIGN KEY ("featureId") REFERENCES "Feature"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Item" ADD CONSTRAINT "Item_featureId_fkey" FOREIGN KEY ("featureId") REFERENCES "Feature"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Item" ADD CONSTRAINT "Item_classId_fkey" FOREIGN KEY ("classId") REFERENCES "Class"("name") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Weapon" ADD CONSTRAINT "Weapon_featureId_fkey" FOREIGN KEY ("featureId") REFERENCES "Feature"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Armor" ADD CONSTRAINT "Armor_featureId_fkey" FOREIGN KEY ("featureId") REFERENCES "Feature"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Subclass" ADD CONSTRAINT "Subclass_origin_class_fkey" FOREIGN KEY ("origin_class") REFERENCES "Class"("name") ON DELETE RESTRICT ON UPDATE CASCADE;
