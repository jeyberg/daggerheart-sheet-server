/*
  Warnings:

  - You are about to drop the column `background_questions` on the `Class` table. All the data in the column will be lost.
  - You are about to drop the column `evasion_score` on the `Class` table. All the data in the column will be lost.
  - Added the required column `evasionScore` to the `Class` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Class" DROP COLUMN "background_questions",
DROP COLUMN "evasion_score",
ADD COLUMN     "backgroundQuestions" TEXT[],
ADD COLUMN     "evasionScore" INTEGER NOT NULL;
