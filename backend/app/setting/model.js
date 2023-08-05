const mongoose = require("mongoose");

let settingSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, "Name must be filled"],
    },
    page: {
      type: String,
      required: [true, "Code must be filled"],
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Setting", settingSchema);
