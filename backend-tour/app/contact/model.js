const mongoose = require("mongoose");

const contactSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, "Name must be filled"],
    },
    contact_number: {
      type: String,
      required: [true, "Contact number must be filled"],
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

module.exports = mongoose.model("Contact", contactSchema);
