const mongoose = require('mongoose')

let playerSchema = mongoose.Schema(
  {
    username: {
      type: String,
      required: [true, 'Username must be filled'],
    },
    player_num: {
      type: Number,
    },
    time: {
      type: Number,
      default: 0,
    },
    status_done: {
      type: String,
      enum: ['Y', 'N'],
      default: 'N',
    },
    user_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
    },
    stage_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Stage',
    },
    completes: [String],
  },
  { timestamps: true }
)

module.exports = mongoose.model('Player', playerSchema)
