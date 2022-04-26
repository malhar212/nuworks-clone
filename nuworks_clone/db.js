var mysql = require('mysql2');
var pool = mysql.createPool({
  host     : 'localhost',
  port: '3306',
  user     : 'root',
  password : 'malhar',
  database: 'malhar'
});

function connect () { 
    /* connection.connect(function(err) {
    if (err) {
        console.error('error connecting: ' + err.stack);
        return;
    }
    
    }); */
    pool.getConnection(function(err, conn) {
        // Do something with the connection
        if (err) {
            console.error('error connecting: ' + err.stack);
            return;
        }
        
        console.log('connected as id ' + conn.threadId);
        // Don't forget to release the connection when finished!
        pool.releaseConnection(conn);
     })
}
const promisePool = pool.promise();
connect()
module.exports = promisePool;