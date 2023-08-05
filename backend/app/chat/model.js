const mongoose = require("mongoose");

const chatSchema = mongoose.Schema(
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
    detail_chat: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "DetailChat",
      },
    ],
  },
  { timestamps: true }
);

module.exports = mongoose.model("Chat", chatSchema);
