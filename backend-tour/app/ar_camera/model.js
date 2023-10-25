const mongoose = require('mongoose')

const arCameraSchema = mongoose.Schema(
  {
    image: {
      type: String,
      required: [true, 'Image must be filled'],
    },
  },
  { timestamps: true }
)

module.exports = mongoose.model('ArCamera', arCameraSchema)
