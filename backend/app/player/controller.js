module.exports = {
  profile: async (req, res) => {
    try {
      const player = {
        id: req.player._id,
        username: req.player.username,
        email: req.player.email,
        name: req.player.name,
        avatar: req.player.avatar,
        phone_number: req.player.phoneNumber,
      }

      res.status(200).json({ data: player })
    } catch (err) {
      res.status(500).json({ message: err.message || `Internal server error` })
    }
  },
}
