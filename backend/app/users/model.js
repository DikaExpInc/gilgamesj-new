const mongoose = require('mongoose')

let userSchema = mongoose.Schema(
  {
    email: {
      type: String,
      require: [true, 'Email must be filled'],
    },
    name: {
      type: String,
      require: [true, 'Name must be filled'],
    },
    password: {
      type: String,
      require: [true, 'Password must be filled'],
    },
    role: {
      type: String,
      enum: ['admin', 'user'],
      default: 'admin',
    },
    status: {
      type: String,
      enum: ['Y', 'N'],
      default: 'Y',
    },
  },
  { timestamps: true }
)

module.exports = mongoose.model('User', userSchema)
