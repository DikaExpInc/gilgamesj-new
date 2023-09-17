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
      // Hitung jumlah pengguna saat ini
      const userCount = await User.countDocuments()

      // Hitung grup berdasarkan modulus jumlah pengguna
      const group = (userCount % 4) + 1

      payload.group = group

      if (payload.role == undefined) {
        let user = new User(payload)
        await user.save()
        delete user._doc.password

        if (
          !payload.total_player ||
          isNaN(payload.total_player) ||
          payload.total_player <= 0
        ) {
          return res.status(400).json({ error: 'Invalid total player value' })
        }

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

        const stage = await Stage.findOne({
          $or: [{ order_number: 1 }],
        })

        if (!stage) {
          return res.status(404).json({
            error: 1,
            message: 'Stage not found',
          })
        }

        for (
          let player_num = 1;
          player_num <= payload.total_player;
          player_num++
        ) {
          let player
          if (player_num == 1) {
            player = new Player({
              username: `${user.username}-${player_num}`,
              player_num: player_num,
              stage_id: stage._id,
              user_id: user.id,
              status_play: 'Y',
            })
            await User.findByIdAndUpdate(user.id, {
              $set: { player_now: player_num },
            })
          } else {
            player = new Player({
              username: `${user.username}-${player_num}`,
              player_num: player_num,
              stage_id: stage._id,
              user_id: user.id,
            })
          }

          await player.save()

          await User.findByIdAndUpdate(user.id, {
            $push: { players: player._id },
          })
        }

        res.status(201).json({
          message: 'Successfully create user',
          status: 'success',
          data: { user, token, type: 'Bearer' },
        })
      } else {
        let user = new User(payload)
        await user.save()
        delete user._doc.password

        if (
          !payload.total_player ||
          isNaN(payload.total_player) ||
          payload.total_player <= 0
        ) {
          return res.status(400).json({ error: 'Invalid total player value' })
        }

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

        res.status(201).json({
          message: 'Successfully create user',
          status: 'success',
          data: { user, token, type: 'Bearer' },
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
      const { total_player } = req.body

      if (!total_player || isNaN(total_player) || total_player <= 0) {
        return res.status(400).json({ error: 'Invalid total player value' })
      }

      const stage = await Stage.findOne({
        $or: [{ order_number: 1 }],
      })

      if (!stage) {
        return res.status(404).json({
          error: 1,
          message: 'Stage not found',
        })
      }

      for (let player_num = 1; player_num <= total_player; player_num++) {
        let player
        if (player_num == 1) {
          player = new Player({
            username: `${req.user.username}-${player_num}`,
            player_num: player_num,
            stage_id: stage._id,
            user_id: req.user.id,
            status_play: 'Y',
          })
          await User.findByIdAndUpdate(req.user._id, {
            $set: { player_now: player_num },
          })
        } else {
          player = new Player({
            username: `${req.user.username}-${player_num}`,
            player_num: player_num,
            stage_id: stage._id,
            user_id: req.user.id,
          })
        }

        await player.save()

        await User.findByIdAndUpdate(req.user._id, {
          $push: { players: player._id },
        })
      }

      res.status(201).json({
        message: `Successfully add ${total_player} player`,
        status: 'success',
      })
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },

  getPlayers: async (req, res, next) => {
    try {
      const player = await Player.find({ user_id: req.user.id })
      res.status(200).json({
        message: `Successfully get players`,
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

  changeNamePlayer: async (req, res, next) => {
    try {
      const data = req.body

      if (!data.changes) {
        return res.status(400).json({
          message: 'Please provide the changes',
          status: 'failed',
        })
      }

      const changes = JSON.parse(data.changes)

      if (!Array.isArray(changes)) {
        return res.status(400).json({
          message: 'Changes should be an array',
          status: 'failed',
        })
      }

      const updatedUsers = await Promise.all(
        changes.map(async (change) => {
          const { player_id, playerName } = change

          if (!player_id || !playerName) {
            return null // Melewatkan perubahan yang tidak lengkap
          }

          // Mencari dan mengubah nama pemain dalam database berdasarkan _id
          return await Player.findOneAndUpdate(
            { _id: player_id },
            { username: playerName } // Menggunakan field playerName sesuai dengan model
          )
        })
      )

      const validUpdates = updatedUsers.filter((user) => user !== null)

      if (validUpdates.length === 0) {
        return res.status(404).json({
          message: 'No valid updates found',
          status: 'failed',
        })
      }

      const updatedNames = validUpdates.map((user) => user.playerName)

      res.status(200).json({
        message: `Successfully changed player names to: ${updatedNames.join(
          ', '
        )}`,
        status: 'success',
      })
    } catch (err) {
      res.status(500).json({
        message: 'An error occurred',
        status: 'error',
        error: err.message,
      })
    }
  },
}
