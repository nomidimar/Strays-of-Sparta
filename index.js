const express = require('express');
const cors = require('cors');
//const adoptionRoutes = require('./routes/TransportInterest');
const { Sequelize, DataTypes } = require('sequelize');

const sequelize = new Sequelize('strays_of_sparta', 'user', 'root', {
  host: 'localhost',
  dialect: 'mysql'
});

const db = {};

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = {
  db
};


const app = express();
app.use(cors());

const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json({limit: '1mb'}));

const Dog = sequelize.define('Dog', {
  id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    primaryKey: true
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false
  },
  age: {
    type: DataTypes.TEXT,
    allowNull: false
  },
  sex: {
    type: DataTypes.TEXT, // Update the data type according to your needs
    allowNull: true
  },
  size: {
    type: DataTypes.STRING, // Update the data type according to your needs
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
    needs_contract: {
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

const DogsPhoto = sequelize.define('dogs_photos', {
  dog_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    primaryKey: false, // Set to false since dog_id is not a primary key
  },
  dog_photo: {
    type: DataTypes.BLOB,
    allowNull: true,
  },
}, {
  timestamps: false,
  defaultScope: {
    attributes: { exclude: ['id'] },
  },
});

Dog.hasMany(DogsPhoto, { foreignKey: 'dog_id' });

const TransportInterestModel = sequelize.define('transportation_forms', {
  name_surname: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  phone: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  address: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  itinerary_id: {
    type: DataTypes.INTEGER, // Adjust the data type based on your database schema
    allowNull: false,
  },
}, {
  timestamps: false, // This will disable createdAt and updatedAt columns
});

const TransportationModel = sequelize.define('transportations', {
  from_city: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  to_city: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  pet_name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  pet_species: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  pet_weight: {
    type: DataTypes.INTEGER, // Adjust the data type based on your database schema
    allowNull: false,
  },
}, {
  timestamps: false, // This will disable createdAt and updatedAt columns
});

const PetInterestModel = sequelize.define('interest_forms', {
  name_surname: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  phone: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  post_code: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  address: {
    type: DataTypes.STRING, // Adjust the data type based on your database schema
    allowNull: false,
  },
  foster: {
    type: DataTypes.BOOLEAN, // Adjust the data type based on your database schema
    allowNull: false,
  },
  duration: {
    type: DataTypes.STRING, // Adjust the data type based on your database schema
    allowNull: true,
  },
  dog_id: {
    type: DataTypes.STRING, // Adjust the data type based on your database schema
    allowNull: false,
  },
}, {
  timestamps: false,
  defaultScope: {
    attributes: { exclude: ['id'] },
  },
});

Dog.hasMany(PetInterestModel, { foreignKey: 'dog_id' });

// Endpoint for all Dogs
app.get('/dogs', async (req, res) => {
  try {
    const { size, sex, age, friendly_with_pets } = req.query;

    const whereClause = {};
    if (size) whereClause.size = size;
    if (sex) whereClause.sex = sex;
    if (age) {
      if (age === 'young') {
        whereClause.age = { [Sequelize.Op.lte]: 2 };
      }
      if (age === 'adult') {
        whereClause.age = {
          [Sequelize.Op.gt]: 2,
          [Sequelize.Op.lte]: 8,
        };
      }
      if (age === 'old') {
        whereClause.age = { [Sequelize.Op.gt]: 8 };
      }
    }
    if (friendly_with_pets) whereClause.friendly_with_pets = friendly_with_pets === 'true';

    const dogs = await Dog.findAll({
      attributes: ['id', 'name', 'age', 'sex', 'size', 'vaccinated', 'spayed', 'needs_contract', 'friendly_with_people', 'friendly_with_pets', 'health_state'],
      where: whereClause,
    });
    

    const dogsWithImages = await Promise.all(dogs.map(async dog => {
      const { id, name, age, sex, size, vaccinated, spayed, has_health_book, friendly_with_people, friendly_with_pets, health_state, region, needs_contract, email, phone, in_foster } = dog.toJSON();
      const photos = await DogsPhoto.findAll({
        where: { dog_id: id },
      });

      const photoDataArray = photos.map(photo => photo.dog_photo.toString());


      // Decoding from base64
const decodedBuffer = Buffer.from(photoDataArray, 'base64');
console.log('Decoded Buffer:', decodedBuffer);

      return {
        id,
        name,
        age,
        sex,
        size,
        vaccinated,
        spayed,
        has_health_book,
        friendly_with_people,
        friendly_with_pets,
        health_state,
        region,
        needs_contract,
        email,
        phone,
        in_foster,
        photos: photoDataArray,
      };
    }));

    res.json(dogsWithImages);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
});



const nodemailer = require('nodemailer');

// transporter is used for mail service in both adoption form and transportation forms
const transporter = nodemailer.createTransport({
  host: 'smtp-mail.outlook.com',
  port: 587,
  secure: false, 
  auth: {
    user: 'petsparta@outlook.com.gr',
    pass: 'sept1409',
  },
});

//post trans. form
app.post('/transportInterest', async (req, res) => {
  try {

    console.log(req.body)
    
    
    console.log(req.body)
    const {
      formData: { name_surname, phone, email, address, itinerary_id },
      transportationData: { id, startingCity, destination, animalName, species, weight },
    } = req.body;
    

    // Insert data into the database
    const newRequest = await TransportInterestModel.create({
      name_surname,
      phone,
      email,
      address,
      itinerary_id
    });

    //Send email with the same data
    const mailOptions = {
      from: 'petsparta@outlook.com.gr',
      to: 'nomidimaria@yahoo.gr',
      subject: 'Εκδήλωση ενδιαφέροντος για μεταφορά κατοικιδίου',
      html: `
      <h3>Στοιχεία φόρμας:</h3>
      <p><strong>Αφετηρία:</strong> ${req.body.transportationData.startingCity}</p>
      <p><strong>Προορισμός:</strong> ${req.body.transportationData.destination}</p>
      <p><strong>Όνομα ζώου:</strong> ${req.body.transportationData.animalName}</p>
      <p><strong>Είδος:</strong> ${req.body.transportationData.species}</p>
      <p><strong>Κιλά:</strong> ${req.body.transportationData.weight}</p>
      <p><strong>Ονοματεπώνυμο:</strong> ${req.body.formData.name_surname}</p>
      <p><strong>Τηλέφωνο:</strong> ${req.body.formData.phone}</p>
      <p><strong>Email:</strong> ${req.body.formData.email}</p>
      <p><strong>Διεύθυνση:</strong> ${req.body.formData.address}</p>
    `,
    };

    await transporter.sendMail(mailOptions);

    res.status(201).json({ message: 'Adoption request created successfully', request: newRequest });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal Server Error', error: error.message });
  }
});

//post trans. form
app.post('/petInterest', async (req, res) => {
  try {

    console.log(req.body)
    
    
    console.log(req.body)
    const { name_surname, phone, email, dog_id, post_code, address, foster, duration, name } = req.body;


    // Insert data into the database
    const newRequest = await PetInterestModel.create({
      name_surname,
      phone,
      email,
      dog_id,
      post_code,
      foster,
      duration,
      address,
    });

    const requestType = foster ? 'Υοθεσια' : 'Φιλοξενία';

    //Send email with the same data
    const mailOptions = {
      from: 'petsparta@outlook.com.gr',
      to: 'nomidimaria@yahoo.gr',
      subject: 'Εκδήλωση ενδιαφέροντος για κατοικιδιο',
      html: `
      <h3>Στοιχεία φόρμας:</h3>
      <p><strong>${requestType}</strong></p>
    ${
      foster
        ? '' :  `<p><strong>Διάρκεια φιλοξενίας:</strong> ${req.body.duration}</p>`
    }
      <p><strong>Όνομα ζώου:</strong> ${req.body.name}</p>
      <p><strong>Ονοματεπώνυμο:</strong> ${req.body.name_surname}</p>
      <p><strong>Τηλέφωνο:</strong> ${req.body.phone}</p>
      <p><strong>Email:</strong> ${req.body.email}</p>
      <p><strong>Ταχυδρομικός κώδικας:</strong> ${req.body.post_code}</p>
      <p><strong>Διεύθυνση:</strong> ${req.body.address}</p>
    `,
    };

    await transporter.sendMail(mailOptions);

    res.status(201).json({ message: 'Adoption request created successfully', request: newRequest });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal Server Error', error: error.message });
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


  
app.get('/transportations', async (req, res) => {
  try {
    // Extract values from query parameters
    const { from_city, to_city, pet_name, pet_species, pet_weight } = req.query;

    // Build the where clause based on provided parameters
    const whereClause = {};
    if (from_city) whereClause.from_city = from_city;
    if (to_city) whereClause.to_city = to_city;
    if (pet_name) whereClause.pet_name = pet_name;
    if (pet_species) whereClause.pet_species = pet_species;
    if (pet_weight) whereClause.pet_weight = pet_weight;

    // Use the where clause to query your database
    const transportRequests = await TransportationModel.findAll({
      where: whereClause,
    });

    // Return the results
    res.json(transportRequests);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal Server Error', error: error.message });
  }
});

  

app.get('/', (req, res) => {
  res.send('Hello World!');
});
app.listen(3000, () => {
  console.log('Server listening on port 3000');
});

