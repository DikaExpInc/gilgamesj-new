const Setting = require('./model')

module.exports = {
  index: async (req, res) => {
    try {
      const setting = await Setting.find()
      res.status(200).json({
        data: setting,
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
      const setting = await Setting.findById(id)
      if (!setting) {
        return res.status(404).json({ message: 'Setting not found' })
      }
      res.status(200).json({
        data: setting,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { page, stage_id } = req.body

      let setting = new Setting({
        page: page,
        stage_id: stage_id,
      })

      await setting.save()

      res.status(201).json({
        message: 'Successfully create setting',
        status: 'success',
        data: setting,
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
      const { page, stage_id } = req.body

      await Setting.findOneAndUpdate(
        {
          _id: id,
        },
        {
          page: page,
          stage_id: stage_id,
        }
      )
      res.status(200).json({
        message: 'Successfully update setting',
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

  actionAddNotification: async (req, res) => {
    try {
      const { id } = req.params
      const { notification } = req.body

      await Setting.findOneAndUpdate(
        {
          _id: id,
        },
        {
          notification: notification,
        }
      )
      res.status(200).json({
        message: 'Successfully update setting',
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

      await Setting.findOneAndRemove({
        _id: id,
      })

      res.status(410).json({
        message: 'Successfully delete setting',
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
