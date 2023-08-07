const GalleryVideo = require('./model')
const path = require('path')
const fs = require('fs')
const config = require('../../config')

module.exports = {
  index: async (req, res) => {
    try {
      const galleryVideo = await GalleryVideo.find()
      res.status(200).json({
        data: galleryVideo,
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
      const galleryVideo = await GalleryVideo.findById(id)
      if (!galleryVideo) {
        return res.status(404).json({ message: 'GalleryVideo not found' })
      }
      res.status(200).json({
        data: galleryVideo,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { title, date } = req.body

      const thumbnailFile = req.files['thumbnail']
        ? req.files['thumbnail'][0]
        : null
      const videoFile = req.files['video'] ? req.files['video'][0] : null

      if (!thumbnailFile || !videoFile) {
        return res.status(422).json({
          error: 1,
          message: 'Thumbnail and video files are required.',
        })
      }

      if (!['image/jpeg', 'image/png'].includes(thumbnailFile.mimetype)) {
        return res.status(422).json({
          error: 1,
          message:
            'Invalid thumbnail image type. Only JPEG and PNG images are allowed.',
        })
      }

      if (
        !['video/mp4', 'video/mpeg', 'video/webm'].includes(videoFile.mimetype)
      ) {
        return res.status(422).json({
          error: 1,
          message:
            'Invalid video type. Only MP4, MPEG and WEBM images are allowed.',
        })
      }

      // Move thumbnail image to the destination folder
      const thumbnailPath = path.resolve(
        config.rootPath,
        `public/uploads/gallery-videos/${
          thumbnailFile.filename
        }.${thumbnailFile.originalname.split('.').pop()}`
      )
      fs.renameSync(thumbnailFile.path, thumbnailPath)

      // Move video image to the destination folder
      const videoPath = path.resolve(
        config.rootPath,
        `public/uploads/gallery-videos/${
          videoFile.filename
        }.${videoFile.originalname.split('.').pop()}`
      )
      fs.renameSync(videoFile.path, videoPath)

      // Save the filenames in the MongoDB document
      const galleryVideo = new GalleryVideo({
        thumbnail: `uploads/gallery-videos/${
          thumbnailFile.filename
        }.${thumbnailFile.originalname.split('.').pop()}`,
        video: `uploads/gallery-videos/${
          videoFile.filename
        }.${videoFile.originalname.split('.').pop()}`,
        title,
        date,
      })

      await galleryVideo.save()

      res.status(201).json({
        message: 'Successfully create gallery video',
        status: 'success',
        data: galleryVideo,
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
      const { title, date } = req.body

      let thumbnail = null
      let video = null

      if (req.files) {
        if (req.files['thumbnail']) {
          const thumbnailFile = req.files['thumbnail'][0]

          if (!['image/jpeg', 'image/png'].includes(thumbnailFile.mimetype)) {
            return res.status(422).json({
              error: 1,
              message:
                'Invalid thumbnail image type. Only JPEG and PNG images are allowed.',
            })
          }

          const thumbnailPath = path.resolve(
            config.rootPath,
            `public/uploads/gallery-videos/${
              thumbnailFile.filename
            }.${thumbnailFile.originalname.split('.').pop()}`
          )

          fs.renameSync(thumbnailFile.path, thumbnailPath)
          thumbnail = `uploads/gallery-videos/${
            thumbnailFile.filename
          }.${thumbnailFile.originalname.split('.').pop()}`
        }

        if (req.files['video']) {
          const videoFile = req.files['video'][0]

          if (
            !['video/mp4', 'video/mpeg', 'video/webm'].includes(
              videoFile.mimetype
            )
          ) {
            return res.status(422).json({
              error: 1,
              message:
                'Invalid video image type. Only JPEG and PNG images are allowed.',
            })
          }

          const videoPath = path.resolve(
            config.rootPath,
            `public/uploads/gallery-videos/${
              videoFile.filename
            }.${videoFile.originalname.split('.').pop()}`
          )

          fs.renameSync(videoFile.path, videoPath)
          video = `uploads/gallery-videos/${
            videoFile.filename
          }.${videoFile.originalname.split('.').pop()}`
        }
      }

      const galleryVideo = await GalleryVideo.findById(id)
      if (!galleryVideo) {
        return res.status(404).json({ error: 1, message: 'Gallery not found' })
      }

      galleryVideo.thumbnail = thumbnail || galleryVideo.thumbnail
      galleryVideo.video = video || galleryVideo.video
      galleryVideo.title = title || galleryVideo.title
      galleryVideo.date = date || galleryVideo.date

      // Update thumbnail image if provided
      if (thumbnail) {
        fs.unlinkSync(
          path.resolve(
            config.rootPath,
            `public/uploads/gallery-videos/${galleryVideo.thumbnail}`
          )
        )
        galleryVideo.thumbnail = thumbnail
      }

      // Update video image if provided
      if (video) {
        fs.unlinkSync(
          path.resolve(
            config.rootPath,
            `public/uploads/gallery-videos/${galleryVideo.video}`
          )
        )
        galleryVideo.video = video
      }

      await galleryVideo.save()

      res.status(200).json({
        message: 'Successfully update gallery video',
        status: 'success',
        data: galleryVideo,
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

      const galleryVideo = await GalleryVideo.findOneAndRemove({
        _id: id,
      })

      let currentImage = `${config.rootPath}/public/uploads/gallery-videos/${galleryVideo.image}`
      if (fs.existsSync(currentImage)) {
        fs.unlinkSync(currentImage)
      }

      res.status(410).json({
        message: 'Successfully delete galleryVideo',
        status: 'success',
        data: galleryVideo,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },
}
