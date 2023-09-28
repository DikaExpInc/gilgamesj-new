const mongoose = require('mongoose')

let seatSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, 'Name must be filled'],
    },
    
  },
  { timestamps: true }
)

module.exports = mongoose.model('Seat', seatSchema)
