const mongoose = require('mongoose')
const bcrypt = require('bcryptjs')
const HASH_ROUND = 10

let userSchema = mongoose.Schema(
  {
    email: {
      type: String,
      require: [true, 'Email must be filled'],
    },
    username: {
      type: String,
      require: [true, 'Username must be filled'],
    },
    password: {
      type: String,
      require: [true, 'Password must be filled'],
    },
    role: {
      type: String,
      enum: ['admin', 'player'],
      default: 'player',
      required: [true, 'Role must be filled'],
    },
    status: {
      type: String,
      enum: ['Y', 'N'],
      default: 'Y',
    },
    players: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Players',
      },
    ],
    player_now: {
      type: String,
    },
    group: {
      type: Number,
    },
    user_type: {
      type: String,
      enum: ['children', 'parent', 'disability'],
      default: 'children',
      required: [true, 'User type must be filled'],
    },
    score: {
      type: Number,
      default: 0,
    },
  },
  { timestamps: true }
)

userSchema.path('email').validate(
  async function (value) {
    try {
      const count = await this.model('User').countDocuments({ email: value })
      return !count
    } catch (err) {
      throw err
    }
  },
  (attr) => `${attr.value} already registered`
)

userSchema.pre('save', function (next) {
  this.password = bcrypt.hashSync(this.password, HASH_ROUND)
  next()
})

module.exports = mongoose.model('User', userSchema)
