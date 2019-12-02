CREATE DATABASE  IF NOT EXISTS `hate_term_project`;

-- Create a hate_term table
CREATE table hatebase(
id int(255) not null,
vocabulary_id varchar(255) not null ,
term varchar(500) not null,
hateful_meaning varchar(2000) null,
nonhateful_meaning varchar(550) null,
is_unambiguous varchar(255),
is_unambiguous_in varchar(255) null,
average_offensiveness varchar(50) null,
`language` varchar(255) not null,
plural_of varchar(255) null,
variant_of varchar(255) null,
transliteration_of varchar(255) null,
is_about_nationality varchar(50) not null,
is_about_ethnicity varchar(50) not null,
is_about_religion varchar(50) not null,
is_about_gender varchar(50) not null,
is_about_sexual_orientation varchar(50) not null,
is_about_disability varchar(50) not null,
is_about_class varchar(50) not null,
number_of_sightings varchar(50) not null,
number_of_sightings_this_year varchar(50) not null,
number_of_sightings_this_month varchar(50) not null,
created_on varchar(50) not null,
updated_on varchar(50) not null)
COLLATE 'utf8mb4_0900_ai_ci';


-- Create a Twitter data table
CREATE table tw_data(
id varchar(500) not null,
tw_id varchar(500) not null,
`text` varchar(10000) not null,
tw_created_at varchar(255) not null,
retweet_count varchar(255) null,
favorite_count varchar(255) null,
`source` varchar(500) null,
user_id varchar(255) null,
screen_name varchar(255) null,
`name` varchar(255) null,
user_created_at varchar(100) null,
user_description varchar(700) null,
user_location varchar(300) null);
/*COLLATE 'utf8mb4_0900_ai_ci'*/


-- Create a FBI hatecrime data table
CREATE table fbi_hatecrime(
Table_id int(255) not null,
id int(255) not null,
incident_id varchar(255) not null,
data_year varchar(50) not null,
ORI varchar(255) not null,
pub_agency_name varchar(150) not null, 
pub_agency_unit varchar(100) null,
agency_type_name varchar(100) not null,
state_abbr varchar(50) not null,
state_name varchar(250) not null,
division_name varchar(100) not null,
region_name varchar(70) not null,
POPULATION_GROUP_CODE  varchar(50) not null,
POPULATION_GROUP_DESC varchar(300) not null,
INCIDENT_DATE varchar(100) not null,
ADULT_VICTIM_COUNT varchar(50) null,
JUVENILE_VICTIM_COUNT varchar(50) null,
TOTAL_OFFENDER_COUNT varchar(50) not null,
ADULT_OFFENDER_COUNT varchar(50) null,
JUVENILE_OFFENDER_COUNT varchar(50) null,
OFFENDER_RACE varchar(50) null,
OFFENDER_ETHNICITY varchar(50) null,
VICTIM_COUNT varchar(50) not null,
OFFENSE_NAME varchar(300) not null,
TOTAL_INDIVIDUAL_VICTIMS varchar(100) null,
LOCATION_NAME varchar(350) not null,
BIAS_DESC varchar(200) not null,
VICTIM_TYPES varchar(300) not null,
MULTIPLE_OFFENSE varchar(50) not null,
MULTIPLE_BIAS varchar(50) not null,
Is_Race_Ethnicity_Ancestry varchar(50) not null,
Is_Religion varchar(50) not null,
Is_Sexual_Orientation varchar(50) not null,
Is_Disability varchar(50) not null,
Is_Gender varchar(50) not null,
Is_Gender_Identity varchar(50) not null)
COLLATE 'utf8mb4_0900_ai_ci';


-- Import data into hatabase table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/terms_2019-11-20.csv' 
INTO TABLE hatebase 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- Import data into fbi_hatecrime table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hate_crime_auto_bool.csv' 
INTO TABLE fbi_hatecrime 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- Import data into tw_data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tw_data_set(11_22_19)_copy.csv' 
INTO TABLE tw_data
FIELDS ENCLOSED BY '"' TERMINATED BY ','  escaped by ''
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

