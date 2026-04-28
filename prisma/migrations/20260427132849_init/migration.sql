/*
  Warnings:

  - The primary key for the `Booth` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `status` column on the `Booth` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Poem` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `audio_url` on the `Poem` table. All the data in the column will be lost.
  - You are about to drop the column `category_id` on the `Poem` table. All the data in the column will be lost.
  - You are about to drop the column `image_url` on the `Poem` table. All the data in the column will be lost.
  - You are about to drop the column `poem_no` on the `Poem` table. All the data in the column will be lost.
  - You are about to drop the column `poet_id` on the `Poem` table. All the data in the column will be lost.
  - The primary key for the `Poet` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `Category` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[collectionId,poemNo]` on the table `Poem` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `updatedAt` to the `Booth` table without a default value. This is not possible if the table is not empty.
  - Added the required column `collectionId` to the `Poem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `poemNo` to the `Poem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `poetId` to the `Poem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Poem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Poet` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "BoothStatus" AS ENUM ('ACTIVE', 'INACTIVE');

-- DropForeignKey
ALTER TABLE "Category" DROP CONSTRAINT "Category_booth_id_fkey";

-- DropForeignKey
ALTER TABLE "Poem" DROP CONSTRAINT "Poem_category_id_fkey";

-- DropForeignKey
ALTER TABLE "Poem" DROP CONSTRAINT "Poem_poet_id_fkey";

-- DropIndex
DROP INDEX "Poem_category_id_poem_no_key";

-- AlterTable
ALTER TABLE "Booth" DROP CONSTRAINT "Booth_pkey",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
DROP COLUMN "status",
ADD COLUMN     "status" "BoothStatus" NOT NULL DEFAULT 'ACTIVE',
ADD CONSTRAINT "Booth_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Booth_id_seq";

-- AlterTable
ALTER TABLE "Poem" DROP CONSTRAINT "Poem_pkey",
DROP COLUMN "audio_url",
DROP COLUMN "category_id",
DROP COLUMN "image_url",
DROP COLUMN "poem_no",
DROP COLUMN "poet_id",
ADD COLUMN     "audio" TEXT NOT NULL DEFAULT '',
ADD COLUMN     "collectionId" TEXT NOT NULL,
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "image" TEXT,
ADD COLUMN     "poemNo" INTEGER NOT NULL,
ADD COLUMN     "poetId" TEXT NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Poem_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Poem_id_seq";

-- AlterTable
ALTER TABLE "Poet" DROP CONSTRAINT "Poet_pkey",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Poet_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Poet_id_seq";

-- DropTable
DROP TABLE "Category";

-- DropEnum
DROP TYPE "Status";

-- CreateTable
CREATE TABLE "Collection" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Collection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BoothCollection" (
    "boothId" TEXT NOT NULL,
    "collectionId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BoothCollection_pkey" PRIMARY KEY ("boothId","collectionId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Collection_name_key" ON "Collection"("name");

-- CreateIndex
CREATE INDEX "BoothCollection_collectionId_idx" ON "BoothCollection"("collectionId");

-- CreateIndex
CREATE INDEX "Poem_poetId_idx" ON "Poem"("poetId");

-- CreateIndex
CREATE INDEX "Poem_collectionId_idx" ON "Poem"("collectionId");

-- CreateIndex
CREATE UNIQUE INDEX "Poem_collectionId_poemNo_key" ON "Poem"("collectionId", "poemNo");

-- AddForeignKey
ALTER TABLE "BoothCollection" ADD CONSTRAINT "BoothCollection_boothId_fkey" FOREIGN KEY ("boothId") REFERENCES "Booth"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BoothCollection" ADD CONSTRAINT "BoothCollection_collectionId_fkey" FOREIGN KEY ("collectionId") REFERENCES "Collection"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Poem" ADD CONSTRAINT "Poem_poetId_fkey" FOREIGN KEY ("poetId") REFERENCES "Poet"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Poem" ADD CONSTRAINT "Poem_collectionId_fkey" FOREIGN KEY ("collectionId") REFERENCES "Collection"("id") ON DELETE CASCADE ON UPDATE CASCADE;
