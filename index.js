const express = require('express');
const dotenv = require('dotenv');
const morgan = require('morgan');
const mongoose = require('mongoose');

dotenv.config();

const app = express();
const port = process.env.PORT || 8000;
const dbURI = process.env.DB_URI;

// Suppress Mongoose deprecation warning related to the strictQuery option
mongoose.set('strictQuery', false);

//Middleware
app.use(morgan('dev'));

// Database connection
mongoose.connect(dbURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})
.then(() => {
    console.log('Connected to MonoDB');
})
.catch((err) => {
    console.error('Error connecting to MongoDB', err);
});

// Routes
app.get ('/', (req, res) =>{
    res.send('Arise and Shine For You Light Has Come');
});
app.listen(port, () => {
    console.log(`[server]: Server is running at http://localhost:${port}`);
  });