DROP TABLE IF EXISTS option_value;

DROP SEQUENCE IF EXISTS option_value_seq;
CREATE SEQUENCE option_value_seq;
SELECT setval('option_value_seq', 18, true); -- last inserted id by sample data

CREATE TABLE "option_value" (
  "option_value_id" int check ("option_value_id" > 0) NOT NULL DEFAULT NEXTVAL ('option_value_seq'),
  "option_id" INT NOT NULL,
  "image" TEXT NOT NULL,
  "sort_order" INT NOT NULL DEFAULT 0,
 PRIMARY KEY ("option_value_id")
);
