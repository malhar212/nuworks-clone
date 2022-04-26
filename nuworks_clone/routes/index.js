var express = require('express');
const fs = require('fs/promises');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Malhar', jobs:[{organization:"Ph", position:"SWE", description: "Lorem ipsum"}] , session:req.session});
});

router.post('/jobs_search', async function (req, res) {
  try {
    const league_name = req.body.league_name;
    const jobs = [{organization:"Plip", position:"SE", description: "Lorem ipsum"},{organization:"sas", position:"E", description: "Lorem ipsum"}]// await leagueFixtures(league_name);
    /* const file = await readFile('../views/partials/joblist.ejs');
    var job_template = ejs.compile(file, { client: true });
    const html = job_template({jobs: jobs});
    res.send({ html: html }); */
    const file = await fs.readFile('./views/partials/joblist.ejs','utf8');
    res.send({ template: file, jobs: jobs });
  } catch (err) {
    console.log(err)
    res.status(500).send({ error: 'Something failed!' })
  }
});

module.exports = router;
