
var dbName = 'local';
var url = 'mongodb://localhost:27017';  // connection url
var MongoClient = require('mongodb').MongoClient;
var client = new MongoClient(url, { useUnifiedTopology: true });



async function add_item() {
    await client.connect()
    const db = client.db(dbName);
    const collection = db.collection('pieces');

    let newItem = {
        "description" : "A new item",
        "image_url" : "0",
        "location" : {
            type: "Point",
            coordinates: [-118.124, 34.124]
        },
        "title" : "new item",
        "upload_time" : "10:00",
        "user_id" : "369258147"
    };

    const result = await collection.insertOne(newItem);
    console.log(`New document inserted with the following id: ${result.insertedId}`);
    await client.close();
}

async function show_all() {
    await client.connect()
    const db = client.db(dbName);
    const collection = db.collection('pieces');
    const items = (await collection.find().toArray()).map(t =>{
        t._id = "" + t._id;
        return t;
    });
    console.log(items);
    await client.close();
    return items;
}

async function show_by_radius(x, y, r) {
    await client.connect()
    const db = client.db(dbName);
    const collection = db.collection('pieces');
    // Create 2dsphere index on location
    await collection.createIndex({ "location": "2dsphere" });
    let maxDistanceInMeters = r * 1000;

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

    const items = (await collection.find(query).toArray()).map(t => {
        t._id = "" + t._id;
        return t;
    });

    console.log(items);
    await client.close();
    return items;
}
