const MiniGame = require('./model')

module.exports = {
  index: async (req, res) => {
    try {
      const miniGame = await MiniGame.find()
      res.status(200).json({
        data: miniGame,
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
      const miniGame = await MiniGame.findById(id)
      if (!miniGame) {
        return res.status(404).json({ message: 'MiniGame not found' })
      }
      res.status(200).json({
        data: miniGame,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { code, name, url } = req.body

      let miniGame = new MiniGame({
        name: name,
      })

      await miniGame.save()

      res.status(201).json({
        message: 'Successfully create miniGame',
        status: 'success',
        data: miniGame,
      })
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },

  actionEdit: async (req, res) => {
    try {
      const { id } = req.params
      const { code, name, url } = req.body

      await MiniGame.findOneAndUpdate(
        {
          _id: id,
        },
        {
          name: name,
        }
      )
      res.status(200).json({
        message: 'Successfully update miniGame',
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

  actionDelete: async (req, res) => {
    try {
      const { id } = req.params

      await MiniGame.findOneAndRemove({
        _id: id,
      })

      res.status(410).json({
        message: 'Successfully delete miniGame',
        status: 'success',
        data: [],
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  addAction: async (req, res) => {
    try {
      const { miniGameId, userName, score } = req.body

      const miniGame = await MiniGame.findById(miniGameId)

      if (!miniGame) {
        return res.status(404).json({ message: 'MiniGame not found' })
      }

      // Menambahkan pengguna dan skor mereka ke dalam permainan ini.
      miniGame.users.push({ name: userName, score })

      await miniGame.save()

      res.status(200).json({
        message: 'Successfully added score to MiniGame',
        status: 'success',
        data: miniGame,
      })
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },

  getScores: async (req, res) => {
    try {
      const { miniGameId } = req.params

      const miniGame = await MiniGame.findById(miniGameId)

      if (!miniGame) {
        return res.status(404).json({ message: 'MiniGame not found' })
      }

      res.status(200).json({
        data: miniGame.users,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },
}
