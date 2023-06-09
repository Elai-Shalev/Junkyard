const express = require("express")
const router = express.Router()
const db = require("../utils/db")

router.get("/", (req, res)=>{
    if (Object.keys(req.query).length === 0){
        db.show_all()
        .then(r => res.json(r))
    }
    else{
        let x = parseFloat(req.query.x);
        let y = parseFloat(req.query.y);
        let radius = parseFloat(req.query.radius);
        if (Number.isNaN(x) ||  Number.isNaN(y) || Number.isNaN(radius)){
            res.json({
                success: false,
                msg: "Entries not numbers"
            })
        }
        else{
            console.log(x, y, radius);
            db.show_by_radius(y, x, radius).then(r => res.json(r));
        }
    }
})

router.post("/", (req, res)=>{
    let item = req.body;
    console.log(JSON.stringify(item));
    let newItem = {
        description: item.description,
        image_url: '0',
        location: {
            type: 'Point',
            coordinates: [ item.location.longitude, item.location.latitude]
        },
        title: item.title,
        upload_time: item.upload_time,
        user_id: item.user_id
    }
    let response;
    try{
        db.add_item(newItem);
        response = {
            success: true
        }
    }
    catch{
        response = {
            success: false
        }
    }
    response = {...response, item}
    res.json(response);
})




module.exports = router;