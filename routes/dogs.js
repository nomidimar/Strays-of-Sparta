const express = require('express');
const router = express.Router();
const Dog = require('../models/Dog');

// Get all dogs
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

// Post adoption/foster form
router.post('/dogs', async (req, res) => {
  // ... (your post route logic)
});

module.exports = router;
