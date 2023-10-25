const mongoose = require("mongoose");

let notificationSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, "Name must be filled"],
    },
    description: {
      type: [String],
      required: [true, "Description must be filled"],
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Notification", notificationSchema);
