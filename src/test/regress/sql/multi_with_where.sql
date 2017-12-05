-- CTE in WHERE basic
WITH events AS (
  SELECT 
    event_type 
  FROM 
    events_table 
  WHERE user_id < 5 
  GROUP BY 
    1 
  ORDER BY 
    1
  LIMIT 10
)
SELECT
  count(*)
FROM
  events_table
WHERE
  event_type
IN
  (SELECT
    *
  FROM
    events
  );


WITH users AS (
    SELECT
      events_table.user_id
    FROM
      events_table, users_table
    WHERE
      events_table.user_id = users_table.user_id
    GROUP BY 
      1
    ORDER BY
      1
    LIMIT 10
) 
SELECT
  count(*)
FROM
  events_table
WHERE
  user_id IN
    (
      SELECT
        *
      FROM
        users
    );


SET citus.task_executor_type = 'task-tracker';
-- THIS AND THE NEXT QUERY DOES NOT RUN WITH TASK-TRACKER
WITH users AS (
    SELECT
      events_table.user_id
    FROM
      events_table, users_table
    WHERE
      events_table.user_id = users_table.user_id
    GROUP BY 
      1
    ORDER BY
      1
    LIMIT 10
) 
SELECT
  count(*)
FROM
  events_table
WHERE
  user_id IN
    (
      SELECT
        *
      FROM
        users
    );


-- CTE with non-colocated join in WHERE
WITH users AS (
    SELECT
      events_table.user_id
    FROM
      events_table, users_table
    WHERE
      events_table.value_2 = users_table.value_2
    GROUP BY 
      1
    ORDER BY
      1
    LIMIT 10
) 
SELECT
  count(*)
FROM
  events_table
WHERE
  user_id IN
    (
      SELECT
        *
      FROM
        users
    );

SET citus.task_executor_type = 'real-time';
-- CTE in WHERE basic
SELECT
  count(*)
FROM
  events_table
WHERE
  event_type
IN
  (WITH events AS (
    SELECT 
      event_type 
    FROM 
      events_table 
    WHERE user_id < 5 
    GROUP BY 
      1 
    ORDER BY 
      1)
    SELECT * FROM events LIMIT 10
  );

SET citus.task_executor_type = 'task-tracker';
-- CTE with non-colocated join in WHERE
SELECT
  count(*)
FROM
  events_table
WHERE
  user_id IN
    (WITH users AS
      (SELECT
          events_table.user_id
        FROM
          events_table, users_table
        WHERE
          events_table.value_2 = users_table.value_2
        GROUP BY 
          1
        ORDER BY
          1
      )
      SELECT * FROM users LIMIT 10
    );