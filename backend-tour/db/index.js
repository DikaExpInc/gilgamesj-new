const mongoose = require('mongoose')
const { urlDb } = require('../config')

mongoose.connect(urlDb, {
  useUnifiedTopology: true,
  useFindAndModify: false,
  useCreateIndex: true,
  useNewUrlParser: true,
})

const db = mongoose.connection

module.exports = db
