const mongoose = require("mongoose");

const stageSchema = mongoose.Schema(
  {
    background: {
      type: String,
      required: [true, "Background must be filled"],
    },
    objective: {
      type: String,
    },
    model: {
      type: String,
    },
    title: {
      type: String,
      required: [true, "Title must be filled"],
    },
    description: {
      type: String,
      required: [true, "Description must be filled"],
    },
    lock_code: {
      type: Number,
    },
    order_number: {
      type: Number,
      required: [true, "Order number must be filled"],
    },
    timer: {
      type: Number,
      required: [true, "Timer must be filled in minutes"],
    },
    data_game: {
      camera: [String],
      chat: [String],
      contact: [String],
      gallery_photo: [String],
      gallery_video: [String],
      map: [String],
      news: [String],
      phone: [String],
      social_media: [String],
    },
    tasks: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Task",
      },
    ],
  },
  { timestamps: true }
);

module.exports = mongoose.model("Stage", stageSchema);
