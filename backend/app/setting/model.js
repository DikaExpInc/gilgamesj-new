const mongoose = require('mongoose')

let settingSchema = mongoose.Schema(
  {
    page: {
      type: String,
    },
    player: {
      type: String,
    },
    stage_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Stage',
    },
    notification: {
      type: String,
    },
  },
  { timestamps: true }
)

module.exports = mongoose.model('Setting', settingSchema)
