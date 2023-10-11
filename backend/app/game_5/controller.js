const Game5 = require('./model')

module.exports = {
  index: async (req, res) => {
    try {
      const game5 = await Game5.find()
      res.status(200).json({
        data: game5,
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
      const game5 = await Game5.findById(id)
      if (!game5) {
        return res.status(404).json({ message: 'Game5 not found' })
      }
      res.status(200).json({
        data: game5,
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
      const game5 = await Game5.findById(id)

      if (!game5) {
        return res.status(404).json({ message: 'Game5 not found' })
      }

      if (game5.players.includes(loggedInPlayerId)) {
        return res.status(403).json({
          message: 'You have already voted. You cannot vote again.',
        })
      }

      // Tambahkan pemain ke dalam array players pada model Game5
      game5.players.push(loggedInPlayerId)
      await game5.save()

      // Juga, tambahkan game5 ke dalam array player_chats pada model Player
      const player = await Player.findById(loggedInPlayerId)

      if (player) {
        player.player_chats.push(game5._id)
        await player.save()
      }

      res.status(200).json({
        message: 'Successfully voted for game5',
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
