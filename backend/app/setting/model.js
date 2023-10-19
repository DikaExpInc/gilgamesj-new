const mongoose = require('mongoose')

let settingSchema = mongoose.Schema(
  {
    page: {
      type: String,
    },
    player: {
      type: String,
    },
    control: {
      type: String,
    },
    stage_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Stage',
    },
    notification: {
      type: String,
    },
    rows: {
      type: Number,
    },
    columns: {
      type: Number,
    },
    ishtarRows: {
      type: Number,
    },
    ishtarColumns: {
      type: Number,
    },
  },
  { timestamps: true }
)

module.exports = mongoose.model('Setting', settingSchema)
