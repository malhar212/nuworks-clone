use roydon7;

-- check if user login data is correct
drop procedure IF EXISTS check_user;
DELIMITER $$
CREATE PROCEDURE check_user(IN username VARCHAR(255), IN pass VARCHAR(255))
BEGIN
SELECT userid, CONCAT(lastname,',',firstname) as name, roleid, email 
FROM user where email like username and password like pass;
END$$
DELIMITER ;
Call check_user('mc@gmail.com','abc12345');
Call check_user('kh@kforce.com','abc12345');


-- get all published jobs from job table for the applicants page
drop procedure IF EXISTS get_all_published_jobs;
DELIMITER $$
CREATE procedure get_all_published_jobs() 
BEGIN
SELECT 
    j.jobid,
    o.name,
    j.position,
    j.type,
    j.description,
    j.publishdate,
    j.vacancycount,
    j.category,
    GROUP_CONCAT(CONCAT(c.cityname, '-', s.statename)) AS location
FROM
    job j
        INNER JOIN
    organization o ON j.orgid = o.orgid
        INNER JOIN
    job_app_status js ON j.jobstatusid = js.statusid
        LEFT OUTER JOIN
    joblocation jl ON j.jobid = jl.jobid
        INNER JOIN
    city c ON jl.cityid = c.cityid
        INNER JOIN
    state s ON c.stateid = s.stateid
WHERE
    LOWER(js.statusdesc) = 'submitted'
GROUP BY j.jobid;
END$$
DELIMITER ; 
Call get_all_published_jobs();


-- get all applications saved and submitted by the applicant
drop procedure IF EXISTS get_all_applicant_applications;
DELIMITER $$
CREATE procedure get_all_applicant_applications(IN pinuserid int) 
BEGIN
SELECT 
    a.applicationid,
    s.statusdesc,
    a.submitdate,
    a.skills,
    a.education,
    a.experience,
    o.name,
    j.position,
    j.type,
    j.description
FROM
    application a
        INNER JOIN
    job j ON a.jobid = j.jobid
        INNER JOIN
    organization o ON j.orgid = o.orgid
		INNER JOIN
    job_app_status s ON a.appstatusid = s.statusid
WHERE
    a.userid = pinuserid;
END$$
DELIMITER ; 
Call get_all_applicant_applications(3);
Call get_all_applicant_applications(5);
Call get_all_applicant_applications(9);
Call get_all_applicant_applications(10);
Call get_all_applicant_applications(15);


-- create a new application for an applicant
drop procedure IF EXISTS create_new_application;
DELIMITER $$
CREATE procedure create_new_application(IN pinuserid int, IN pvarskills varchar(45), 
IN pvareducation varchar(45), IN pvarexperience varchar(45), IN pinstatus int, IN pinjobid int, 
IN pvardocname varchar(200), IN pvardocurl varchar(200), OUT result INT) 
BEGIN
	DECLARE varappid int;
    DECLARE front1,front2 TEXT DEFAULT NULL;
	DECLARE frontlen1,frontlen2 INT DEFAULT NULL;
	DECLARE vardocname,vardocurl TEXT DEFAULT NULL;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    
    INSERT INTO application (skills, education, experience, appstatusid, jobid, userid, submitdate)
	VALUES (pvarskills, pvareducation, pvarexperience, pinstatus, pinjobid, pinuserid, IF(pinstatus=2, now(), null));
    
    SELECT LAST_INSERT_ID() INTO varappid; 
  
    IF result = 0 THEN
		iterator:
		LOOP  
			IF LENGTH(TRIM(pvardocname)) = 0 OR pvardocname IS NULL THEN
				LEAVE iterator;
			END IF;
            
			SET front1 = SUBSTRING_INDEX(pvardocname,',',1);
            SET front2 = SUBSTRING_INDEX(pvardocurl,',',1);
			
            SET frontlen1 = LENGTH(front1);
            SET frontlen2 = LENGTH(front2);
			
            SET vardocname = TRIM(front1);
            SET vardocurl = TRIM(front2);
			
            INSERT INTO document (docname, docurl, applicationid) VALUES (vardocname, vardocurl, varappid);
			
            SET pvardocname = INSERT(pvardocname,1,frontlen1 + 1,'');
            SET pvardocurl = INSERT(pvardocurl,1,frontlen2 + 1,'');
		END LOOP;
        
    END IF;
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END$$
DELIMITER ; 
Call create_new_application(6, 'Java, Python, SQL', 'MSCS(Northeastern University)',
null, 1, 3, 'cv', 'cv.com', @result);
select @result;
Call create_new_application(6, 'Java, Python, SQL', 'MSCS(Northeastern University)',
null, 1, 10, 'cv,coverletter, transcript', 'cv.com, coverl.com,trscipt.net', @result);
select @result;

-- update a saved application for an applicant
drop procedure IF EXISTS update_saved_application;
DELIMITER $$
CREATE procedure update_saved_application(IN appid int, IN pvarskills varchar(45), IN pvareducation varchar(45),
IN pvarexperience varchar(45), IN pinstatus int, IN pvardocname varchar(200), IN pvardocurl varchar(200),
OUT result INT) 
BEGIN
	-- DECLARE errno varchar(500);
    DECLARE front1,front2 TEXT DEFAULT NULL;
	DECLARE frontlen1,frontlen2 INT DEFAULT NULL;
	DECLARE vardocname,vardocurl TEXT DEFAULT NULL;
	DECLARE appid_var INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		-- GET CURRENT DIAGNOSTICS CONDITION 1 errno = MESSAGE_TEXT;
		-- SELECT errno AS MYSQL_ERROR;
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    
    UPDATE application SET 
    skills = pvarskills, 
    education= pvareducation,
	experience= pvarexperience, 
    appstatusid= pinstatus, 
    submitdate=IF(pinstatus=2, now(), null)
	where applicationid=appid;
  
    IF result = 0 THEN	
		DELETE from document where applicationid=appid;
        iterator:
		LOOP  
			IF LENGTH(TRIM(pvardocname)) = 0 OR pvardocname IS NULL THEN
				LEAVE iterator;
			END IF;
            
			SET front1 = SUBSTRING_INDEX(pvardocname,',',1);
            SET front2 = SUBSTRING_INDEX(pvardocurl,',',1);
			
            SET frontlen1 = LENGTH(front1);
            SET frontlen2 = LENGTH(front2);
			
            SET vardocname = TRIM(front1);
            SET vardocurl = TRIM(front2);
			
            INSERT INTO document (docname, docurl, applicationid) VALUES (vardocname, vardocurl, appid);
			
            SET pvardocname = INSERT(pvardocname,1,frontlen1 + 1,'');
            SET pvardocurl = INSERT(pvardocurl,1,frontlen2 + 1,'');
		END LOOP;
    END IF;
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END$$
DELIMITER ; 
Call update_saved_application(10, 'Java, Python, SQL', 'MSCS(Northeastern University)',
null, 2, 'cv, coverletter, new_transcripts', 'cv.com, coverl.com, new_transcripts.net', @result);
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
Call delete_application(10 ,@result);
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
    o.name,
    j.position,
    j.type,
    j.description,
    s.statusdesc,
    a.submitdate,
    GROUP_CONCAT(CONCAT(d.docname)) AS docname,
    GROUP_CONCAT(CONCAT(d.docurl)) AS docurl
FROM
    application a
        INNER JOIN
    job j ON a.jobid = j.jobid
        INNER JOIN
    organization o ON j.orgid = o.orgid
		INNER JOIN
    job_app_status s ON a.appstatusid = s.statusid
        LEFT OUTER JOIN
    document d ON a.applicationid = d.applicationid
WHERE
    a.applicationid = appid
GROUP BY a.applicationid;
END$$
DELIMITER ; 
Call get_application_data(11);


-- update applicant count in job table
drop procedure IF EXISTS update_applicant_count;
DELIMITER $$
CREATE procedure update_applicant_count(IN job_id INT) 
BEGIN
    UPDATE job 
	SET applicantcount = (SELECT COUNT(*) FROM application
							WHERE jobid = job_id
							AND appstatusid = 2)
	WHERE jobid = job_id;
END$$
DELIMITER ; 
Call update_applicant_count(1);
Call update_applicant_count(2);
Call update_applicant_count(3);
Call update_applicant_count(4);
Call update_applicant_count(5);
Call update_applicant_count(6);

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


-- get all jobs that were created by the user (or based on job status)
drop procedure IF EXISTS get_all_usercreated_jobs;
DELIMITER $$
CREATE procedure get_all_usercreated_jobs(IN pinuserid int, IN pinjobstatusid int, IN ordering varchar(10)) 
BEGIN
SET @inputuserid = pinuserid;
SET @jobstatus = pinjobstatusid;
SET @selectstmt = 'SELECT 
    j.jobid,
    o.name,
    j.position,
    j.type,
    j.description,
    js.statusdesc,
    j.publishdate,
    j.vacancycount,
    j.applicantcount,
    j.category,
    GROUP_CONCAT(CONCAT(c.cityname, ''-'', s.statename)) AS location
FROM
	job j
        INNER JOIN
    organization o ON j.orgid = o.orgid
        INNER JOIN
    job_app_status js ON j.jobstatusid = js.statusid
        LEFT OUTER JOIN
    joblocation jl ON j.jobid = jl.jobid
        INNER JOIN
    city c ON jl.cityid = c.cityid
        INNER JOIN
    state s ON c.stateid = s.stateid
WHERE
    j.userid= ?';
    
IF pinjobstatusid = 0 THEN
	SET @filter = ' ';
ELSE 
	SET @filter = ' AND j.jobstatusid = ?';
END IF;

SET @grouping = ' GROUP BY j.jobid';

IF lower(ordering) = 'asc' AND pinjobstatusid = 2 THEN 
	SET @sortorder= ' ORDER BY j.publishdate asc;';
ELSEIF lower(ordering) = 'desc' AND pinjobstatusid = 2 THEN
	SET @sortorder= ' ORDER BY j.publishdate desc;';
ELSE
	SET @sortorder= ' ORDER BY j.jobid desc;';
END IF;
SET @s = CONCAT (@selectstmt, @filter, @grouping, @sortorder); 
SELECT @s;
PREPARE stmt FROM @s;
IF pinjobstatusid = 0 THEN
	EXECUTE stmt USING @inputuserid;
ELSE
	EXECUTE stmt USING @inputuserid, @jobstatus;
END IF;
DEALLOCATE PREPARE stmt;
END$$
DELIMITER ; 
Call get_all_usercreated_jobs(1,2,'desc');


-- get all submitted applications for a job id
drop procedure IF EXISTS get_all_job_applications;
DELIMITER $$
CREATE procedure get_all_job_applications(IN pinjobid int) 
BEGIN
SELECT 
    a.applicationid,
    u.firstname,
    u.lastname,
    u.email,
    u.bio,
    a.skills,
    a.education,
    a.experience,
    a.submitdate
FROM
    application a
        INNER JOIN
    user u ON a.userid = u.userid
WHERE
    a.jobid = pinjobid AND a.appstatusid = 2;
END$$
DELIMITER ; 
Call get_all_job_applications(5);


-- get job data for a job id
drop procedure IF EXISTS get_job_data;
DELIMITER $$
CREATE procedure get_job_data(IN pinjobid int) 
BEGIN
SELECT 
    j.jobid,
    o.name,
    j.position,
    j.type,
    j.description,
    js.statusdesc,
    j.publishdate,
    j.vacancycount,
    j.applicantcount,
    j.category,
    GROUP_CONCAT(CONCAT(c.cityname, '-', s.statename)) AS location
FROM
    job j
        INNER JOIN
    organization o ON j.orgid = o.orgid
        INNER JOIN
    job_app_status js ON j.jobstatusid = js.statusid
        LEFT OUTER JOIN
    joblocation jl ON j.jobid = jl.jobid
        INNER JOIN
    city c ON jl.cityid = c.cityid
        INNER JOIN
    state s ON c.stateid = s.stateid
WHERE
    j.jobid = pinjobid
GROUP BY j.jobid;
END$$
DELIMITER ; 
Call get_job_data(3);
Call get_job_data(5);


-- create a new job by recruiter user
drop procedure IF EXISTS create_new_jobpost;
DELIMITER $$
CREATE procedure create_new_jobpost(IN pvarposition varchar(255),IN pvartype varchar(45),IN pvardescription longtext,
IN pinjobstatusid int, IN pinvacancycount int, IN pinorgid int, IN pvarcategory varchar(45), IN pinuserid int,
IN pvarstate varchar(200), IN pvarcity varchar(200), OUT result INT) 
BEGIN
	-- DECLARE errno varchar(500);
	DECLARE varjobid, varcityexists, varcityid, varorgid int;
    DECLARE front1,front2 TEXT DEFAULT NULL;
	DECLARE frontlen1,frontlen2 INT DEFAULT NULL;
	DECLARE varcityname,varstatename TEXT DEFAULT NULL;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		-- GET CURRENT DIAGNOSTICS CONDITION 1 errno = MESSAGE_TEXT;
		-- SELECT errno AS MYSQL_ERROR;
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    
    IF pinorgid = 0 THEN
		SELECT orgid INTO varorgid from user WHERE userid = pinuserid;
	ELSE 
		SET varorgid = pinorgid;
    END IF;
    
	INSERT INTO job (position, type, description, publishdate, jobstatusid, vacancycount, orgid, category, userid)
	VALUES (pvarposition, pvartype, pvardescription, IF(pinjobstatusid=2, now(), null), pinjobstatusid, pinvacancycount, varorgid, pvarcategory, pinuserid);
    
    SELECT LAST_INSERT_ID() INTO varjobid; 
  
    IF result = 0 THEN
		iterator:
		LOOP  
			IF LENGTH(TRIM(pvarcity)) = 0 OR pvarcity IS NULL THEN
				LEAVE iterator;
			END IF;
            
			SET front1 = SUBSTRING_INDEX(pvarcity,',',1);
            SET front2 = SUBSTRING_INDEX(pvarstate,',',1);
			
            SET frontlen1 = LENGTH(front1);
            SET frontlen2 = LENGTH(front2);
			
            SET varcityname = TRIM(front1);
            SET varstatename = TRIM(front2);
            
            SELECT count(*) into varcityexists FROM city where lower(cityname)=lower(varcityname);
            IF varcityexists=1 THEN
				SELECT cityid into varcityid FROM city where lower(cityname)=lower(varcityname);
                INSERT INTO `joblocation`(cityid, jobid) VALUES (varcityid, varjobid);
			ELSEIF varcityexists > 1 THEN
				SELECT cityid into varcityid FROM city where lower(cityname)=lower(varcityname)
                AND lower(statename)=lower(varstatename);
                INSERT INTO `joblocation`(cityid, jobid) VALUES (varcityid, varjobid);
            END IF;
            
            SET pvarcity = INSERT(pvarcity,1,frontlen1 + 1,'');
            SET pvarstate = INSERT(pvarstate,1,frontlen2 + 1,'');
		END LOOP;
    END IF;
    
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END$$
DELIMITER ; 
Call create_new_jobpost('SDE Intern','Internship','<p>Internship for 3 months</p>', 2, 5, 
21, 'IT', 1,'massachusetts,massachusetts','boston,cambridge', @result);
select @result;


-- update a job by recruiter user
drop procedure IF EXISTS update_jobpost;
DELIMITER $$
CREATE procedure update_jobpost(IN pinjobid int, IN pvarposition varchar(255),IN pvartype varchar(45),
IN pvardescription longtext, IN pinjobstatusid int, IN pinvacancycount int, IN pinorgid int, 
IN pvarcategory varchar(45), IN pvarstate varchar(200), IN pvarcity varchar(200), OUT result INT) 
BEGIN
	-- DECLARE errno varchar(500);
	DECLARE varjobid, varcityexists, varcityid, varorgid int;
    DECLARE front1,front2 TEXT DEFAULT NULL;
	DECLARE frontlen1,frontlen2 INT DEFAULT NULL;
	DECLARE varcityname,varstatename TEXT DEFAULT NULL;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		-- GET CURRENT DIAGNOSTICS CONDITION 1 errno = MESSAGE_TEXT;
		-- SELECT errno AS MYSQL_ERROR;
		ROLLBACK;
		SET result = 1;
	END;
    SET AUTOCOMMIT = 0;
    SET FOREIGN_KEY_CHECKS=0;
    START TRANSACTION;
	SET result = 0;
    
    IF pinorgid = 0 THEN
		SELECT orgid INTO varorgid from job WHERE jobid=pinjobid;
	ELSE
		SET varorgid = pinorgid;
    END IF;
    
    UPDATE job SET 
    position=pvarposition, 
    type=pvartype, 
    description=pvardescription, 
    publishdate=IF(pinjobstatusid=2, now(), null), 
    jobstatusid=pinjobstatusid, 
    vacancycount=pinvacancycount, 
    orgid=varorgid, 
    category=pvarcategory
	where jobid=pinjobid;
    
    IF result = 0 THEN
		DELETE from joblocation where jobid=pinjobid;
		iterator:
		LOOP  
			IF LENGTH(TRIM(pvarcity)) = 0 OR pvarcity IS NULL THEN
				LEAVE iterator;
			END IF;
            
			SET front1 = SUBSTRING_INDEX(pvarcity,',',1);
            SET front2 = SUBSTRING_INDEX(pvarstate,',',1);
			
            SET frontlen1 = LENGTH(front1);
            SET frontlen2 = LENGTH(front2);
			
            SET varcityname = TRIM(front1);
            SET varstatename = TRIM(front2);
            
            SELECT count(*) into varcityexists FROM city where lower(cityname)=lower(varcityname);
            IF varcityexists=1 THEN
				SELECT cityid into varcityid FROM city where lower(cityname)=lower(varcityname);
                INSERT INTO `joblocation`(cityid, jobid) VALUES (varcityid, pinjobid);
			ELSEIF varcityexists > 1 THEN
				SELECT cityid into varcityid FROM city where lower(cityname)=lower(varcityname)
                AND lower(statename)=lower(varstatename);
                INSERT INTO `joblocation`(cityid, jobid) VALUES (varcityid, pinjobid);
            END IF;
            
            SET pvarcity = INSERT(pvarcity,1,frontlen1 + 1,'');
            SET pvarstate = INSERT(pvarstate,1,frontlen2 + 1,'');
		END LOOP;
    END IF;
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END$$
DELIMITER ; 
Call update_jobpost(8,'SDE Intern','Internship','<p>Internship for 3 months</p>', 1, 5, 
21, 'IT','massachusetts,massachusetts,massachusetts','boston,cambridge,lowell', @result);
select @result;


-- delete a job by recruiter user
drop procedure IF EXISTS delete_job;
DELIMITER $$
CREATE procedure delete_job(IN pinjobid int ,OUT result INT) 
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
    DELETE from application where jobid = pinjobid;
    DELETE from job where jobid=pinjobid;
    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END$$
DELIMITER ; 
Call delete_job(10 ,@result);
select @result;

-- triggers to delete documents and job location data when job is delete
DELIMITER $$
CREATE TRIGGER delete_document_on_jobdelete
  AFTER DELETE ON application 
  FOR EACH ROW 
BEGIN 
    delete from document where applicationid= old.applicationid;
END$$
DELIMITER ; 

DELIMITER $$
CREATE TRIGGER delete_joblocation_on_jobdelete
  AFTER DELETE ON job 
  FOR EACH ROW 
BEGIN 
    delete from joblocation where jobid= old.jobid;
END$$
DELIMITER ; 
