const SocialMedia = require('./model')
const path = require('path')
const fs = require('fs')
const config = require('../../config')

module.exports = {
  index: async (req, res) => {
    try {
      const socialMedia = await SocialMedia.find()
      res.status(200).json({
        data: socialMedia,
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
      const socialMedia = await SocialMedia.findById(id)
      if (!socialMedia) {
        return res.status(404).json({ message: 'Social Media not found' })
      }
      res.status(200).json({
        data: socialMedia,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { name, description, date, like, location } = req.body
      const profileImageFile = req.files['profile']
        ? req.files['profile'][0]
        : null
      const postImageFile = req.files['post_image']
        ? req.files['post_image'][0]
        : null

      if (!profileImageFile || !postImageFile) {
        return res.status(422).json({
          error: 1,
          message: 'Both profile and post_image files are required.',
        })
      }

      if (!['image/jpeg', 'image/png'].includes(profileImageFile.mimetype)) {
        return res.status(422).json({
          error: 1,
          message:
            'Invalid profile image type. Only JPEG and PNG images are allowed.',
        })
      }

      if (!['image/jpeg', 'image/png'].includes(postImageFile.mimetype)) {
        return res.status(422).json({
          error: 1,
          message:
            'Invalid post image type. Only JPEG and PNG images are allowed.',
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

      // Move post image to the destination folder
      const postImagePath = path.resolve(
        config.rootPath,
        `public/uploads/social-medias/${
          postImageFile.filename
        }.${postImageFile.originalname.split('.').pop()}`
      )
      fs.renameSync(postImageFile.path, postImagePath)

      // Save the profile and post_image filenames in the MongoDB document
      const socialMedia = new SocialMedia({
        name: name,
        description: description,
        date: date,
        like: like,
        location: location,
        profile: `uploads/social-medias/${
          profileImageFile.filename
        }.${profileImageFile.originalname.split('.').pop()}`,
        post_image: `uploads/social-medias/${
          postImageFile.filename
        }.${postImageFile.originalname.split('.').pop()}`,
      })

      await socialMedia.save()

      res.status(201).json({
        message: 'Successfully create social media',
        status: 'success',
        data: socialMedia,
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
      const { name, description, date, like, location } = req.body

      let profileImage = null
      let postImage = null

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

        if (req.files['post_image']) {
          const postImageFile = req.files['post_image'][0]

          if (!['image/jpeg', 'image/png'].includes(postImageFile.mimetype)) {
            return res.status(422).json({
              error: 1,
              message:
                'Invalid post image type. Only JPEG and PNG images are allowed.',
            })
          }

          let postImagePath = path.resolve(
            config.rootPath,
            `public/uploads/social-medias/${
              postImageFile.filename
            }.${postImageFile.originalname.split('.').pop()}`
          )

          fs.renameSync(postImageFile.path, postImagePath)
          postImage = `uploads/social-medias/${
            postImageFile.filename
          }.${postImageFile.originalname.split('.').pop()}`
        }
      }

      const socialMedia = await SocialMedia.findById(id)
      if (!socialMedia) {
        return res
          .status(404)
          .json({ error: 1, message: 'Social Media not found' })
      }

      socialMedia.name = name
      socialMedia.description = description
      socialMedia.date = date
      socialMedia.like = like
      socialMedia.location = location

      // Update profile image if provided
      if (profileImage) {
        fs.unlinkSync(
          path.resolve(
            config.rootPath,
            `public/uploads/social-medias/${socialMedia.profile}`
          )
        )
        socialMedia.profile = profileImage
      }

      // Update post image if provided
      if (postImage) {
        fs.unlinkSync(
          path.resolve(
            config.rootPath,
            `public/uploads/social-medias/${socialMedia.postImage}`
          )
        )
        socialMedia.postImage = postImage
      }

      await socialMedia.save()

      res.status(200).json({
        message: 'Successfully update social media',
        status: 'success',
        data: socialMedia,
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

      const socialMedia = await SocialMedia.findOneAndRemove({
        _id: id,
      })

      // Delete profile image if it exists
      if (socialMedia.profile) {
        let profileImage = `${config.rootPath}/public/uploads/social-medias/${socialMedia.profile}`
        if (fs.existsSync(profileImage)) {
          fs.unlinkSync(profileImage)
        }
      }

      // Delete post image if it exists
      if (socialMedia.post_image) {
        let postImage = `${config.rootPath}/public/uploads/social-medias/${socialMedia.post_image}`
        if (fs.existsSync(postImage)) {
          fs.unlinkSync(postImage)
        }
      }

      res.status(410).json({
        message: 'Successfully delete social media',
        status: 'success',
        data: socialMedia,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },
}
