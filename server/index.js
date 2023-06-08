const express = require("express");
const fs = require("fs")

const apiRouter = require("./routes/api")

const PORT = process.env.PORT || 3000;


app = express();
app.use(express.json())



app.use("/api/", apiRouter);

app.listen(PORT, ()=>{
    console.log("Listening on port: " + PORT);
})
