-- CreateEnum
CREATE TYPE "Status" AS ENUM ('ACTIVE', 'INACTIVE');

-- CreateTable
CREATE TABLE "Booth" (
    "id" SERIAL NOT NULL,
    "location" TEXT NOT NULL,
    "theme" TEXT NOT NULL,
    "status" "Status" NOT NULL,

    CONSTRAINT "Booth_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "booth_id" INTEGER NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Poet" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "bio" TEXT,
    "image" TEXT,

    CONSTRAINT "Poet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Poem" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "poem_no" INTEGER NOT NULL,
    "poet_id" INTEGER NOT NULL,
    "category_id" INTEGER NOT NULL,
    "description" TEXT,
    "text" TEXT NOT NULL,
    "image_url" TEXT,
    "audio_url" TEXT,

    CONSTRAINT "Poem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Category_name_key" ON "Category"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Poem_category_id_poem_no_key" ON "Poem"("category_id", "poem_no");

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_booth_id_fkey" FOREIGN KEY ("booth_id") REFERENCES "Booth"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Poem" ADD CONSTRAINT "Poem_poet_id_fkey" FOREIGN KEY ("poet_id") REFERENCES "Poet"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Poem" ADD CONSTRAINT "Poem_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
