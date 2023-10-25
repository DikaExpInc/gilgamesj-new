const TheaterSeat = require('./model')

module.exports = {
  index: async (req, res) => {
    try {
      const theaterSeat = await TheaterSeat.find()
      res.status(200).json({
        data: theaterSeat,
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
      const theaterSeat = await TheaterSeat.findById(id)
      if (!theaterSeat) {
        return res.status(404).json({ message: 'TheaterSeat not found' })
      }
      res.status(200).json({
        data: theaterSeat,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { name, position } = req.body
      let theaterSeat = new TheaterSeat({
        seatNumber: name,
        position,
        theater_id: req.params.idTheater,
      })
      await theaterSeat.save()

      res.status(201).json({
        message: 'Successfully create theaterSeat',
        status: 'success',
        data: theaterSeat,
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
      const { name, position } = req.body

      await TheaterSeat.findOneAndUpdate(
        {
          _id: id,
        },
        {
          name,
          position,
        }
      )
      res.status(200).json({
        message: 'Successfully update theaterSeat',
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

      await TheaterSeat.findOneAndRemove({
        _id: id,
      })

      res.status(200).json({
        message: 'Successfully delete theaterSeat',
        status: 'success',
        data: [],
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },
}
