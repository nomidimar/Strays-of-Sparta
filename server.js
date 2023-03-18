const express = require('express');
const app = express();

const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json({limit: '1mb'}));


const Sequelize = require('sequelize');
const sequelize = new Sequelize('pet_match', 'root', 'password', {
  host: 'localhost',
  dialect: 'mysql'
});

const { DataTypes } = require('sequelize');

const Dog = sequelize.define('Dog', {
    name: {
      type: DataTypes.STRING,
      allowNull: false
    },
    age: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    photo: {
      type: DataTypes.BLOB,
      allowNull: true
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    vaccinated: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    },
    spayed: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    },
    has_chip: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    },
    friendly_with_people: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    },
    friendly_with_pets: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    },
    health_state: {
      type: DataTypes.STRING,
      allowNull: true
    }
  });

 
 


// Define the route to get all dogs
app.get('/dogs', async (req, res) => {
  try {
    const dogs = await Dog.findAll();
    const dogsWithImages = dogs.map(dog => {
      // Base64 encode the blob data.
      const base64Data = Buffer.from(dog.photo).toString('base64');
      // Create a data URL for the image.
      const imageUrl = `data:image/jpeg;base64,${base64Data}`;
      // Create a new object with the image URL.
      return { ...dog.toJSON(), photoUrl: imageUrl };
    });
    res.json(dogsWithImages);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
});


// Configure multer to handle file uploads
const multer = require('multer');
const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 1024 * 1024 * 5 } // limit file size to 5 MB
}).single('photo');
const fs = require('fs');



app.use(express.json());

app.post('/dogs', async (req, res) => {
  upload(req, res, async (err) => {
    if (err) {
      console.error(err);
      return res.status(400).json({ message: 'Unable to upload photo', error: err });
    }
    try {
      const { name, age, description, vaccinated, spayed, has_chip, friendly_with_people, friendly_with_pets, health_state } = req.body;
      const photoBuffer = Buffer.from(req.body.photo, 'base64');
      const newDog = await Dog.create({
        name,
        age,
        photo: photoBuffer,
        description,
        vaccinated,
        spayed,
        has_chip,
        friendly_with_people,
        friendly_with_pets,
        health_state
      });
      res.status(201).json({ message: 'Dog created successfully', dog: newDog });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Unable to create dog', error: error });
    }
  });
});


  
//   app.post('/dogs', upload.single('photo'), async (req, res) => {
//     try {
//       const { name, age, description, vaccinated, spayed, has_chip, friendly_with_people, friendly_with_pets, health_state } = req.body;
//       const newDog = await Dog.create({
//         name,
//         age,
//         photo: req.file.buffer,
//         description,
//         vaccinated,
//         spayed,
//         has_chip,
//         friendly_with_people,
//         friendly_with_pets,
//         health_state
//       });
//       res.status(201).json({ message: 'Dog created successfully', dog: newDog });
//     } catch (error) {
//       console.error(error);
//       res.status(500).json({ message: 'Unable to create dog', error: error });
//     }
//   });
  

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(3000, () => {
  console.log('Server listening on port 3000');
});
