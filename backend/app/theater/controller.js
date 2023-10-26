const Theater = require('./model')
const TheaterSeat = require('../theater_seat/model')
const Setting = require('../setting/model')

module.exports = {
  index: async (req, res) => {
    try {
      const theater = await Theater.find()
      res.status(200).json({
        data: theater,
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
      const theater = await Theater.findById(id)
      if (!theater) {
        return res.status(404).json({ message: 'Theater not found' })
      }
      res.status(200).json({
        data: theater,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  getTheaterSeatsRowCol: async (req, res) => {
    try {
      const setting = await Setting.findOne({ _id: '64de3fd2843badaf9efc006b' })

      if (!setting) {
        return res.status(404).json({
          message: 'Setting not found',
          status: 'error',
        })
      }

      // const { rows, columns } = setting
      const { theater_id } = setting

      const theater = await Theater.findOne({ _id: theater_id })

      if (!theater) {
        return res.status(404).json({
          message: 'Theater not found',
          status: 'error',
        })
      }

      const theaterSeat = await TheaterSeat.find({ theater_id: theater_id })
      if (!theaterSeat) {
        return res.status(404).json({ message: 'Theater seat not found' })
      }

      const seatsInRows = {}
      for (const seat of theaterSeat) {
        const [rowNum, colNum] = seat.seatNumber.split('-').map(Number)
        if (!seatsInRows[rowNum]) {
          seatsInRows[rowNum] = []
        }
        if (!seat.seatNumber.includes('empty')) {
          seatsInRows[rowNum].push(colNum)
        }
      }

      console.log(seatsInRows)

      res.status(200).json({
        data: seatsInRows,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { totalSeatRows, name, description } = req.body
      let theater = new Theater({
        name,
        description,
        totalSeatRows,
      })
      await theater.save()

      // // Inisialisasi tempat duduk
      for (let i = 0; i < totalSeatRows; i++) {
        for (let j = 0; j < 1; j++) {
          const seatNumber = i + 1 + '-' + (j + 1)
          let seat = new TheaterSeat({
            seatNumber: seatNumber,
            position: 'default',
            theater_id: theater._id,
          })
          await seat.save()
        }
      }

      res.status(201).json({
        message: 'Successfully create theater',
        status: 'success',
        data: theater,
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
      const { totalSeatRows, name, description } = req.body

      await Theater.findOneAndUpdate(
        {
          _id: id,
        },
        {
          name,
          description,
          totalSeatRows,
        }
      )
      res.status(200).json({
        message: 'Successfully update theater',
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

      await Theater.findOneAndRemove({
        _id: id,
      })

      res.status(410).json({
        message: 'Successfully delete theater',
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
