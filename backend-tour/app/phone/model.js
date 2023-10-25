const mongoose = require("mongoose");

const phoneSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, "Name must be filled"],
    },
    phone_number: {
      type: String,
      required: [true, "Phone number must be filled"],
    },
    profile: {
      type: String,
      required: [true, "Profile must be filled"],
    },
    audio: {
      type: String,
      required: [true, "Audio must be filled"],
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Phone", phoneSchema);
