const express = require("express")
const router = express.Router()
const db = require("../db")


router.get("/", (req, res)=>{
    res.json(db.show_all())
});





module.exports = router;