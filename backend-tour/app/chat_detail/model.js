const mongoose = require("mongoose");

let chatDetailSchema = mongoose.Schema(
  {
    chat_family_id: {
      type: String,
      required: [true, "Chat Family must be filled"],
    },
    // chat_sibling_id: {
    //   type: String,
    //   required: [true, 'Chat Sibling must be filled'],
    // },
    order: {
      type: Number,
      required: [true, "Order must be filled"],
    },
    sender: {
      type: String,
      required: [true, "Sender must be filled"],
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
  },
  { timestamps: true }
);

module.exports = mongoose.model("ChatDetail", chatDetailSchema);
