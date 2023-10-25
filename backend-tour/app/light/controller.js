const Light = require('./model')

module.exports = {
  index: async (req, res) => {
    try {
      const light = await Light.find()
      res.status(200).json({
        data: light,
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
      const light = await Light.findById(id)
      if (!light) {
        return res.status(404).json({ message: 'Light not found' })
      }
      res.status(200).json({
        data: light,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { light_array, name } = req.body

      let light = new Light({
        name: name,
        light_array: light_array,
      })

      await light.save()

      res.status(201).json({
        message: 'Successfully create light',
        status: 'success',
        data: light,
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
      const { light_array, name } = req.body

      await Light.findOneAndUpdate(
        {
          _id: id,
        },
        {
          name: name,
          light_array: light_array,
        }
      )
      res.status(200).json({
        message: 'Successfully update light',
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

      await Light.findOneAndRemove({
        _id: id,
      })

      res.status(410).json({
        message: 'Successfully delete light',
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
