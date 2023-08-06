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
      if (req.file) {
        if (!['image/jpeg', 'image/png'].includes(req.file.mimetype)) {
          return res.status(422).json({
            error: 1,
            message: 'Invalid file type. Only JPEG and PNG images are allowed.',
          })
        }

        let tmp_path = req.file.path
        let originaExt =
          req.file.originalname.split('.')[
            req.file.originalname.split('.').length - 1
          ]
        let image = req.file.filename + '.' + originaExt
        let target_path = path.resolve(
          config.rootPath,
          `public/uploads/gallery-videos/${image}`
        )

        const src = fs.createReadStream(tmp_path)
        const dest = fs.createWriteStream(target_path)

        src.pipe(dest)

        src.on('end', async () => {
          try {
            let galleryVideo = new GalleryVideo({
              title: title,
              date: date,
              image: `uploads/gallery-videos/${image}`,
            })
            await galleryVideo.save()

            res.status(201).json({
              message: 'Successfully create galleryVideo',
              status: 'success',
              data: galleryVideo,
            })
          } catch (err) {
            if (err && err.name === 'ValidationError') {
              return res.status(422).json({
                error: 1,
                message: err.message,
                fields: err.errors,
              })
            }
          }
        })
      } else {
        let galleryVideo = new GalleryVideo({
          title: title,
          date: date,
        })
        await galleryVideo.save()

        res.status(201).json({
          message: 'Successfully create galleryVideo',
          status: 'success',
          data: galleryVideo,
        })
      }
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

      if (req.file) {
        if (!['image/jpeg', 'image/png'].includes(req.file.mimetype)) {
          return res.status(422).json({
            error: 1,
            message: 'Invalid file type. Only JPEG and PNG images are allowed.',
          })
        }
        let tmp_path = req.file.path
        let originaExt =
          req.file.originalname.split('.')[
            req.file.originalname.split('.').length - 1
          ]
        let image = req.file.filename + '.' + originaExt
        let target_path = path.resolve(
          config.rootPath,
          `public/uploads/gallery-videos/${image}`
        )

        const src = fs.createReadStream(tmp_path)
        const dest = fs.createWriteStream(target_path)

        src.pipe(dest)

        src.on('end', async () => {
          try {
            const galleryVideo = await GalleryVideo.findOne({ _id: id })

            let currentImage = `${config.rootPath}/public/uploads/gallery-videos/${galleryVideo.image}`
            if (fs.existsSync(currentImage)) {
              fs.unlinkSync(currentImage)
            }

            await GalleryVideo.findOneAndUpdate(
              {
                _id: id,
              },
              {
                title: title,
                date: date,
                image: `uploads/gallery-videos/${image}`,
              }
            )

            res.status(200).json({
              message: 'Successfully update galleryVideo',
              status: 'success',
              data: [],
            })
          } catch (err) {
            if (err && err.name === 'ValidationError') {
              return res.status(422).json({
                error: 1,
                message: err.message,
                fields: err.errors,
              })
            }
          }
        })
      } else {
        await GalleryVideo.findOneAndUpdate(
          {
            _id: id,
          },
          {
            title: title,
            date: date,
          }
        )
        res.status(200).json({
          message: 'Successfully update galleryVideo',
          status: 'success',
          data: [],
        })
      }
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
