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

  checkAvailableBonus: async (req, res) => {
    try {
      const player = await Player.find()
      const setting = await Setting.findOne({ page: 'bonus' }).populate(
        'stage_id'
      )

      if (!setting) {
        return res.status(404).json({
          error: 1,
          message: 'Bonus stage setting not found',
        })
      }

      const stage = setting.stage_id

      if (!stage) {
        return res.status(404).json({
          error: 1,
          message: 'Bonus stage not found',
        })
      }

      if (stage.players.length >= stage.total_player) {
        return res.status(403).json({
          error: 1,
          message: 'Bonus stage is full',
        })
      }

      // Jika pemain belum masuk ke bonus stage, tambahkan pemain ke dalamnya
      if (!stage.players.includes(player._id)) {
        stage.players.push(player._id)
        await stage.save()
      }

      res.status(200).json({
        data: player,
        message: 'Bonus stage available',
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },
}
