CREATE TABLE users (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  role VARCHAR(50) NOT NULL,
  username VARCHAR(20),
  password VARCHAR(64),
  first_name VARCHAR (50) NOT NULL,
  middle_name VARCHAR(50),
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(50),
  phone	VARCHAR(50),
  street_name	VARCHAR(100),
  district VARCHAR(20),
  city VARCHAR(20),
  zip_code VARCHAR(10)
);

COMMENT ON TABLE users IS 
'Contains clients and agents. Store client or agent in role column 
to identify that row which one is.';

CREATE TABLE opposite_clients (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100),
  first_name VARCHAR (50),
  middle_name VARCHAR(50),
  last_name VARCHAR(50),
  street_name VARCHAR(100),
  district VARCHAR(20),
  city VARCHAR(20),
  zip_code VARCHAR(10)
);

COMMENT ON TABLE opposite_clients IS 
'In administrative event or criminal event, the opposite client is 
administration or prosecutor. In civil cases, the opposite client is natrual person.';



CREATE TABLE opposite_agents (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  first_name VARCHAR (50) NOT NULL,
  middle_name VARCHAR(50),
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(50),
  phone	VARCHAR(50),
  street_name VARCHAR(100),
  district VARCHAR(20),
  city VARCHAR(20),
  zip_code VARCHAR(10)
);

COMMENT ON TABLE opposite_agents IS 
'The agents of opposites.';


CREATE TABLE courts (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  phone	VARCHAR(50) NOT NULL,
  street_name VARCHAR(100),
  district VARCHAR(20),
  city VARCHAR(20),
  zip_code VARCHAR(10)
);

COMMENT ON TABLE courts IS 
'The information of courts, include prosecutors office';

CREATE TABLE section_in_charges (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(20),
  clerk_first_name VARCHAR(50),
  clerk_last_name VARCHAR(50),
  extension_number VARCHAR(50),
  court_id INTEGER REFERENCES courts(id)
);

COMMENT ON TABLE section_in_charges IS 
'In Taiwan legal system, each case will be distributed to specific section in charge, 
it is important because when attorney want to contact court, 
he must go through section in charge.';

CREATE TABLE events (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  client_id INTEGER REFERENCES users(id) NOT NULL,
  opposite_client_id INTEGER REFERENCES opposite_clients(id) NOT NULL
);

COMMENT ON TABLE events IS 
'An event is a collection of many cases, an event may walk through many instance
levels of court and in each instance level of court will have different case number.';


CREATE TABLE cases (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  category VARCHAR(20) NOT NULL,
  year VARCHAR(20),
  type VARCHAR(50),
  number VARCHAR(20),
  cause_of_action VARCHAR(100),
  event_id INTEGER REFERENCES events(id) NOT NULL,
  section_in_charge_id INTEGER REFERENCES section_in_charges(id),
  court_id INTEGER REFERENCES courts(id),
  client_id INTEGER REFERENCES users(id) NOT NULL,
  agent_id INTEGER REFERENCES users(id) NOT NULL,
  opposite_client_id INTEGER REFERENCES opposite_clients(id) NOT NULL,
  opposite_agent_id INTEGER REFERENCES opposite_agents(id)
);

COMMENT ON TABLE cases IS 
'Creating a table of cases help us to associate with other tables.';


CREATE TABLE papers (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  category VARCHAR (50) NOT NULL,
  title VARCHAR (100) NOT NULL,
  subject VARCHAR (400) NOT NULL,
  sent_date DATE,
  arrival_date DATE,
  received_date DATE,
  deadline_date DATE,
  court_date TIMESTAMP,
  paper_type VARCHAR (50) NOT NULL,
  case_id INTEGER REFERENCES cases(id) NOT NULL
);

COMMENT ON TABLE papers IS 
'Contains paper_sent and paper_received. Enter paper_sent or paper_received in 
category column to identify that row which one is.';
