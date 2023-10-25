const mongoose = require('mongoose')

let seatSchema = mongoose.Schema(
  {
    seatNumber: {
      type: String,
      required: [true, 'Seat number must be filled'],
    },
    isOccupied: {
      type: Boolean,
      default: false,
    },
    player_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Player',
    },
  },
  { timestamps: true }
)

module.exports = mongoose.model('Seat', seatSchema)
