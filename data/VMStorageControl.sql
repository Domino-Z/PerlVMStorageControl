CREATE TABLE "virtual_machine" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(255) NOT NULL,
  "os" varchar(255) NOT NULL,
  "storage_id" integer NOT NULL,
  "checksum" varchar(32),
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "storage" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(255) NOT NULL,
  "capacity" integer NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now())
);

ALTER TABLE "virtual_machine" ADD COLUMN "description" TEXT;

ALTER TABLE "virtual_machine" ADD FOREIGN KEY ("storage_id") REFERENCES "storage" ("id");