alter table Address 
  add column if not exists CITY tinytext,
  add column if not exists STREET tinytext;

describe Address;
SELECT street, city FROM Address;
  
alter table User
  add column if not exists id integer,
  add column if not exists FIRST tinytext,
  add column if not exists LAST tinytext;

describe User;
