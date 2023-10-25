const mongoose = require('mongoose')

let theaterSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, 'Name must be filled'],
    },
    description:{
      type: String,
      required: [true, 'Description must be filled'],
    },
    totalSeatRows:{
      type: Number,
      required: [true, 'Total Seat Rows must be filled'],
    }
  },
  { timestamps: true }
)

module.exports = mongoose.model('Theater', theaterSchema)
