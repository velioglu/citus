-- basic insert query
WITH basic_insert AS (
	INSERT INTO users_table VALUES (1), (2), (3) RETURNING *
)
SELECT
	*
FROM
	basic_insert;


WITH basic_update AS (
	UPDATE users_table SET value_3=42 WHERE user_id=0 RETURNING *
)
SELECT
	*
FROM
	basic_update;


WITH basic_update AS (
	UPDATE users_table SET value_3=42 WHERE value_2=1 RETURNING *
)
SELECT
	*
FROM
	basic_update;


WITH basic_delete AS (
	DELETE FROM users_table WHERE user_id=42 RETURNING *
)
SELECT
	*
FROM
	basic_delete;


WITH basic_delete AS (
	DELETE FROM users_table WHERE value_2=42 RETURNING *
)
SELECT
	*
FROM
	basic_delete;