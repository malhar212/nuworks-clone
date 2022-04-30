var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var session=require('express-session');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var db = require('./controller/dboperations');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(session({secret:'app-secret',cookie:{maxAge:31536000000}}));

var checkUser = function(req,res,next){
  if(req.session.loggedIn){
    next();
  }else{
    res.render('login',{session:req.session});
  }
};

var logout = function(req,res,next){
  req.session.loggedIn=false;
  req.session.destroy();
  res.redirect('/');
};

var login = async function(req,res,next){
  console.log("Hello");
  console.log(req.body)
  if(req.body.email != null && req.body.password != null){
    console.log("Hello 12");
    let user = await db.validateLogin(req.body.email, req.body.password);
    if (user != undefined) {
      req.session.loggedIn=true;
      req.session.role=user.roleid;
      req.session.username=user.name;
      req.session.useremail=user.email;
      req.session.userid = user.userid;
      res.redirect('/');
    }
    else {
      res.render('login',{title:"Login Here", session:req.session});
    }
  }else{
    res.render('login',{title:"Login Here", session:req.session});
  }
};

app.get('/logout', logout);
app.post('/loginSubmit', login);
app.use('/', checkUser, indexRouter);
app.use('/users', usersRouter);
//app.use('/apply', checkUser, applyRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
  console.log(err.message);
  // render the error page
  res.status(err.status || 500);
  res.render('error',{title:err, session:req.session});
});

module.exports = app;
