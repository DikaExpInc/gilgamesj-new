const mongoose = require("mongoose");

let galleryVideoSchema = mongoose.Schema(
  {
    title: {
      type: String,
      required: [true, "Title must be filled"],
    },
    date: {
      type: String,
      required: [true, "Date must be filled"],
    },
    image: {
      type: String,
      required: [true, "Image must be filled"],
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("GalleryVideo", galleryVideoSchema);
