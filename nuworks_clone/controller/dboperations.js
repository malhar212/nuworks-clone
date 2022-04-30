var db = require('../db');

var operations = {
    validateLogin: async (username, password)=>{
        const [rows,fields] = await db.query('CALL check_user(?,?)', [username, password]);
        if (rows!= undefined && rows[0] != undefined && rows[0][0] != undefined)
            return rows[0][0];
        return undefined;
    },

    getAllJobs: async ()=>{
        const [rows,fields] = await db.query('CALL get_all_published_jobs()');
        if (rows!= undefined && rows[0] != undefined && rows[0][0] != undefined)
            return rows[0];
        return undefined;
    },

    getJobById: async (id)=>{
        const [rows,fields] = await db.query('CALL get_job_data(?)', [id]);
        if (rows!= undefined && rows[0] != undefined && rows[0][0] != undefined)
            return rows[0][0];
        return undefined;
    },

    getApplicationsOfJobById: async (id)=>{      
        const [rows,fields] = await db.query('CALL get_all_job_applications(?)', [id]);
        if (rows!= undefined && rows[0] != undefined)
            return rows[0];
        return undefined;
    },

    getJobsByRecruiter: async (id, jobstatus, sort)=>{
        if (jobstatus == undefined) {
            jobstatus = 0
        }
        if (sort == undefined) {
            sort = "ASC"
        }
        const [rows,fields] = await db.query('CALL get_all_usercreated_jobs(?,?,?)', [id, jobstatus, sort]);
        console.log("Getting jobs by recruiter");
        console.log(id);
        console.log(rows[1]);
        if (rows!= undefined && rows[1] != undefined)
            return rows[1];
        return undefined;
    },

    createJob: async (position, type, desc, jobstatus, vacancycount, orgid, category, userid, state, city)=>{
        if (jobstatus == undefined) {
            jobstatus = 1
        }
        if (orgid == undefined) {
            orgid = 0
        }
        orgid = 2;//TODO remove
        result = null
        try {
        const [rows,fields] = await db.query('CALL create_new_jobpost(?,?,?,?,?,?,?,?,?,?,@result);', [position, type, desc, jobstatus, vacancycount, orgid, category, userid, state, city]);
        }
        catch (error) {
            return {err: error.message};
        }
        const [row1, field1] = await db.query('SELECT @result;');
        console.log("Getting jobs by recruiter");
        //console.log(rows);
        console.log(row1);
        if (row1!= undefined && row1[0] != undefined)
            return row1[0];
        return {err: 'Some error occured. Please try again'};
    }
}

module.exports = operations;