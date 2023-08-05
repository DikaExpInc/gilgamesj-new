const mongoose = require("mongoose");

let mapSchema = mongoose.Schema(
  {
    title: {
      type: String,
      required: [true, "Title must be filled"],
    },
    description: {
      type: String,
      required: [true, "Description must be filled"],
    },
    latitude: {
      type: String,
      required: [true, "Latitude must be filled"],
    },
    longitude: {
      type: String,
      required: [true, "Longitude must be filled"],
    },
    image: {
      type: String,
      required: [true, "Image must be filled"],
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Map", mapSchema);
