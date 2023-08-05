const mongoose = require("mongoose");

let cameraSchema = mongoose.Schema(
  {
    code: {
      type: String,
      required: [true, "Code must be filled"],
    },
    name: {
      type: String,
      required: [true, "Name must be filled"],
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Camera", cameraSchema);
