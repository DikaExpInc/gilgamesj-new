const mongoose = require('mongoose')

let settingSchema = mongoose.Schema(
  {
    page: {
      enum: ['stage', 'light', 'notification', 'bonus'],
      default: 'stage',
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
