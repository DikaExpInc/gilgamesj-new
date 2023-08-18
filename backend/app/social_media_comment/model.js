const mongoose = require('mongoose')

let socialMediaCommentSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, 'Name must be filled'],
    },
    comment: {
      type: String,
      required: [true, 'Comment must be filled'],
    },
    profile: {
      type: String,
      required: [true, 'Profile must be filled'],
    },
    social_media_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'SocialMedia',
    },
  },
  { timestamps: true }
)

module.exports = mongoose.model('SocialMediaComment', socialMediaCommentSchema)
