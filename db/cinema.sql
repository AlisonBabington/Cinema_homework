DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE customers;
DROP TABLE films;


CREATE TABLE customers(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  funds INT4 NOT NULL,
  tickets VARCHAR(255)
);

CREATE TABLE films(
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  price INT4 NOT NULL
);

CREATE TABLE screenings(
  id SERIAL8 PRIMARY KEY,
  film_id INT8 REFERENCES films(id)
  ON DELETE CASCADE,
  film_screen INT4 NOT NULL,
  film_time VARCHAR(255) NOT NULL
);

CREATE TABLE tickets(
  id SERIAL8 PRIMARY KEY,
  customer_id INT8 REFERENCES customers(id)
  ON DELETE CASCADE,
  screening_id INT8 REFERENCES screenings(id)
  ON DELETE CASCADE
);
