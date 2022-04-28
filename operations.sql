uuse roydon5;

-- check if user login data is correct
drop procedure IF EXISTS check_user;
DELIMITER $$
CREATE PROCEDURE check_user(IN username VARCHAR(255), IN pass VARCHAR(255))
BEGIN
SELECT first_name, role_id, email FROM user where email like username and password like pass;
END$$
DELIMITER ;
Call check_user('mc@gmail.com','abc12345');
Call check_user('kh@kforce.com','abc12345');

-- get all active jobs from job table
drop procedure IF EXISTS get_all_published_jobs;
DELIMITER $$
CREATE procedure get_all_published_jobs() 
BEGIN
	SELECT 
    j.jobid,
    j.position,
    j.description,
    j.publishdate,
    j.vacancy_count,
    j.category,
    c.cityname,
    s.statename,
    o.name
FROM
    job j
        INNER JOIN
    organization o ON j.organizationid = o.orgid
        LEFT OUTER JOIN
    location l ON j.locationid = l.locationid
        INNER JOIN
    state s ON l.stateid = s.stateid
        INNER JOIN
    city c ON l.cityid = c.cityid
        INNER JOIN
    jobstatus js ON j.status = js.jobstatusid
WHERE
    LOWER(js.statusdesc) = 'published';
END$$
DELIMITER ; 
Call get_all_published_jobs();


-- get all applications saved and submitted by the applicant
drop procedure IF EXISTS get_all_applicant_applications;
DELIMITER $$
CREATE procedure get_all_applicant_applications(IN userid int) 
BEGIN
	SELECT 
    a.applicationid,
    a.skills,
    a.education,
    a.experience,
    j.position,
    o.name,
    a.status,
    a.submitdate
FROM
    application a
        LEFT OUTER JOIN
    job j ON a.jobid = j.jobid
        INNER JOIN
    organization o ON j.organizationid = o.orgid
WHERE
    a.userid = userid;
END$$
DELIMITER ; 
Call get_all_applicant_applications(5);


-- create a new application for an applicant
drop procedure IF EXISTS create_new_application;
DELIMITER $$
CREATE procedure create_new_application(IN userid int, IN skills varchar(45), IN education varchar(45),
IN experience varchar(45), IN status varchar(45), IN jobid int, IN docname varchar(45), IN docurl varchar(45),
OUT result INT) 
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    IF lower(status) = 'saved' THEN
		INSERT INTO application (skills, education, experience, status, jobid, userid)
		VALUES (skills, education, experience, status, jobid, userid);
	ELSE
		INSERT INTO application (skills, education, experience, status, jobid, userid, submitdate)
		VALUES (skills, education, experience, status, jobid, userid, now());
    END IF;
  
    IF result = 0 THEN		
        INSERT INTO document (docname, docurl, applicationid)
		VALUES (docname, docurl, LAST_INSERT_ID());
    END IF;
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END$$
DELIMITER ; 
Call create_new_application(1, 'Java, Python, SQL', 'MSCS(Northeastern University)',
null, 'Saved', 53, 'resume', 'http://testdocument1.com',@result);
select @result;
Call create_new_application(1, 'Java, Python, SQL', 'MSCS(Northeastern University)',
null, 'Submitted', 52, 'resume', 'http://testdocument2.com',@result);
select @result;
Call create_new_application(1, 'Java, Python, SQL', 'MSCS(Northeastern University)',
null, 'Saved', 51, 'resume', 'http://testdocument3.com',@result);
select @result;
Call create_new_application(2, 'Pharmacy, Chemistry', 'MSBiotech(Northeastern University)',
null, 'Saved', 5, 'cv', 'http://cvdocument.com',@result);
select @result;
Call create_new_application(2, 'Pharmacy, Chemistry', 'MSBiotech(Northeastern University)',
null, 'Submitted', 3, 'cv', 'http://cvdocument.com',@result);
select @result;
Call create_new_application(1, 'Pharmacy, Chemistry, SQL', 'MSCS(Northeastern University)',
null, 'Submitted', 5, 'cv', 'http://testdocument5.com',@result);
select @result;


-- update a saved application for an applicant
drop procedure IF EXISTS update_saved_application;
DELIMITER $$
CREATE procedure update_saved_application(IN appid int, IN skills varchar(45), 
IN education varchar(45), IN experience varchar(45), IN status varchar(45), IN docname varchar(45),
IN docurl varchar(45),OUT result INT) 
BEGIN
	DECLARE errno varchar(500);
	DECLARE appid_var INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		GET CURRENT DIAGNOSTICS CONDITION 1 errno = MESSAGE_TEXT;
		SELECT errno AS MYSQL_ERROR;
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    IF lower(status) = 'saved' THEN
		UPDATE application SET skills = skills, education=education,
        experience=experience, status=status
        where applicationid=appid;
	ELSE
		UPDATE application SET skills = skills, education=education,
        experience=experience, status=status, submitdate=now()
        where applicationid=appid;
    END IF;
  
    IF result = 0 THEN	
		UPDATE document SET docname=docname, docurl=docurl
        where applicationid=appid;
    END IF;
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END$$
DELIMITER ; 
Call update_saved_application(5, 'Tissue Culture, RTPCR, MassSpectrometry', 'MSBiotech(Northeastern University)',
null, 'Submitted', 'cv', 'http://cvdocument.com',@result);
select @result;


-- delete an application for an applicant
drop procedure IF EXISTS delete_application;
DELIMITER $$
CREATE procedure delete_application(IN appid int ,OUT result INT) 
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    DELETE from document where applicationid=appid;
    DELETE from application where applicationid=appid;
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END$$
DELIMITER ; 
Call delete_application(9 ,@result);
select @result;


-- get data for an application id
drop procedure IF EXISTS get_application_data;
DELIMITER $$
CREATE procedure get_application_data(IN appid int) 
BEGIN
	SELECT 
    a.applicationid,
    a.skills,
    a.education,
    a.experience,
    j.position,
    o.name,
    a.status,
    a.submitdate,
    d.docname,
    d.docurl
FROM
    application a
        LEFT OUTER JOIN
    job j ON a.jobid = j.jobid
        INNER JOIN
    organization o ON j.organizationid = o.orgid
        LEFT OUTER JOIN
    document d ON a.applicationid = d.applicationid
WHERE
    a.applicationid = appid;
END$$
DELIMITER ; 
Call get_application_data(4);


-- update applicant count in job table
drop procedure IF EXISTS update_applicant_count;
DELIMITER $$
CREATE procedure update_applicant_count(IN job_id INT) 
BEGIN
    UPDATE job 
	SET applicantcount = (SELECT COUNT(*) FROM application
							WHERE jobid = job_id
							AND LOWER(status) = 'submitted')
	WHERE jobid = job_id;
END$$
DELIMITER ; 
Call update_applicant_count(3);

-- triggers to update applicant count after insert,update,delete
DELIMITER $$
CREATE TRIGGER update_applicant_count_insert
  AFTER INSERT ON application 
  FOR EACH ROW 
BEGIN 
    call update_applicant_count(new.jobid);
END$$

CREATE TRIGGER update_applicant_count_update
  AFTER UPDATE ON application 
  FOR EACH ROW 
BEGIN 
    call update_applicant_count(old.jobid);
END$$

CREATE TRIGGER update_applicant_count_delete
  AFTER DELETE ON application 
  FOR EACH ROW 
BEGIN 
    call update_applicant_count(old.jobid);
END$$
DELIMITER ; 

