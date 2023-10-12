const Game2 = require('./model')
const Player = require('../player/model')

module.exports = {
  index: async (req, res) => {
    try {
      const game2 = await Game2.find()
      res.status(200).json({
        data: game2,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  getById: async (req, res) => {
    const { id } = req.params
    try {
      const game2 = await Game2.findById(id)
      if (!game2) {
        return res.status(404).json({ message: 'Game2 not found' })
      }
      res.status(200).json({
        data: game2,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  actionVote: async (req, res) => {
    try {
      const { id } = req.params
      const { code, name, url } = req.body

      // Dapatkan pemain yang sedang masuk (sesuaikan ini dengan sistem otentikasi Anda)
      const loggedInPlayerId = req.player._id

      // Cek apakah pemain sudah memilih
      const game2 = await Game2.findById(id)

      if (!game2) {
        return res.status(404).json({ message: 'Game2 not found' })
      }

      if (game2.players.includes(loggedInPlayerId)) {
        return res.status(403).json({
          message: 'You have already voted. You cannot vote again.',
        })
      }

      // Tambahkan pemain ke dalam array players pada model Game2
      game2.players.push(loggedInPlayerId)
      await game2.save()

      // Juga, tambahkan game2 ke dalam array player_chats pada model Player
      const player = await Player.findById(loggedInPlayerId)

      if (player) {
        player.player_chats.push(game2._id)
        await player.save()
      }

      res.status(200).json({
        message: 'Successfully voted for game2',
        status: 'success',
        data: [],
      })
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },
}
