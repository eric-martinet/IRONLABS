-- Find the report of the crime scene
SELECT *
FROM crime_scene_report
WHERE date = 20180115 AND city = "SQL City" AND type = "murder";
-- Security footage shows that there were 2 witnesses.
-- The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".

SELECT sql 
FROM sqlite_master
WHERE name = 'person';
-- CREATE TABLE person ( id integer PRIMARY KEY, name text, license_id integer, address_number integer, address_street_name text, ssn integer, FOREIGN KEY (license_id) REFERENCES drivers_license(id) )

-- Find the first witness and retrieve interview
SELECT *
FROM person
WHERE address_street_name LIKE "%Northwestern Dr%"
ORDER BY address_number DESC
LIMIT 1;
--id	name	        license_id	address_number	address_street_name	    ssn
--14887	Morty Schapiro	118009	    4919	        Northwestern Dr	        111564949

SELECT sql 
FROM sqlite_master
WHERE name = 'interview';
-- CREATE TABLE interview ( person_id integer, transcript text, FOREIGN KEY (person_id) REFERENCES person(id) )

SELECT *
FROM interview
WHERE  person_id = 14887;
-- person_id	transcript
-- 14887	    I heard a gunshot and then saw a man run out.
--              He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z".
--              Only gold members have those bags. The man got into a car with a plate that included "H42W".

-- Find the second witness and retrieve interview
SELECT *
FROM person
WHERE name LIKE "%Annabel%" AND address_street_name LIKE "%Franklin Ave%";
-- id       name        license_id  address_number  address_street_name     ssn
-- 16371	Annabel Miller	490173	103	            Franklin Ave	        318771143

SELECT *
FROM interview
WHERE  person_id = 16371;
-- person_id	transcript
-- 16371	    I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

-- Summary data on killer: Member of "Get Fit Now Gym", membership number starting with "48Z" i.e. gold member, was there on Jan 9th, plate number includes "H42W".

SELECT sql 
FROM sqlite_master
WHERE name = 'get_fit_now_member';
-- CREATE TABLE get_fit_now_member ( id text PRIMARY KEY, person_id integer, name text, membership_start_date integer, membership_status text, FOREIGN KEY (person_id) REFERENCES person(id) )

SELECT sql 
FROM sqlite_master
WHERE name = 'get_fit_now_check_in';
-- CREATE TABLE get_fit_now_check_in ( membership_id text, check_in_date integer, check_in_time integer, check_out_time integer, FOREIGN KEY (membership_id) REFERENCES get_fit_now_member(id) )

SELECT sql 
FROM sqlite_master
WHERE name = 'drivers_license';
--  CREATE TABLE drivers_license ( id integer PRIMARY KEY, age integer, height integer, eye_color text, hair_color text, gender text, plate_number text, car_make text, car_model text )

SELECT person.id, person.name
FROM get_fit_now_member
JOIN get_fit_now_check_in
ON get_fit_now_member.id = get_fit_now_check_in.membership_id
JOIN person
ON get_fit_now_member.person_id = person.id
JOIN drivers_license
ON person.license_id = drivers_license.id
WHERE get_fit_now_member.membership_status = "gold"
AND get_fit_now_check_in.check_in_date = 20180109
AND drivers_license.plate_number LIKE "%H42W%";
-- id	    name
-- 67318	Jeremy Bowers

INSERT INTO solution VALUES (1, 'Jeremy Bowers');
SELECT value FROM solution;
-- Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge,
-- try querying the interview transcript of the murderer to find the real villain behind this crime.
-- If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries.
-- Use this same INSERT statement with your new suspect to check your answer.

SELECT *
FROM interview
WHERE  person_id = 67318;
-- person_id	transcript
-- 67318	    I was hired by a woman with a lot of money.
--              I don't know her name but I know she's around 5'5" (65") or 5'7" (67").
--              She has red hair and she drives a Tesla Model S.
--              I know that she attended the SQL Symphony Concert 3 times in December 2017.

SELECT sql 
FROM sqlite_master
WHERE name = 'facebook_event_checkin';
-- CREATE TABLE facebook_event_checkin ( person_id integer, event_id integer, event_name text, date integer, FOREIGN KEY (person_id) REFERENCES person(id) )

SELECT COUNT(person.id), person.name
FROM person
JOIN drivers_license
ON person.license_id = drivers_license.id
JOIN facebook_event_checkin
ON person.id = facebook_event_checkin.person_id
WHERE drivers_license.height BETWEEN 65 AND 67
AND drivers_license.hair_color = "red"
AND drivers_license.gender = "female"
AND drivers_license.car_make = "Tesla"
AND drivers_license.car_model = "Model S"
AND facebook_event_checkin.event_name = "SQL Symphony Concert"
AND facebook_event_checkin.date LIKE "201712%";
--  COUNT(person.id)	name
--  3	                Miranda Priestly

INSERT INTO solution VALUES (1, 'Miranda Priestly');
SELECT value FROM solution;
-- Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!