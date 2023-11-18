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
    theater_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Theater',
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
    humbabaRows: {
      type: Number,
    },
    humbabaColumns: {
      type: Number,
    },
    spearRows: {
      type: Number,
    },
    spearColumns: {
      type: Number,
    },
  },
  { timestamps: true }
)

module.exports = mongoose.model('Setting', settingSchema)
