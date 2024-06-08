let MongoClient = require('mongodb').MongoClient;
const dbName = "junkyard"
const db_collection = "pieces"
const url = 'mongodb://localhost:27017/';
const client = new MongoClient(url, {
    useNewUrlParser: true,
    useUnifiedTopology: true
});

let isChair = false;


async function run() {
  try {
    await client.connect();
    console.log("Connected correctly to server");
    const db = client.db(dbName);

    // Get the documents collection
    const col = db.collection('pieces');
    
    // Find all documents
    const docs = await col.find().toArray();

    function randomDate(start, end) {
        return  Math.floor((new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()))).valueOf() / 1000);
    }

    // Iterate over each document and update 'upload_time' field
    for(let doc of docs) {
      const newUploadTime = randomDate(new Date(2023, 6, 5), new Date(2023, 6, 8));
      
      // Use MongoDB's updateOne method to update each document
      await col.updateOne(
        { _id: doc._id }, 
        { $set: { upload_time: newUploadTime } }
      );
    }

    console.log("Finished updating documents");

  } catch (err) {
    console.log(err.stack);
  }
  finally {
    await client.close();
  }
}
// run()

async function add_item(item) {
    await client.connect()
    const pieces = await client.db(dbName).collection(db_collection);
    const result = await pieces.insertOne(item);
    console.log(`New document inserted with the following id: ${result.insertedId}`);
    await client.close();
}

async function show_all() {
    try{
        await client.connect()
        let pieces = await client.db(dbName).collection(db_collection)
        let array =  (await pieces.find().toArray()).map(t =>{
            t._id = "" + t._id;
            t.location = { longitude: t.location.coordinates[0], latitude: t.location.coordinates[1]}
            return t;
        })
        await client.close();
        isChair = !isChair;
        return array;
    }
    catch (err){
        console.log("err");
    }
}

async function show_by_radius(x, y, r) {
    await client.connect()
    let pieces = await client.db(dbName).collection(db_collection)
    // Create 2dsphere index on location
    await pieces.createIndex({ "location": "2dsphere" });
    let maxDistanceInMeters = r;

    const query = {
        location: {
            $near: {
                $geometry: {
                    type: "Point" ,
                    coordinates: [x, y]
                },
                $maxDistance: maxDistanceInMeters
            }
        }
    };

    const items = (await pieces.find(query).toArray()).map(t => {
        t._id = "" + t._id;
        t.location = { longitude: t.location.coordinates[0], latitude: t.location.coordinates[1]}
        return t;
    });

    console.log(items.length);
    await client.close();
    return items;
}

module.exports = {
    show_all,
    show_by_radius,
    add_item
}