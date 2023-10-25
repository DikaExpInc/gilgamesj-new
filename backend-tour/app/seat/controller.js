const Seat = require('./model')

module.exports = {
  index: async (req, res) => {
    try {
      const seat = await Seat.find()
      res.status(200).json({
        data: seat,
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
      const seat = await Seat.findById(id)
      if (!seat) {
        return res.status(404).json({ message: 'Seat not found' })
      }
      res.status(200).json({
        data: seat,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { seatNumber } = req.body
      let seat = new Seat({
        seatNumber: seatNumber,
      })
      await seat.save()

      // const rows = 17
      // const cols = 11
      // const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

      // // Inisialisasi tempat duduk
      // for (let i = 0; i < rows; i++) {
      //   for (let j = 0; j < cols; j++) {
      //     const seatNumber = alphabet[j] + (i + 1)
      //     let seat = new Seat({
      //       seatNumber: seatNumber,
      //     })
      //     await seat.save()
      //   }
      // }

      res.status(201).json({
        message: 'Successfully create seat',
        status: 'success',
        data: seat,
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
      const { seatNumber } = req.body

      await Seat.findOneAndUpdate(
        {
          _id: id,
        },
        {
          seatNumber: seatNumber,
        }
      )
      res.status(200).json({
        message: 'Successfully update seat',
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

      await Seat.findOneAndRemove({
        _id: id,
      })

      res.status(410).json({
        message: 'Successfully delete seat',
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
