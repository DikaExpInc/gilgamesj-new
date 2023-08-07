const mongoose = require('mongoose')

let galleryVideoSchema = mongoose.Schema(
  {
    title: {
      type: String,
      required: [true, 'Title must be filled'],
    },
    date: {
      type: String,
      required: [true, 'Date must be filled'],
    },
    thumbnail: {
      type: String,
      required: [true, 'Thumbnail must be filled'],
    },
    video: {
      type: String,
      required: [true, 'Video must be filled'],
    },
  },
  { timestamps: true }
)

module.exports = mongoose.model('GalleryVideo', galleryVideoSchema)
