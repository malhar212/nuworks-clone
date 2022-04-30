const { application } = require('express');
var express = require('express');
const fs = require('fs/promises');
var router = express.Router();

var db = require('../controller/dboperations');

/* GET home page. */
router.get('/', function (req, res, next) {
  if (req.session.role == 2)
    res.redirect('/my-jobs');
  res.render('index', { jobs: null, session: req.session });
});

router.get('/job/:id', async function (req, res, next) {
  if (req.params.id && req.session.role && req.session.role == 2) {
    let job = null;
    job = await db.getJobById(req.params.id);
    applications = await db.getApplicationsOfJobById(req.params.id);
    res.render('job', { job: job, session: req.session, applications: applications });
  }
  else {
    res.redirect('/');
  }
});

router.get('/my-jobs', async function (req, res, next) {
  console.log("IN MY JOBS");
  console.log(req.session.useremail);
  if (req.session.userid && req.session.role && req.session.role == 2) {
    let jobs = null;
    jobs = await db.getJobsByRecruiter(req.session.userid);
    res.render('myjobs', { jobs: jobs, session: req.session });
  }
  else {
    res.redirect('/');
  }
});

router.post('/recruiter_jobs', async function (req, res) {
  try {
    let jobs = null
    console.log(req.body);
    console.log("IN Rec JOBS");
    if (req.session.userid && req.session.role && req.session.role == 2) {
      let jobs = null;
      jobs = await db.getJobsByRecruiter(req.session.userid, req.body.status, req.body.ordering);
      const file = await fs.readFile('./views/partials/recruiterjobs.ejs', 'utf8');
      res.send({ template: file, jobs: jobs, session: req.session });
      //res.render('myjobs', { jobs: jobs, session: req.session });
    }
    else {
      res.redirect('/');
    }
    /* const file = await readFile('../views/partials/joblist.ejs');
    var job_template = ejs.compile(file, { client: true });
    const html = job_template({jobs: jobs});
    res.send({ html: html }); */

  } catch (err) {
    console.log(err)
    res.status(500).send({ error: 'Something failed!' })
  }
});

router.get('/new-job', async function (req, res, next) {
  console.log("IN MY JOBS");
  console.log(req.session.useremail);
  if (req.session.userid && req.session.role && req.session.role == 2) {
    let jobs = null;
    res.render('newjob', { jobs: jobs, session: req.session });
  }
  else {
    res.redirect('/');
  }
});

router.post('/jobs_search', async function (req, res) {
  try {
    const league_name = req.body.league_name;
    let jobs = null
    console.log(req.body);
    if (Object.keys(req.body).length == 0) {
      jobs = await db.getAllJobs();
    }
    else {
      jobs = [{ jobid: 1, name: "Plip", position: "SE", description: "Lorem ipsum" }, { jobid: 2, name: "sas", position: "E", description: "Lorem ipsum" }]// await leagueFixtures(league_name);
    }
    /* const file = await readFile('../views/partials/joblist.ejs');
    var job_template = ejs.compile(file, { client: true });
    const html = job_template({jobs: jobs});
    res.send({ html: html }); */
    const file = await fs.readFile('./views/partials/joblist.ejs', 'utf8');
    res.send({ template: file, jobs: jobs });
  } catch (err) {
    console.log(err)
    res.status(500).send({ error: 'Something failed!' })
  }
});

router.post('/createjob', async function (req, res, next) {
  console.log("IN MY JOBS");
  console.log(req.session.useremail);
  if (req.session.userid && req.session.role && req.session.role == 2) {
    if (Object.keys(req.body).length == 0) {
      res.status(400)
      res.send("Empty request body");
    }
    else {
      console.log(req.body);
      position = req.body.position;
      type = req.body.type;
      desc = req.body.description;
      vacancycount = req.body.vacancycount;
      jobstatus = req.body.status;
      state = req.body.state;
      city = req.body.city;
      orgid = 0,
      category = req.body.category;
      userid = req.session.userid;
      let result = null;
      result = await db.createJob(position, type, desc, jobstatus, vacancycount, orgid, category, userid, state, city);
      //TODO Error checking
      //res.redirect('/my-jobs');
      if (result == undefined || result.err != undefined) {
        res.status(400)
        res.send(result);
      }
      else {
        res.status(200);
        res.send();
      }
    }
  }
  else {
    res.redirect('/');
  }
});

module.exports = router;
