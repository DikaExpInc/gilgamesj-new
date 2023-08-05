const Player = require('../player/model')

module.exports = {
  profile: async (req, res) => {
    try {
      const player = {
        id: req.player._id,
        username: req.player.username,
        email: req.player.email,
        name: req.player.name,
      }

      res.status(200).json({ data: player })
    } catch (err) {
      res.status(500).json({ message: err.message || `Internal server error` })
    }
  },

  getAll: async (req, res) => {
    try {
      const player = await Player.find()
      res.status(200).json({
        data: player,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },
}
