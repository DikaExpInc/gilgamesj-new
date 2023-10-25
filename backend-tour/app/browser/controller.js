const Browser = require('./model')
const Stage = require('../stage/model')

const path = require('path')
const fs = require('fs')
const config = require('../../config')

module.exports = {
  index: async (req, res) => {
    try {
      const browser = await Browser.find()
      res.status(200).json({
        data: browser,
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
      const browser = await Browser.findById(id)
      if (!browser) {
        return res.status(404).json({ message: 'Browser not found' })
      }
      res.status(200).json({
        data: browser,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { title, description } = req.body
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
          `public/uploads/browsers/${image}`
        )

        const src = fs.createReadStream(tmp_path)
        const dest = fs.createWriteStream(target_path)

        src.pipe(dest)

        src.on('end', async () => {
          try {
            let browser = new Browser({
              title: title,
              description: description,
              image: `uploads/browsers/${image}`,
            })
            await browser.save()

            res.status(201).json({
              message: 'Successfully create browser',
              status: 'success',
              data: browser,
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
        let browser = new Browser({
          title: title,
          description: description,
        })
        await browser.save()

        res.status(201).json({
          message: 'Successfully create browser',
          status: 'success',
          data: browser,
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
      const { title, description } = req.body

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
          `public/uploads/browsers/${image}`
        )

        const src = fs.createReadStream(tmp_path)
        const dest = fs.createWriteStream(target_path)

        src.pipe(dest)

        src.on('end', async () => {
          try {
            const browser = await Browser.findOne({ _id: id })

            let currentImage = `${config.rootPath}/public/uploads/browsers/${browser.image}`
            if (fs.existsSync(currentImage)) {
              fs.unlinkSync(currentImage)
            }

            await Browser.findOneAndUpdate(
              {
                _id: id,
              },
              {
                title: title,
                description: description,
                image: `uploads/browsers/${image}`,
              }
            )

            res.status(200).json({
              message: 'Successfully update browser',
              status: 'success',
              data: browser,
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
        await Browser.findOneAndUpdate(
          {
            _id: id,
          },
          {
            title: title,
            description: description,
          }
        )
        res.status(200).json({
          message: 'Successfully update browser',
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

      const browser = await Browser.findOneAndRemove({
        _id: id,
      })

      let currentImage = `${config.rootPath}/public/uploads/browsers/${browser.image}`
      if (fs.existsSync(currentImage)) {
        fs.unlinkSync(currentImage)
      }

      res.status(410).json({
        message: 'Successfully delete browser',
        status: 'success',
        data: browser,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },
}
