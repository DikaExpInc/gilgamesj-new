const mongoose = require("mongoose");

let socialMediaSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, "Name must be filled"],
    },
    description: {
      type: String,
      required: [true, "Description must be filled"],
    },
    date: {
      type: String,
      required: [true, "Date must be filled"],
    },
    like: {
      type: Number,
      required: [true, "Like must be filled"],
    },
    location: {
      type: String,
      required: [true, "Location must be filled"],
    },
    profile: {
      type: String,
      required: [true, "Profile must be filled"],
    },
    post_image: {
      type: String,
      required: [true, "Post image must be filled"],
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("SocialMedia", socialMediaSchema);
