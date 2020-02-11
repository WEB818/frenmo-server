CREATE TABLE "favor"(
    "id" INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "creator_id" INTEGER REFERENCES "user"(id) ON DELETE CASCADE,
    "expiration_date" TIMESTAMP,
    "public" BOOLEAN,
    "user_location" TEXT,
    "tags" TEXT,
    "category" INTEGER REFERENCES "category"(id),
    "posted"  TIMESTAMP
);