const TheaterSeat = require('./model')

module.exports = {
  index: async (req, res) => {
    try {
      const theaterSeat = await TheaterSeat.find({
        theater_id: req.params.idTheater,
      })
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

      // Find and delete the seat
      const deletedSeat = await TheaterSeat.findOneAndRemove({
        _id: id,
      })

      if (!deletedSeat) {
        res.status(404).json({
          message: 'Theater seat not found',
          status: 'error',
        })
        return
      }

      // Extract the row and seat number from the deleted seat
      const [deletedRow, deletedSeatNum] = deletedSeat.seatNumber.split('-')

      // Find and update the remaining seats within the same row with seat numbers greater than the deleted seat
      const seatsToBeUpdated = await TheaterSeat.find({
        seatNumber: {
          $regex: `^${deletedRow}-`,
          $gt: `${deletedRow}-${deletedSeatNum}`,
        },
      }).sort({ seatNumber: 1 })

      const updatePromises = seatsToBeUpdated.map(async (seat) => {
        const [currentRow, currentSeatNum] = seat.seatNumber.split('-')
        const updatedSeatNum = `${currentRow}-${parseInt(currentSeatNum) - 1}`
        seat.seatNumber = updatedSeatNum
        return seat.save()
      })

      await Promise.all(updatePromises)

      res.status(200).json({
        message: 'Successfully deleted theater seat and re-ordered seats',
        status: 'success',
        data: [],
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },
}
