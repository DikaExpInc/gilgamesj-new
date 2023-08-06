const Player = require('../player/model')
const User = require('../users/model')
const Stage = require('../stage/model')
const config = require('../../config')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')

module.exports = {
  signup: async (req, res, next) => {
    try {
      const payload = req.body
      let user = new User(payload)
      await user.save()
      delete user._doc.password

      res.status(201).json({
        message: 'Successfully create user',
        status: 'success',
        data: user,
      })
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },

  signin: (req, res, next) => {
    const { email, password } = req.body
    User.findOne({ email: email })
      .then((user) => {
        if (user) {
          const checkPassword = bcrypt.compareSync(password, user.password)
          if (checkPassword) {
            const token = jwt.sign(
              {
                user: {
                  id: user.id,
                  username: user.username,
                  email: user.email,
                },
              },
              config.jwtKey
            )

            res.status(200).json({
              data: { token },
            })
          } else {
            res.status(403).json({
              message: 'Your password is wrong',
            })
          }
        } else {
          res.status(403).json({
            message: 'Email not yet registry',
          })
        }
      })
      .catch((err) => {
        res.status(500).json({
          message: err.message || `Internal server error`,
        })
      })
  },

  signinAdmin: (req, res, next) => {
    const { email, password } = req.body
    User.findOne({ email: email })
      .then((user) => {
        if (user) {
          if (user.role === 'admin') {
            const checkPassword = bcrypt.compareSync(password, user.password)
            if (checkPassword) {
              const token = jwt.sign(
                {
                  user: {
                    id: user.id,
                    username: user.username,
                    email: user.email,
                  },
                },
                config.jwtKey
              )

              res.status(200).json({
                data: { token },
              })
            } else {
              res.status(403).json({
                message: 'Your password is wrong',
              })
            }
          } else {
            res.status(403).json({
              message: 'Account is not admin role',
            })
          }
        } else {
          res.status(403).json({
            message: 'Email not yet registry',
          })
        }
      })
      .catch((err) => {
        res.status(500).json({
          message: err.message || `Internal server error`,
        })
      })
  },

  addPlayer: async (req, res, next) => {
    try {
      const { username } = req.body
      const stage = await Stage.findOne({
        $or: [{ order_number: 1 }],
      })

      if (!stage) {
        return res.status(404).json({
          error: 1,
          message: 'Stage not found',
        })
      }

      // Hitung jumlah pemain saat ini dalam koleksi "Player"
      const totalPlayers = await Player.countDocuments({
        user_id: req.user.id,
      })

      // Tambahkan 1 untuk mendapatkan nilai "player_num" baru
      const player_num = totalPlayers + 1

      let player = new Player({
        username: username,
        player_num: player_num,
        stage_id: stage._id,
        user_id: req.user.id,
      })

      if (player_num == 1)
        await User.findByIdAndUpdate(req.user._id, {
          $set: { player_now: player_num },
        })

      await player.save()
      res.status(201).json({
        message: 'Successfully add player',
        status: 'success',
        data: player,
      })
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },

  changePlayer: async (req, res, next) => {
    try {
      if (req.body.player_now != undefined) {
        await User.findOneAndUpdate(
          {
            _id: req.user._id,
          },
          {
            player_now: req.player_now++,
          }
        )
        res.status(200).json({
          message: `Successfully change player to ${req.body.player_now}`,
          status: 'success',
        })
      } else {
        res.status(403).json({
          message: `Please fill player_now`,
          status: 'failed',
        })
      }
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },
}
