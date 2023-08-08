const mongoose = require('mongoose')

const taskSchema = mongoose.Schema(
  {
    title: {
      type: String,
      required: [true, 'Title must be filled'],
    },
    description: {
      type: String,
      required: [true, 'Description must be filled'],
    },
    stage_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Stage',
    },
    type: {
      type: String,
      required: [true, 'Type must be filled'],
    },
    detail_id: {
      type: String,
      required: [true, 'Detail type must be filled'],
    },
  },
  { timestamps: true }
)

module.exports = mongoose.model('Task', taskSchema)
