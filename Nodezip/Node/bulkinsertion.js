const jsonResponse = require("./Computer.json");
var mysql = require('mysql2');

let modelArray = jsonResponse.models;
var pool = mysql.createPool({
    host: 'localhost',
    port: '3306',
    user: 'root',
    password: 'malhar',
    database: 'malhar'
});
const db = pool.promise();

async function execute() {
    for (let i = 0; i < modelArray.length; i++) {
        model = modelArray[i];
        jobLocationArray = model.job_location.split(",");
        if (jobLocationArray.length > 2) {
            stateName = jobLocationArray[1].toString().trim();
            cityName = jobLocationArray[0].toString().trim();

            //check state
            let stateResp = await db.query('SELECT stateid FROM state where name like ?;', [stateName]);
            console.log(stateResp[0]);
            let stateid = null;
            if (stateResp[0].length == 0) {
                let stateResp = await db.query('INSERT INTO `malhar`.`state` (`name`) VALUES (?);', [stateName]);
                stateid = stateResp[0].insertId;
            }
            else {
                stateid = stateResp[0][0].stateid;
            }
            if (stateid == null) {
                throw Error("Null state id");
            }

            //check city
            let cityResp = await db.query('SELECT cityid FROM city where cityname like ? and stateid = ?;', [cityName,stateid]);
            console.log(cityResp[0]);
            let cityid = null;
            if (cityResp[0].length == 0) {
                let cityResp = await db.query('INSERT INTO `malhar`.`city` (`cityname`,`stateid`) VALUES (?,?);', [cityName,stateid]);
                cityid = cityResp[0].insertId;
            }
            else {
                cityid = cityResp[0][0].cityid;
            }
            if (cityid == null) {
                throw Error("Null city id");
            }

            //check location
            let locResp = await db.query('SELECT locationid FROM location where cityid = ? and stateid = ?;', [cityid,stateid]);
            console.log(locResp[0]);
            let locid = null;
            if (locResp[0].length == 0) {
                let locResp = await db.query('INSERT INTO `malhar`.`location` (`cityid`,`stateid`) VALUES (?,?);', [cityid,stateid]);
                locid = locResp[0].insertId;
            }
            else {
                locid = locResp[0][0].locationid;
            }
            if (locid == null) {
                throw Error("Null loc id");
            }

            //check organization
            orgname = model.name.substring(0,255) 
            let orgResp = await db.query('SELECT orgid FROM organization where name = ?;', [orgname]);
            console.log(orgResp[0]);
            let orgid = null;
            if (orgResp[0].length == 0) {
                var orgSizes = [20, 50, 100, 500, 1000];
                size = randomizer(orgSizes);
                let orgResp = await db.query('INSERT INTO `malhar`.`organization` (`name`,`size`,`locationid`) VALUES (?,?,?);', [orgname,size,locid]);
                console.log(orgResp[0]);
                orgid = orgResp[0].insertId;
            }
            else {
                orgid = orgResp[0][0].orgid;
            }
            if (orgid == null) {
                throw Error("Null org id");
            }

            //Add Job 
            var vacancies = [
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
                18, 19, 20,
            ];
            var types = ["Co-op","Internship","Full Time / Part Time"] ;
            var statuses = ["Active", "Filled", "Deactivated"];
            position = model.job_title.substring(0,255);
            jobtype = randomizer(types)
            desc = model.job_desc.substring(0,255);
            vacancy = randomizer(vacancies);
            jobstatus = randomizer(statuses);
            category = "Computer Science"//Hardcoded according to input file
            userid = 3
            let jobResp = await db.query('INSERT INTO `malhar`.`job` (`position`, `type`, `description`, `vacancy_count`, `status`, `locationid`, `organizationid`, `category`, `userid`) VALUES (?,?,?,?,?,?,?,?,?);',
             [position,jobtype,desc,vacancy,jobstatus,locid,orgid,category,userid]);
            console.log(jobResp[0]);
            jobid = null
            jobid = jobResp[0].insertId;
            if (jobid == null) {
                throw Error("Null jobid id");
            }
        }
    }
}

function randomizer(array) {
    return array[Math.floor(Math.random() * array.length)];
}
execute()