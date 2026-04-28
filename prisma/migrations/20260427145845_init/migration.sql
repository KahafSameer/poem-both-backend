/*
  Warnings:

  - You are about to drop the `BoothCollection` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "BoothCollection" DROP CONSTRAINT "BoothCollection_boothId_fkey";

-- DropForeignKey
ALTER TABLE "BoothCollection" DROP CONSTRAINT "BoothCollection_collectionId_fkey";

-- AlterTable
ALTER TABLE "Poem" ALTER COLUMN "audio" DROP NOT NULL,
ALTER COLUMN "audio" DROP DEFAULT;

-- DropTable
DROP TABLE "BoothCollection";

-- CreateTable
CREATE TABLE "BoothAndCollection" (
    "boothId" TEXT NOT NULL,
    "collectionId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BoothAndCollection_pkey" PRIMARY KEY ("boothId","collectionId")
);

-- CreateIndex
CREATE INDEX "BoothAndCollection_collectionId_idx" ON "BoothAndCollection"("collectionId");

-- AddForeignKey
ALTER TABLE "BoothAndCollection" ADD CONSTRAINT "BoothAndCollection_boothId_fkey" FOREIGN KEY ("boothId") REFERENCES "Booth"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BoothAndCollection" ADD CONSTRAINT "BoothAndCollection_collectionId_fkey" FOREIGN KEY ("collectionId") REFERENCES "Collection"("id") ON DELETE CASCADE ON UPDATE CASCADE;
