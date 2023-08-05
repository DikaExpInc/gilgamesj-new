const mongoose = require("mongoose");

let chatDetailSchema = mongoose.Schema(
  {
    chat_family_id: {
      type: String,
      required: [true, "Name must be filled"],
    },
    chat_sibling_id: {
      type: String,
      required: [true, "Description must be filled"],
    },
    order: {
      type: String,
      required: [true, "Date must be filled"],
    },
    sender: {
      type: Number,
      required: [true, "Like must be filled"],
    },
    status: {
      type: String,
      required: [true, "Location must be filled"],
    },
    title: {
      type: String,
      required: [true, "Profile must be filled"],
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("ChatDetail", chatDetailSchema);
