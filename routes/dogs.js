const bodyParser = require('body-parser');
const express = require('express');
const router = express.Router();
const Dog = require('../models/Dog');


router.use(bodyParser.urlencoded({ extended: true }));
router.use(bodyParser.json({limit: '1mb'}));




  // app.get('/dogs/:id', async (req, res) => {
  //   const { id } = req.params;
  //   try {
  //     const dog = await Dog.findByPk(id);
  //     if (!dog) {
  //       return res.status(404).json({ message: 'Dog not found' });
  //     }
  //     // Base64 encode the blob data.
  //     const base64Data = Buffer.from(dog.photo).toString('base64');
  //     // Create a data URL for the image.
  //     const imageUrl = `data:image/jpeg;base64,${base64Data}`;
  //     // Remove the buffer and data properties from the original object.
  //     delete dog.data;
  //     delete dog.buffer;
  //     // Create a new object with the image URL.
      
  //     const dogWithImage = { ...dog.toJSON(), photoUrl: imageUrl };
  //     res.json(dogWithImage);
  //   } catch (error) {
  //     console.error(error);
  //     res.status(500).json({ message: 'Internal Server Error' });
  //   }
  // });
 //get a single dog 
 


// Define the route to get all dogs
router.get('/dogs', async (req, res) => {
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



router.use(express.json());

router.post('/dogs', async (req, res) => {
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
  

router.get('/', (req, res) => {
  res.send('Hello World!');
});

module.exports = router;
