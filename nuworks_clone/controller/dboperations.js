var db = require('../db');

var operations = {
    validateLogin: async (username, password) => {
        const [rows, fields] = await db.query('CALL check_user(?,?)', [username, password]);
        if (rows != undefined && rows[0] != undefined && rows[0][0] != undefined)
            return rows[0][0];
        return undefined;
    },

    getAllJobs: async (position, city, ordering) => {
        if (city == undefined) {
            city = city;
        }
        if (position == undefined) {
            position = null;
        }
        if (ordering == undefined) {
            ordering = "DESC"
        }
        console.log(position,city,ordering);
        const [rows, fields] = await db.query('CALL get_all_published_jobs(?,?,?)',[position, city, ordering]);
        if (rows != undefined && rows[1] != undefined)
            return rows[1];
        return undefined;
    },

    getJobById: async (id) => {
        const [rows, fields] = await db.query('CALL get_job_data(?)', [id]);
        if (rows != undefined && rows[0] != undefined && rows[0][0] != undefined)
            return rows[0][0];
        return undefined;
    },

    getApplicationsOfJobById: async (id) => {
        const [rows, fields] = await db.query('CALL get_all_job_applications(?)', [id]);
        if (rows != undefined && rows[0] != undefined)
            return rows[0];
        return undefined;
    },

    getJobsByRecruiter: async (id, jobstatus, sort) => {
        if (jobstatus == undefined) {
            jobstatus = 0
        }
        if (jobstatus == 2 && sort == undefined) {
            sort = "DESC"
        }
        const [rows, fields] = await db.query('CALL get_all_usercreated_jobs(?,?,?)', [id, jobstatus, sort]);
        console.log("Getting jobs by recruiter");
        if (rows != undefined && rows[1] != undefined)
            return rows[1];
        return undefined;
    },

    createJob: async (position, type, desc, jobstatus, vacancycount, orgid, category, userid, state, city) => {
        if (jobstatus == undefined) {
            jobstatus = 1
        }
        if (orgid == undefined) {
            orgid = 0
        }
        result = null
        try {
            const [rows, fields] = await db.query('CALL create_new_jobpost(?,?,?,?,?,?,?,?,?,?,@result);', [position, type, desc, jobstatus, vacancycount, orgid, category, userid, state, city]);
        }
        catch (error) {
            return { err: error.message };
        }
        const [row1, field1] = await db.query('SELECT @result;');
        console.log("Creating job");
        if (row1 != undefined && row1[0] != undefined)
            return row1[0];
        return { err: 'Some error occured. Please try again' };
    },

    updateJob: async (jobid, position, type, desc, jobstatus, vacancycount, orgid, category, state, city) => {
        if (jobstatus == undefined) {
            jobstatus = 1
        }
        if (orgid == undefined) {
            orgid = 0
        }
        result = null
        try {
            const [rows, fields] = await db.query('CALL update_jobpost(?,?,?,?,?,?,?,?,?,?,@result); SELECT @result;', [jobid, position, type, desc, jobstatus, vacancycount, orgid, category, state, city]);
        }
        catch (error) {
            return { err: error.message };
        }
        const [row1, field1] = await db.query('SELECT @result;');
        console.log("Updating jobs by recruiter");
        if (row1 != undefined && row1[0] != undefined)
            return row1[0];
        return { err: 'Some error occured. Please try again' };
    },

    deleteJob: async (jobid) => {
        result = null
        try {
            const [rows, fields] = await db.query('CALL delete_job(?,@result); SELECT @result;', [jobid]);
        }
        catch (error) {
            return { err: error.message };
        }
        const [row1, field1] = await db.query('SELECT @result;');
        console.log("Delete jobs by recruiter");
        if (row1 != undefined && row1[0] != undefined)
            return row1[0];
        return { err: 'Some error occured. Please try again' };
    },

    getApplicationsByApplicant: async (id) => {
        const [rows, fields] = await db.query('CALL get_all_applicant_applications(?)', [id]);
        console.log("Getting applications by user");
        if (rows != undefined && rows[0] != undefined)
            return rows[0];
        return undefined;
    },

    getApplicationById: async (id) => {
        const [rows, fields] = await db.query('CALL get_application_data(?)', [id]);
        console.log("Getting application by id");
        if (rows != undefined && rows[0] != undefined && rows[0][0] != undefined)
            return rows[0][0];
        return undefined;
    },

    createApplication: async (userid, skills, education, experience, appstatus, jobid, docname, docurl) => {
        if (appstatus == undefined) {
            appstatus = 2
        }
        result = null
        try {
            const [rows, fields] = await db.query('CALL create_new_application(?,?,?,?,?,?,?,?,@result); SELECT @result;', [userid, skills, education, experience, appstatus, jobid, docname, docurl]);
            console.log("Creating Application");
            if (rows != undefined && rows[0] != undefined)
                return rows[0];
        }
        catch (error) {
            return { err: error.message };
        }
        return { err: 'Some error occured. Please try again' };
    },

    deleteApp: async (appid) => {
        result = null
        try {
            const [rows, fields] = await db.query('CALL delete_application(?,@result); SELECT @result;', [appid]);
            console.log("Deleting Application");
            if (rows != undefined && rows[1] != undefined)
                return rows[1];
        }
        catch (error) {
            return { err: error.message };
        }
        return { err: 'Some error occured. Please try again' };
    },

    testConnection: async () => {
        try {
            const [rows, fields] = await db.query('SELECT * FROM JOB LIMIT 1');
            return {err:undefined};
        }
        catch (e) {
            return {err:'NO DB CONNECTION'};
        }
    }
}

module.exports = operations;