const mongoose = require('mongoose')

const bcrypt = require('bcryptjs')

const HASH_ROUND = 10

let playerSchema = mongoose.Schema(
  {
    email: {
      type: String,
      required: [true, 'email harus diisi'],
    },
    username: {
      type: String,
      required: [true, 'nama harus diisi'],
      maxlength: [225, 'panjang username harus antara 3 - 225 karakter'],
      minlength: [3, 'panjang username harus antara 3 - 225 karakter'],
    },
    password: {
      type: String,
      required: [true, 'kata sandi harus diisi'],
      maxlength: [225, 'panjang password maksimal 225 karakter'],
    },
    status: {
      type: String,
      enum: ['Y', 'N'],
      default: 'Y',
    },
  },
  { timestamps: true }
)

playerSchema.path('email').validate(
  async function (value) {
    try {
      const count = await this.model('Player').countDocuments({ email: value })
      return !count
    } catch (err) {
      throw err
    }
  },
  (attr) => `${attr.value} sudah terdaftar`
)

playerSchema.pre('save', function (next) {
  this.password = bcrypt.hashSync(this.password, HASH_ROUND)
  next()
})

module.exports = mongoose.model('Player', playerSchema)
