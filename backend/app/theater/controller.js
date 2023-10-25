const Theater = require('./model')

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

	actionCreate: async (req, res) => {
		try {
			const { totalSeatRows, name, description } = req.body
			let theater = new Theater({
				name,
				description,
				totalSeatRows,
			})
			await theater.save()

			// const rows = 17
			// const cols = 11
			// const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

			// // Inisialisasi tempat duduk
			// for (let i = 0; i < rows; i++) {
			//   for (let j = 0; j < cols; j++) {
			//     const seatNumber = alphabet[j] + (i + 1)
			//     let theater = new Theater({
			//       seatNumber: seatNumber,
			//     })
			//     await theater.save()
			//   }
			// }

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
				},
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
