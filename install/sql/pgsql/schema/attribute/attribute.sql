DROP TABLE IF EXISTS attribute;

DROP SEQUENCE IF EXISTS attribute_seq;
CREATE SEQUENCE attribute_seq;
SELECT setval('attribute_seq', 12, true); -- last inserted id by sample data

CREATE TABLE "attribute" (
  "attribute_id" int check ("attribute_id" > 0) NOT NULL DEFAULT NEXTVAL ('attribute_seq'),
  "attribute_group_id" int check ("attribute_group_id" > 0) NOT NULL DEFAULT 0,
  "sort_order" INT NOT NULL DEFAULT 0,
 PRIMARY KEY ("attribute_id")
);
