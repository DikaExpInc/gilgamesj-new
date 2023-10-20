const User = require('./model')
const Player = require('../player/model')

module.exports = {
  getAll: async (req, res) => {
    try {
      const user = await User.find()
      res.status(200).json({
        data: user,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },
  getAllPlayer: async (req, res) => {
    try {
      const user = await User.find({ role: 'player' })
      res.status(200).json({
        data: user,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },
  // Delete a task
  actionDeletePlayer: async (req, res) => {
    const { userId } = req.params

    try {
      const user = await User.findById(userId)
      if (!user) {
        return res.status(404).json({ message: 'User not found' })
      }

      // Assuming user.players is an array of player IDs
      const playerIds = user.players

      // Use Promise.all to delete all players in parallel
      await Promise.all(
        playerIds.map(async (playerId) => {
          const deletedPlayer = await Player.findByIdAndRemove(playerId)
          if (!deletedPlayer) {
            console.log(`Player with ID ${playerId} not found`)
          }
        })
      )

      // Now that all players are deleted, you can delete the user
      await User.findByIdAndRemove(userId)

      res.status(200).json({
        message: 'Successfully deleted user and player(s)',
        status: 'success',
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },
  // Delete all player
  actionDeleteAllPlayer: async (req, res) => {
    const { userId } = req.params

    try {
      const user = await User.findById(userId)
      if (!user) {
        return res.status(404).json({ message: 'User not found' })
      }

      // Assuming user.players is an array of player IDs
      const playerIds = user.players

      // Use Promise.all to delete all players in parallel
      await Promise.all(
        playerIds.map(async (playerId) => {
          const deletedPlayer = await Player.findByIdAndRemove(playerId)
          if (!deletedPlayer) {
            console.log(`Player with ID ${playerId} not found`)
          }
        })
      )

      // Now that all players are deleted, you can delete the user
      await User.findByIdAndRemove(userId)

      res.status(200).json({
        message: 'Successfully deleted user and player(s)',
        status: 'success',
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },
  profile: async (req, res) => {
    try {
      const user = {
        id: req.user._id,
        username: req.user.username,
        email: req.user.email,
        role: req.user.role,
        userType: req.user.userType,
        status: req.user.status,
        players: req.user.players,
      }

      res.status(200).json({ data: user })
    } catch (err) {
      res.status(500).json({ message: err.message || `Internal server error` })
    }
  },
  actionLogout: (req, res) => {
    req.session.destroy()
    res.redirect('/')
  },
}
