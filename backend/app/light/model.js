const mongoose = require('mongoose')

let lightSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, 'Name must be filled'],
    },
    light_array: {
      type: [String],
      required: [true, 'Light array must be filled'],
    },
  },
  { timestamps: true }
)

module.exports = mongoose.model('Light', lightSchema)
