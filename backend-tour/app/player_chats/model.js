const mongoose = require("mongoose");

let playerChatSchema = mongoose.Schema(
  {
    order: {
      type: Number,
      required: [true, "Order must be filled"],
    },
    status: {
      type: String,
      required: [true, "Status must be filled"],
    },
    title: {
      type: String,
      required: [true, "Title must be filled"],
    },
    chat_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Chat",
    },
    player_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Player",
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("PlayerChat", playerChatSchema);
