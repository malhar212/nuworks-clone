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
  if (req.params.id && req.session.role) {
    let job = null;
    let applications = null;
    let application = null;
    job = await db.getJobById(req.params.id);
    applications = await db.getApplicationsOfJobById(req.params.id);
    app = applications.find((app)=> app.email == req.session.useremail);
    res.render('job', { job: job, session: req.session, applications: applications, app: app });
  }
  else {
    res.redirect('/');
  }
});

router.get('/my-jobs', async function (req, res, next) {
  console.log("IN MY JOBS");
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
  console.log("IN New JOB");
  if (req.session.userid && req.session.role && req.session.role == 2) {
    let jobs = null;
    res.render('newjob', { job: jobs, session: req.session });
  }
  else {
    res.redirect('/');
  }
});

router.post('/jobs_search', async function (req, res) {
  try {
    const league_name = req.body.league_name;
    let jobs = null
    if (Object.keys(req.body).length == 0) {
      jobs = await db.getAllJobs();
    }
    else {
      position = req.body.position;
      city = req.body.city;
      ordering = req.body.sort;
      jobs = await db.getAllJobs(position, city, ordering);
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
  console.log("Create JOB");
  if (req.session.userid && req.session.role && req.session.role == 2) {
    if (Object.keys(req.body).length == 0) {
      res.status(400)
      res.send("Empty request body");
    }
    else {
      position = req.body.position;
      type = req.body.type;
      desc = req.body.description;
      vacancycount = req.body.vacancycount;
      jobstatus = req.body.status;
      state = req.body.state;
      city = req.body.city;
      orgid = req.body.orgid,
        category = req.body.category;
      userid = req.session.userid;
      let result = null;
      result = await db.createJob(position, type, desc, jobstatus, vacancycount, orgid, category, userid, state, city);
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

router.post('/job/:id/update', async function (req, res, next) {
  console.log("IN Update JOBS");
  if (req.session.userid && req.session.role && req.session.role == 2) {
    if (Object.keys(req.body).length == 0) {
      res.status(400)
      res.send("Empty request body");
    }
    else {
      console.log(req.body);
      jobid = req.body.jobid;
      position = req.body.position;
      type = req.body.type;
      desc = req.body.description;
      vacancycount = req.body.vacancycount;
      jobstatus = req.body.status;
      state = req.body.state;
      city = req.body.city;
      orgid = req.body.orgid,
        category = req.body.category;
      userid = req.session.userid;
      let result = null;
      result = await db.updateJob(jobid, position, type, desc, jobstatus, vacancycount, orgid, category, state, city);
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

router.post('/job/:id/deletejob', async function (req, res, next) {
  console.log("IN MY JOBS");
  console.log(req.session.useremail);
  if (req.session.userid && req.session.role && req.session.role == 2) {
    if (Object.keys(req.body).length == 0) {
      res.status(400)
      res.send("Empty request body");
    }
    else {
      console.log(req.body);
      jobid = req.body.jobid;
      let result = null;
      result = await db.deleteJob(jobid);
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

router.get('/job/:id/edit', async function (req, res, next) {
  if (req.params.id && req.session.role && req.session.role == 2) {
    let job = null;
    job = await db.getJobById(req.params.id);
    applications = await db.getApplicationsOfJobById(req.params.id);
    res.render('newjob', { job: job, session: req.session });
  }
  else {
    res.redirect('/');
  }
});

router.get('/my-applications', async function (req, res, next) {
  console.log("IN MY JOBS");
  console.log(req.session.useremail);
  if (req.session.userid && req.session.role && req.session.role == 1) {
    let applications = null;
    applications = await db.getApplicationsByApplicant(req.session.userid);
    res.render('myapplications', { applications: applications, session: req.session });
  }
  else {
    res.redirect('/');
  }
});

router.get('/app/:id/view', async function (req, res, next) {
  console.log("IN MY JOBS");
  console.log(req.session.useremail);
  if (req.session.userid && req.session.role) {
    let application = null;
    application = await db.getApplicationById(req.params.id);
    res.render('application', { application: application, session: req.session });
  }
  else {
    res.redirect('/');
  }
});

router.post('/app/:id/deleteapp', async function (req, res, next) {
  console.log("Application DELETE");
  console.log(req.session.useremail);
  if (req.session.userid && req.session.role) {
    let result = null;
    result = await db.deleteApp(req.params.id);
    if (result == undefined || result.err != undefined) {
      res.status(400)
      res.send(result);
    }
    else {
      res.status(200);
      res.send();
    }
  }
  else {
    res.redirect('/');
  }
});

router.post('/createapplication', async function (req, res, next) {
  console.log("IN MY JOBS");
  console.log(req.session.useremail);
  if (req.session.userid && req.session.role && req.session.role == 1) {
    if (Object.keys(req.body).length == 0) {
      res.status(400)
      res.send("Empty request body");
    }
    else {
      console.log(req.body);
      skills = req.body.skills;
      education = req.body.education;
      experience = req.body.experience;
      appstatus = req.body.status;
      docname = req.body.docname.substring(0, 45);
      docurl = req.body.docurl.substring(0, 45);;
      jobid = req.body.jobid,
        userid = req.session.userid;
      let result = null;
      result = await db.createApplication(userid, skills, education, experience, appstatus, jobid, docname, docurl);
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
