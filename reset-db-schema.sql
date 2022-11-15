/* Create table of users */
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
  id INTEGER GENERATED ALWAYS AS IDENTITY
  (START WITH 103 INCREMENT BY 13) PRIMARY KEY,
  role VARCHAR(50) NOT NULL,
  username VARCHAR(20) UNIQUE,
  password VARCHAR(64),
  first_name VARCHAR (50) NOT NULL,
  middle_name VARCHAR(50),
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(50) UNIQUE NOT NULL,
  phone	VARCHAR(50),
  street_name	VARCHAR(100),
  district VARCHAR(20),
  city VARCHAR(20),
  zip_code VARCHAR(10)
);

/* Comment of users table */
COMMENT ON TABLE users IS
'Contains information of clients and agents in this table.';

/* Comments of users table's columns */
COMMENT ON COLUMN users.id IS
'An unique ID of an user.';

COMMENT ON COLUMN users.role IS
'Store client or agent in role column to identify that row which one is.';

COMMENT ON COLUMN users.username IS
'Username of user.';

COMMENT ON COLUMN users.password IS
'Password of user.';

COMMENT ON COLUMN users.first_name IS
'First name of user.';

COMMENT ON COLUMN users.middle_name IS
'Middle name of user.';

COMMENT ON COLUMN users.last_name IS
'Last name of user.';

COMMENT ON COLUMN users.email IS
'Email of user.';

COMMENT ON COLUMN users.phone IS
'Phone number of user.';

COMMENT ON COLUMN users.street_name IS
'The part of the user''s address below the street name.';

COMMENT ON COLUMN users.district IS
'The district of user''s address.';

COMMENT ON COLUMN users.city IS
'The city of user''s address.';

COMMENT ON COLUMN users.zip_code IS
'The zip code of user''s address.';


/* Create table of opposites */
DROP TABLE IF EXISTS opposites CASCADE;

CREATE TABLE opposites (
  id INTEGER GENERATED ALWAYS AS IDENTITY
  (START WITH 273 INCREMENT BY 31) PRIMARY KEY,
  role VARCHAR(50),
  organization_name VARCHAR(100),
  first_name VARCHAR(50),
  middle_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(50),
  phone VARCHAR(50),
  street_name VARCHAR(100),
  district VARCHAR(20),
  city VARCHAR(20),
  zip_code VARCHAR(10)
);

/* Comment of opposite_clients table*/
COMMENT ON TABLE opposites IS
'Contains party and agents and store they in `role` column to identify that row which one is.
In administrative event or criminal event, the opposite is not a natural person.
So in this case, we store the name into organization_name column.';

/* Comments of opposite_clients table's columns */
COMMENT ON COLUMN opposites.id IS
'An unique ID of an opposite.';

COMMENT ON COLUMN opposites.organization_name IS
'Name of administration or prosecutor.';

COMMENT ON COLUMN opposites.first_name IS
'First name of opposite.';

COMMENT ON COLUMN opposites.middle_name IS
'Middle name of opposite.';

COMMENT ON COLUMN opposites.last_name IS
'Last name of opposite.';

COMMENT ON COLUMN opposites.email IS
'Email of opposite.';

COMMENT ON COLUMN opposites.phone IS
'Phone number of opposite.';

COMMENT ON COLUMN opposites.street_name IS
'The part of the opposite''s address below the street name.';

COMMENT ON COLUMN opposites.district IS
'The district of opposite''s address.';

COMMENT ON COLUMN opposites.city IS
'The city of opposite''s address.';

COMMENT ON COLUMN opposites.zip_code IS
'The zip code of opposite''s address.';

/* Create table of courts */
DROP TABLE IF EXISTS courts CASCADE;

CREATE TABLE courts (
  id INTEGER GENERATED ALWAYS AS IDENTITY
  (START WITH 470 INCREMENT BY 31) PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  phone	VARCHAR(50) NOT NULL,
  street_name VARCHAR(100),
  district VARCHAR(20),
  city VARCHAR(20),
  zip_code VARCHAR(10)
);

/* Comment of courts table */
COMMENT ON TABLE courts IS
'The information of courts, include prosecutors office';

/* Comments of courts table's columns */
COMMENT ON COLUMN courts.id IS
'An unique ID of a court.';

COMMENT ON COLUMN courts.name IS
'Name of court.';

COMMENT ON COLUMN courts.phone IS
'Phone number of court.';

COMMENT ON COLUMN courts.street_name IS
'The part of the court''s address below the street name.';

COMMENT ON COLUMN courts.district IS
'The district of court''s address.';

COMMENT ON COLUMN courts.city IS
'The city of court''s address.';

COMMENT ON COLUMN courts.zip_code IS
'The zip code of court''s address.';


/* Create table of section_in_charges */
DROP TABLE IF EXISTS section_in_charges CASCADE;

CREATE TABLE section_in_charges (
  id INTEGER GENERATED ALWAYS AS IDENTITY
  (START WITH 653 INCREMENT BY 21) PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  clerk_first_name VARCHAR(50),
  clerk_middle_name VARCHAR(50),
  clerk_last_name VARCHAR(50),
  extension_number VARCHAR(50),
  court_id INTEGER REFERENCES courts(id)
);

/* Comment of section_in_charges table */
COMMENT ON TABLE section_in_charges IS
'In Taiwan legal system, each case will be distributed to specific section in charge,
it is important because when attorney want to contact court,
he must go through section in charge.';

/* Comments of section_in_charges table's columns */
COMMENT ON COLUMN section_in_charges.id IS
'An unique ID of section in charge.';

COMMENT ON COLUMN section_in_charges.name IS
'Name of section in charge.';

COMMENT ON COLUMN section_in_charges.clerk_first_name IS
'First name of contact person.';

COMMENT ON COLUMN section_in_charges.clerk_middle_name IS
'Middle name of contact person.';

COMMENT ON COLUMN section_in_charges.clerk_last_name IS
'Last name of contact person.';

COMMENT ON COLUMN section_in_charges.extension_number IS
'Phone extension number of section in charge.';

COMMENT ON COLUMN section_in_charges.court_id IS
'Associated court ID with the section in charge.';


/* Create table of events */
DROP TABLE IF EXISTS events CASCADE;

CREATE TABLE events (
  id INTEGER GENERATED ALWAYS AS IDENTITY
  (START WITH 1013 INCREMENT BY 47) PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL
);

/* Comment of events table */
COMMENT ON TABLE events IS
'An event is a collection of many cases,
an event may walk through many instance levels of court
and in each instance level of court will have different case number.';

/* Comments of events table's columns */
COMMENT ON COLUMN events.id IS
'An unique ID of an event.';

COMMENT ON COLUMN events.name IS
'The subject of event between client and opposite client.';

/* Create table of cases */
DROP TABLE IF EXISTS cases CASCADE;

CREATE TABLE cases (
  id INTEGER GENERATED ALWAYS AS IDENTITY
  (START WITH 973 INCREMENT BY 29) PRIMARY KEY,
  case_closed BOOLEAN NOT NULL,
  category VARCHAR(20) NOT NULL,
  year smallint,
  type VARCHAR(50),
  number VARCHAR(20),
  cause_of_action VARCHAR(100),
  event_id INTEGER REFERENCES events(id) NOT NULL,
  section_in_charge_id INTEGER REFERENCES section_in_charges(id),
  court_id INTEGER REFERENCES courts(id)
);

/* Comment of cases table */
COMMENT ON TABLE cases IS
'Creating a table of cases help us to associate with other tables.';

/* Comments of cases table's columns */
COMMENT ON COLUMN cases.id IS
'An unique ID of a case.';

COMMENT ON COLUMN cases.case_closed IS
'Describe the case has been closed or not';

COMMENT ON COLUMN cases.category IS
'Category of cases. Means “案件類別” in Chinese like “民事” or “刑事”.';

COMMENT ON COLUMN cases.year IS
'The year of the case, In Taiwan legal system is mainly calculated
from the years of the Republic of China.
For example, 2022 year is equal to 111 year in Taiwan.
Here use the years of the Republic of China';

COMMENT ON COLUMN cases.type IS
'Means “案號字別” in Chinese. For example, like “訴”, “上”, “重訴”, “勞訴”.';

COMMENT ON COLUMN cases.number IS
'Number of cases';

COMMENT ON COLUMN cases.cause_of_action IS
'Which means “案由” in Chinese like “拆屋還地”.';

COMMENT ON COLUMN cases.event_id IS
'Associated with event ID,
mark the same case in whole lawsuit procedure to one event.';

COMMENT ON COLUMN cases.section_in_charge_id IS
'Associated with section_in_charge ID,
indicate which section in charge is handling this case.';

COMMENT ON COLUMN cases.court_id IS
'Associated with court ID, indicate which court is handling this case.';

/* Create table of cases_users */
DROP TABLE IF EXISTS cases_users CASCADE;

CREATE TABLE cases_users (
  id INTEGER GENERATED ALWAYS AS IDENTITY
  (START WITH 1 INCREMENT BY 34) PRIMARY KEY,
  case_id INTEGER REFERENCES cases(id),
  user_id INTEGER REFERENCES users(id) NOT NULL
);

/* Comment of cases_users table */
COMMENT ON TABLE cases_users IS
'Join table of cases and users.';

/* Comments of cases_users table's columns */
COMMENT ON COLUMN cases_users.id IS
'An unique ID of cases_users.';

COMMENT ON COLUMN cases_users.case_id IS
'References the id column in cases.';

COMMENT ON COLUMN cases_users.user_id IS
'References the id column in users.';

/* Create table of cases_opposites */
DROP TABLE IF EXISTS cases_opposites CASCADE;

CREATE TABLE cases_opposites (
  id INTEGER GENERATED ALWAYS AS IDENTITY
  (START WITH 3 INCREMENT BY 27) PRIMARY KEY,
  case_id INTEGER REFERENCES cases(id) NOT NULL,
  opposite_id INTEGER REFERENCES opposites(id) NOT NULL
);

/* Comment of cases_opposites table */
COMMENT ON TABLE cases_opposites IS
'Join table of cases and opposites.';

/* Comments of cases_opposites table's columns */
COMMENT ON COLUMN cases_opposites.id IS
'An unique ID of cases_opposites.';

COMMENT ON COLUMN cases_opposites.case_id IS
'References the id column in cases.';

COMMENT ON COLUMN cases_opposites.opposite_id IS
'References the id column in opposites.';

/* Create table of paper_files */
DROP TABLE IF EXISTS paper_files CASCADE;

CREATE TABLE paper_files (
  id INTEGER GENERATED ALWAYS AS IDENTITY
  (START WITH 3132 INCREMENT BY 47) PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  file bytea NOT NULL
);

/* Comment of paper_files table */
COMMENT ON TABLE paper_files IS
'Store paper files in this table.';

/* Comments of paper_files table's columns */
COMMENT ON COLUMN paper_files.id IS
'An unique ID of a paper file.';

COMMENT ON COLUMN paper_files.name IS
'File name of paper.';

COMMENT ON COLUMN paper_files.file IS
'Paper file, store in bytea data type.';


/* Create table of papers */
DROP TABLE IF EXISTS papers CASCADE;

CREATE TABLE papers (
  id INTEGER GENERATED ALWAYS AS IDENTITY
  (START WITH 4730 INCREMENT BY 47) PRIMARY KEY,
  category VARCHAR (50) NOT NULL,
  title VARCHAR (100) NOT NULL,
  subject VARCHAR (400) NOT NULL,
  sent_date DATE,
  arrival_date DATE,
  received_date DATE,
  deadline_date DATE,
  court_date TIMESTAMP,
  paper_type VARCHAR (50) NOT NULL,
  case_id INTEGER REFERENCES cases(id) NOT NULL,
  paper_files_id INTEGER REFERENCES paper_files(id)
);

/* Comment of papers table */
COMMENT ON TABLE papers IS
'Store all the papers that law firm deal with, contains paper_sent and paper_received.';

/* Comments of papers table's columns */
COMMENT ON COLUMN papers.id IS
'An unique ID of a paper.';

COMMENT ON COLUMN papers.category IS
'Enter paper_sent or paper_received in this column to identify that row which one is.';

COMMENT ON COLUMN papers.title IS
'The title of paper like “民事答辯狀”, “刑事辯護狀”.';

COMMENT ON COLUMN papers.subject IS
'In order to quick understand the subject of the paper, store this value in this column.';

COMMENT ON COLUMN papers.sent_date IS
'Sent date of papers.';

COMMENT ON COLUMN papers.arrival_date IS
'Paper we send and the arrival date. Mainly means when the court has received.';

COMMENT ON COLUMN papers.received_date IS
'Paper from opposite that when we received.';

COMMENT ON COLUMN papers.deadline_date IS
'If paper we received has something need to do, just store the deadline date in this column.';

COMMENT ON COLUMN papers.court_date IS
'Next court date and time.';

COMMENT ON COLUMN papers.paper_type IS
'Like “起訴狀”, “答辯狀” in Chinese.';

COMMENT ON COLUMN papers.case_id IS
'Associated with case ID, to identify which case the paper is belong to.';

COMMENT ON COLUMN papers.paper_files_id IS
'Associated with paper file ID, to indicate the file of paper.';
