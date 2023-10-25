const SocialMediaComment = require('./model')
const SocialMedia = require('../social_media/model')
const path = require('path')
const fs = require('fs')
const config = require('../../config')

module.exports = {
  index: async (req, res) => {
    try {
      const socialMediaComment = await SocialMediaComment.find()
      res.status(200).json({
        data: socialMediaComment,
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
      const socialMediaComment = await SocialMediaComment.findById(id)
      if (!socialMediaComment) {
        return res.status(404).json({ message: 'Social Media not found' })
      }
      res.status(200).json({
        data: socialMediaComment,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  actionCreate: async (req, res) => {
    const { sosmedid } = req.params

    try {
      const { name, comment } = req.body
      const profileImageFile = req.files['profile']
        ? req.files['profile'][0]
        : null

      if (!profileImageFile) {
        return res.status(422).json({
          error: 1,
          message: 'Profile files are required.',
        })
      }

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
        `public/uploads/social-medias/${
          profileImageFile.filename
        }.${profileImageFile.originalname.split('.').pop()}`
      )
      fs.renameSync(profileImageFile.path, profileImagePath)

      // Save the profile and post_image filenames in the MongoDB document
      const socialMediaComment = new SocialMediaComment({
        name: name,
        comment: comment,
        profile: `uploads/social-medias/${
          profileImageFile.filename
        }.${profileImageFile.originalname.split('.').pop()}`,
      })

      await socialMediaComment.save()

      await SocialMedia.findByIdAndUpdate(sosmedid, {
        $push: { social_media_comment: socialMediaComment._id },
      })

      res.status(201).json({
        message: 'Successfully create social media',
        status: 'success',
        data: socialMediaComment,
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
      const { name, comment } = req.body

      let profileImage = null

      if (req.files) {
        if (req.files['profile']) {
          const profileFile = req.files['profile'][0]

          if (!['image/jpeg', 'image/png'].includes(profileFile.mimetype)) {
            return res.status(422).json({
              error: 1,
              message:
                'Invalid profile image type. Only JPEG and PNG images are allowed.',
            })
          }

          let profileImagePath = path.resolve(
            config.rootPath,
            `public/uploads/social-medias/${
              profileFile.filename
            }.${profileFile.originalname.split('.').pop()}`
          )

          fs.renameSync(profileFile.path, profileImagePath)
          profileImage = `uploads/social-medias/${
            profileFile.filename
          }.${profileFile.originalname.split('.').pop()}`
        }
      }

      const socialMediaComment = await SocialMediaComment.findById(id)
      if (!socialMediaComment) {
        return res
          .status(404)
          .json({ error: 1, message: 'Social Media not found' })
      }

      socialMediaComment.name = name
      socialMediaComment.comment = comment

      // Update profile image if provided
      if (profileImage) {
        fs.unlinkSync(
          path.resolve(
            config.rootPath,
            `public/uploads/social-medias/${socialMediaComment.profile}`
          )
        )
        socialMediaComment.profile = profileImage
      }

      await socialMediaComment.save()

      res.status(200).json({
        message: 'Successfully update social media comment',
        status: 'success',
        data: socialMediaComment,
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
      const { sosmedid, id } = req.params

      const socialMediaComment = await SocialMediaComment.findOneAndRemove({
        _id: id,
      })

      await SocialMedia.findByIdAndUpdate(sosmedid, {
        $pull: { social_media_comment: id },
      })

      // Delete profile image if it exists
      if (socialMediaComment.profile) {
        let profileImage = `${config.rootPath}/public/uploads/social-medias/${socialMediaComment.profile}`
        if (fs.existsSync(profileImage)) {
          fs.unlinkSync(profileImage)
        }
      }

      res.status(410).json({
        message: 'Successfully delete social media',
        status: 'success',
        data: socialMediaComment,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },
}
