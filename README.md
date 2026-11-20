# Poem Booth Backend (NestJS + Prisma)

NestJS backend scaffold for the TelePoem poem booth, with a **Prisma** schema for PostgreSQL.

> The HTTP layer is still the NestJS starter (`GET /` → `Hello World!`). The data model below is defined and migrated, but no API endpoints use it yet.

## Data Model (`prisma/schema.prisma`)

| Model | Description |
|---|---|
| `Booth` | `location`, `theme`, `status` (`ACTIVE` / `INACTIVE`) |
| `Collection` | Unique `name`; has poems |
| `BoothAndCollection` | Many-to-many link between booths and collections |
| `Poet` | `name`, optional `bio` |
| `Poem` | Poem records |

Migrations are in `prisma/migrations/`.

## Tech Stack

NestJS 11 · TypeScript · Prisma (`@prisma/client`) · PostgreSQL · Jest

## Environment Variables

| Variable | Purpose |
|---|---|
| `DATABASE_URL` | PostgreSQL connection string (read by `prisma.config.ts`) |
| `PORT` | HTTP port (default `3000`) |

```env
DATABASE_URL=your_postgres_connection_string_here
```

## Installation & Setup

```bash
git clone https://github.com/KahafSameer/poem-both-backend.git
cd poem-both-backend
npm install
npx prisma migrate deploy     # apply migrations
npx prisma generate           # generate the Prisma client
npm run start:dev
```

## Scripts

| Command | Description |
|---|---|
| `npm run start:dev` | Run with watch mode |
| `npm run build` / `npm run start:prod` | Build / run the compiled app |
| `npm run lint` / `npm run format` | ESLint / Prettier |
| `npm test` / `test:e2e` / `test:cov` | Tests |
