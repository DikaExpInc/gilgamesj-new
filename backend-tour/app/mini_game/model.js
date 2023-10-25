const mongoose = require('mongoose')
const userSchema = require('../users/model')

const miniGameSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, 'Name must be filled'],
    },
    users: [userSchema], // Menyimpan data pengguna dan skor dalam bentuk subdocument
  },
  { timestamps: true }
)

module.exports = mongoose.model('MiniGame', miniGameSchema)
