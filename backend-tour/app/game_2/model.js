const mongoose = require('mongoose')

let game2Schema = mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, 'Name must be filled'],
    },
    count: {
      type: Number,
    },
    players: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Player',
      },
    ],
  },
  { timestamps: true }
)

module.exports = mongoose.model('Game2', game2Schema)
