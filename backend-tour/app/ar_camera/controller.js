const ArCamera = require('./model')
const path = require('path')
const fs = require('fs')
const config = require('../../config')

module.exports = {
  index: async (req, res) => {
    try {
      const arCameras = await ArCamera.find()
      res.status(200).json({
        data: arCameras,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  getById: async (req, res) => {
    const { id } = req.params
    try {
      const arCamera = await ArCamera.findById(id)
      if (!arCamera) {
        return res.status(404).json({ message: 'ArCamera not found' })
      }
      res.status(200).json({
        data: arCamera,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const cameraImageFile = req.files['image'] ? req.files['image'][0] : null

      if (!cameraImageFile) {
        return res.status(422).json({
          error: 1,
          message: 'Image Camera files are required.',
        })
      }
      // Move profile image to the destination folder
      const cameraImagePath = path.resolve(
        config.rootPath,
        `public/uploads/cameras/${
          cameraImageFile.filename
        }.${cameraImageFile.originalname.split('.').pop()}`
      )
      fs.renameSync(cameraImageFile.path, cameraImagePath)

      // Save the profile and audio filenames in the MongoDB document
      const arCamera = new ArCamera({
        image: `uploads/cameras/${
          cameraImageFile.filename
        }.${cameraImageFile.originalname.split('.').pop()}`,
      })

      await arCamera.save()

      res.status(201).json({
        message: 'Successfully create arCamera',
        status: 'success',
        data: arCamera,
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
      const cameraImageFile = req.files['profile']
        ? req.files['profile'][0]
        : null

      let profileImage = null

      if (cameraImageFile) {
        if (!['image/jpeg', 'image/png'].includes(cameraImageFile.mimetype)) {
          return res.status(422).json({
            error: 1,
            message:
              'Invalid profile image type. Only JPEG and PNG images are allowed.',
          })
        }

        // Move profile image to the destination folder
        const cameraImagePath = path.resolve(
          config.rootPath,
          `public/uploads/cameras/${
            cameraImageFile.filename
          }.${cameraImageFile.originalname.split('.').pop()}`
        )
        fs.renameSync(cameraImageFile.path, cameraImagePath)

        profileImage = `uploads/cameras/${
          cameraImageFile.filename
        }.${cameraImageFile.originalname.split('.').pop()}`
      }

      const arCamera = await ArCamera.findById(id)
      if (!arCamera) {
        return res.status(404).json({ error: 1, message: 'ArCamera not found' })
      }

      if (profileImage) {
        fs.unlinkSync(
          path.resolve(
            config.rootPath,
            `public/uploads/cameras/${arCamera.profile}`
          )
        )
        arCamera.profile = profileImage
      }

      await arCamera.save()

      res.status(200).json({
        message: 'Successfully update arCamera',
        status: 'success',
        data: arCamera,
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

      const arCamera = await ArCamera.findOneAndRemove({
        _id: id,
      })

      // Delete profile image if it exists
      if (arCamera.profile) {
        const profileImage = path.resolve(
          config.rootPath,
          `public/uploads/cameras/${arCamera.profile}`
        )
        if (fs.existsSync(profileImage)) {
          fs.unlinkSync(profileImage)
        }
      }

      res.status(410).json({
        message: 'Successfully delete arCamera',
        status: 'success',
        data: arCamera,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },
}
