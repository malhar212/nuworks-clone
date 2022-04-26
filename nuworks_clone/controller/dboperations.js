var db = require('../db');

var operations = {
    validateLogin: async (username, password)=>{
        const [rows,fields] = await db.query('CALL check_user(?,?)', [username, password]);
        console.log("Hello00");
        console.log(rows[0][0]);
        if (rows[0][0] != undefined)
            return rows[0][0];
        return undefined;
    }
}

module.exports = operations;