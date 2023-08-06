const Phone = require('./model')
const path = require('path')
const fs = require('fs')
const config = require('../../config')

module.exports = {
  index: async (req, res) => {
    try {
      const phones = await Phone.find()
      res.status(200).json({
        data: phones,
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
      const phone = await Phone.findById(id)
      if (!phone) {
        return res.status(404).json({ message: 'Phone not found' })
      }
      res.status(200).json({
        data: phone,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { name, phone_number } = req.body

      const profileImageFile = req.files['profile']
        ? req.files['profile'][0]
        : null
      const audioFile = req.files['audio'] ? req.files['audio'][0] : null

      if (!profileImageFile || !audioFile) {
        return res.status(422).json({
          error: 1,
          message: 'Both profile and audio files are required.',
        })
      }

      if (!['image/jpeg', 'image/png'].includes(profileImageFile.mimetype)) {
        return res.status(422).json({
          error: 1,
          message:
            'Invalid profile image type. Only JPEG and PNG images are allowed.',
        })
      }

      if (
        !['audio/mpeg', 'audio/wav', 'audio/mp3'].includes(audioFile.mimetype)
      ) {
        return res.status(422).json({
          error: 1,
          message:
            'Invalid audio type. Only MPEG, WAV and MP3 audio are allowed.',
        })
      }

      // Move profile image to the destination folder
      const profileImagePath = path.resolve(
        config.rootPath,
        `public/uploads/phones/${
          profileImageFile.filename
        }.${profileImageFile.originalname.split('.').pop()}`
      )
      fs.renameSync(profileImageFile.path, profileImagePath)

      // Move post image to the destination folder
      const audioPath = path.resolve(
        config.rootPath,
        `public/uploads/phones/${audioFile.filename}.${audioFile.originalname
          .split('.')
          .pop()}`
      )
      fs.renameSync(audioFile.path, audioPath)

      // Save the profile and audio filenames in the MongoDB document
      const phone = new Phone({
        name: name,
        phone_number: phone_number,
        profile: `public/uploads/phones/${
          profileImageFile.filename
        }.${profileImageFile.originalname.split('.').pop()}`,
        audio: `public/uploads/phones/${
          audioFile.filename
        }.${audioFile.originalname.split('.').pop()}`,
      })

      await phone.save()

      res.status(201).json({
        message: 'Successfully create phone',
        status: 'success',
        data: phone,
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
      const { name, phone_number } = req.body
      const profileImageFile = req.files['profile']
        ? req.files['profile'][0]
        : null
      const audioFile = req.files['audio'] ? req.files['audio'][0] : null

      let profileImage = null
      let audio = null

      if (profileImageFile) {
        if (!['image/jpeg', 'image/png'].includes(profileImageFile.mimetype)) {
          return res.status(422).json({
            error: 1,
            message:
              'Invalid profile image type. Only JPEG and PNG images are allowed.',
          })
        }

        // Move profile image to the destination folder
        const profileImagePath = path.resolve(
          config.rootPath,
          `public/uploads/contacts/${
            profileImageFile.filename
          }.${profileImageFile.originalname.split('.').pop()}`
        )
        fs.renameSync(profileImageFile.path, profileImagePath)

        profileImage = `public/uploads/contacts/${
          profileImageFile.filename
        }.${profileImageFile.originalname.split('.').pop()}`
      }

      // Cek apakah ada file audio baru yang diunggah
      if (audioFile) {
        const audioFile = req.files['audio'][0]

        if (
          !['audio/mpeg', 'audio/wav', 'audio/mp3'].includes(audioFile.mimetype)
        ) {
          return res.status(422).json({
            error: 1,
            message:
              'Invalid audio type. Only MPEG, WAV and MP3 audio are allowed.',
          })
        }

        // Move audio file to the destination folder
        const audioPath = path.resolve(
          config.rootPath,
          `public/uploads/contacts/${
            audioFile.filename
          }.${audioFile.originalname.split('.').pop()}`
        )
        fs.renameSync(audioFile.path, audioPath)

        audio = `public/uploads/contacts/${
          audioFile.filename
        }.${audioFile.originalname.split('.').pop()}`
      }

      const contact = await Contact.findById(id)
      if (!contact) {
        return res.status(404).json({ error: 1, message: 'Contact not found' })
      }

      contact.name = name
      contact.phone_number = phone_number

      // Update profile image if provided
      if (profileImage) {
        fs.unlinkSync(
          path.resolve(
            config.rootPath,
            `public/uploads/contacts/${contact.profile}`
          )
        )
        contact.profile = profileImage
      }

      // Update audio if provided
      if (audio) {
        // Delete previous audio file if it exists
        if (contact.audio) {
          fs.unlinkSync(
            path.resolve(
              config.rootPath,
              `public/uploads/contacts/${contact.audio}`
            )
          )
        }
        contact.audio = audio
      }

      await contact.save()

      res.status(200).json({
        message: 'Successfully update contact',
        status: 'success',
        data: contact,
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

      const phone = await Phone.findOneAndRemove({
        _id: id,
      })

      // Delete profile image if it exists
      if (phone.profile) {
        const profileImage = path.resolve(
          config.rootPath,
          `public/uploads/phones/${phone.profile}`
        )
        if (fs.existsSync(profileImage)) {
          fs.unlinkSync(profileImage)
        }
      }

      res.status(410).json({
        message: 'Successfully delete phone',
        status: 'success',
        data: phone,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },
}
