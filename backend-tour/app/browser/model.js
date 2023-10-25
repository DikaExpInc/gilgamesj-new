const mongoose = require("mongoose");

let browserSchema = mongoose.Schema(
  {
    title: {
      type: String,
      required: [true, "Title must be filled"],
    },
    description: {
      type: String,
      required: [true, "Description must be filled"],
    },
    image: {
      type: String,
      required: [true, "Image must be filled"],
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Browser", browserSchema);
