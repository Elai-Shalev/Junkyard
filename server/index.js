const express = require('express');
const apiRouter = require("./routes/api");
const imagesRouter = require("./routes/images")
const PORT = 5000;


const app = express();
app.use(express.json());

app.use("/api/", apiRouter);
app.use("/api/images/", imagesRouter);

app.get("*", (req, res) =>{
    res.send("Don't use this")
});


app.listen(PORT, ()=>{
    console.log(`Listening on ${PORT}`);
})





