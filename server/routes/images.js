const express = require("express")
const router = express.Router()
const path = require("path")

const number_of_trash = 11;

router.get("/", (req, res) =>{
    let image_path;
    let id = Math.floor(Math.random() * number_of_trash) + 1;
    // id = Math.floor(Math.random() * 3) + 1
    image_path = path.resolve(`./images/${id}.jpg`)
    image_path = path.resolve(`./images/12.jpg`)
    res.sendFile(image_path)
})



module.exports = router;