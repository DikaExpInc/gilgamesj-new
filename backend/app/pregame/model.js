const mongoose = require('mongoose')

const preGameSchema = mongoose.Schema(
  {
    icon: {
      type: String,
    },
    title: {
      type: String,
      required: [true, 'Title must be filled'],
    },
    description: {
      type: String,
      required: [true, 'Description must be filled'],
    },
    mode: {
      type: String,
      required: [true, 'Mode must be filled'],
    },
    order_number: {
      type: Number,
      required: [true, 'Order number must be filled'],
    },
    chat_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Chat',
    },
    camera_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Camera',
    },
  },
  { timestamps: true }
)

module.exports = mongoose.model('PreGame', preGameSchema)
