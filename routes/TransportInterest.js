// const express = require('express');
// const router = express.Router();
// const TransportInterest = require('../models/TransportInterest');
// const nodemailer = require('nodemailer');


// // Define your Sequelize model (AdoptionRequest) and nodemailer transporter here...

// // Endpoint to handle adoption requests
// router.post('/transportInterest', async (req, res) => {
//   try {
//     const {
//       name_surname,
//       phone,
//       email,
//       dog_id,
//       post_code,
//       address,
//       foster,
//       duration,
//     } = req.body;

//     // Insert data into the database
//     const newRequest = await TransportInterest.create({
//       name_surname,
//       phone,
//       email,
//       dog_id,
//       post_code,
//       address,
//       foster,
//       duration,
//     });

//     // Send email with the same data
//     const mailOptions = {
//       from: 'your-email@example.com',
//       to: email,
//       subject: 'Adoption Request Confirmation',
//       text: `Thank you for your adoption request. Details: ${JSON.stringify(req.body)}`,
//     };

//     await transporter.sendMail(mailOptions);

//     res.status(201).json({ message: 'Adoption request created successfully', request: newRequest });
//   } catch (error) {
//     console.error(error);
//     res.status(500).json({ message: 'Internal Server Error', error: error.message });
//   }
// });

// module.exports = router;
