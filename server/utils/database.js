const fs = require("fs");
const database_url = "./data/data.json"
const path = require("path")

function updateDatabase(data){
    try{
        let data = fs.writeFileSync(database_url, JSON.stringify(data, null, 2))
    }
    catch(err){
        console.log(`Error updating databse.
        Failed with error: ` + err);
        return;
    }
    console.log("Database updated")
}

function retrieveDatabase(){
    try{
        let data = fs.readFileSync(database_url, {encoding: "utf8", flag: "r"})
        return JSON.parse(data)
    }
    catch (err){
        console.log(`Failed reading data.
            Failed with error: ` + err)
            return null;
    }
}


module.exports = {updateDatabase, retrieveDatabase };