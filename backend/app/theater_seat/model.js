const mongoose = require('mongoose')

let theaterSeatSchema = mongoose.Schema(
  {
    isOccupied: {
      type: Boolean,
      default:false,
    },
    seatNumber:{
      type: String,
      required: [true, 'Description must be filled'],
    },
    position:{
      type: String,
      required: [true, 'Position must be filled'],
    },
    theater_id:{
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Theater',
    }
  },
  { timestamps: true }
)

module.exports = mongoose.model('TheaterSeat', theaterSeatSchema)
