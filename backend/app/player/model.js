const mongoose = require("mongoose");

let playerSchema = mongoose.Schema(
  {
    username: {
      type: String,
      required: [true, "Username must be filled"],
    },
    player_num: {
      type: Number,
    },
    time: {
      type: Number,
      default: 0,
    },
    status_play: {
      type: String,
      enum: ["Y", "N"],
      default: "N",
    },
    status_done: {
      type: String,
      enum: ["Y", "N"],
      default: "N",
    },
    user_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
    stage_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Stage",
    },
    player_chats: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "PlayerChat",
      },
    ],
    completes: [String],
  },
  { timestamps: true }
);

module.exports = mongoose.model("Player", playerSchema);
