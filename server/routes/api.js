const express = require("express")
const pretty = require("express-prettify")
const { updateDatabase, retrieveDatabase } = require("../utils/database")
const router = express.Router()


let data = retrieveDatabase();

// router.use((req, res, next) =>{
//     res.on("finish", updateDatabase);
//     next();
// })


router.get("/", (req, res)=>{
    res.end(JSON.stringify(data, null, 2))
});

router.get("/:uuid", (req, res) =>{
    let uuid = req.params.uuid
    let search = data.filter(item => item.uuid === uuid)
    res.end(JSON.stringify(search, null, 2));
})



module.exports = router;