const mongoose = require('mongoose')

let settingSchema = mongoose.Schema(
  {
    page: {
      type: String,
      required: [true, 'Code must be filled'],
    },
    stage_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Stage',
    },
    
  },
  { timestamps: true }
)

module.exports = mongoose.model('Setting', settingSchema)
