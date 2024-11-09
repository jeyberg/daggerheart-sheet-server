-- CreateEnum
CREATE TYPE "DomainCardType" AS ENUM ('ability', 'grimoire', 'spell');

-- AlterTable
ALTER TABLE "Feature" ADD COLUMN     "domainCardname" TEXT;

-- CreateTable
CREATE TABLE "DomainCard" (
    "level" INTEGER NOT NULL,
    "domain" "Domain" NOT NULL,
    "recallCost" INTEGER NOT NULL,
    "type" "DomainCardType" NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "DomainCard_pkey" PRIMARY KEY ("name")
);

-- AddForeignKey
ALTER TABLE "Feature" ADD CONSTRAINT "Feature_domainCardname_fkey" FOREIGN KEY ("domainCardname") REFERENCES "DomainCard"("name") ON DELETE SET NULL ON UPDATE CASCADE;
