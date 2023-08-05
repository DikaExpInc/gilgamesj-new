const User = require('./model')

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
  profile: async (req, res) => {
    try {
      const user = {
        id: req.user._id,
        username: req.user.username,
        email: req.user.email,
        role: req.user.role,
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
