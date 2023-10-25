const Map = require('./model')
const path = require('path')
const fs = require('fs')
const config = require('../../config')

module.exports = {
  index: async (req, res) => {
    try {
      const map = await Map.find()
      res.status(200).json({
        data: map,
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
      const map = await Map.findById(id)
      if (!map) {
        return res.status(404).json({ message: 'Map not found' })
      }
      res.status(200).json({
        data: map,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { title, description, latitude, longitude } = req.body
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
          `public/uploads/maps/${image}`
        )

        const src = fs.createReadStream(tmp_path)
        const dest = fs.createWriteStream(target_path)

        src.pipe(dest)

        src.on('end', async () => {
          try {
            let map = new Map({
              title: title,
              description: description,
              latitude: latitude,
              longitude: longitude,
              image: `uploads/maps/${image}`,
            })
            await map.save()

            res.status(201).json({
              message: 'Successfully create map',
              status: 'success',
              data: map,
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
        let map = new Map({
          title: title,
          description: description,
          latitude: latitude,
          longitude: longitude,
        })
        await map.save()

        res.status(201).json({
          message: 'Successfully create map',
          status: 'success',
          data: map,
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
      const { title, description, latitude, longitude } = req.body

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
          `public/uploads/maps/${image}`
        )

        const src = fs.createReadStream(tmp_path)
        const dest = fs.createWriteStream(target_path)

        src.pipe(dest)

        src.on('end', async () => {
          try {
            const map = await Map.findOne({ _id: id })

            let currentImage = `${config.rootPath}/public/uploads/maps/${map.image}`
            if (fs.existsSync(currentImage)) {
              fs.unlinkSync(currentImage)
            }

            await Map.findOneAndUpdate(
              {
                _id: id,
              },
              {
                title: title,
                description: description,
                latitude: latitude,
                longitude: longitude,
                image: `uploads/maps/${image}`,
              }
            )

            res.status(200).json({
              message: 'Successfully update map',
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
        await Map.findOneAndUpdate(
          {
            _id: id,
          },
          {
            title: title,
            description: description,
            latitude: latitude,
            longitude: longitude,
          }
        )
        res.status(200).json({
          message: 'Successfully update map',
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

      const map = await Map.findOneAndRemove({
        _id: id,
      })

      let currentImage = `${config.rootPath}/public/uploads/maps/${map.image}`
      if (fs.existsSync(currentImage)) {
        fs.unlinkSync(currentImage)
      }

      res.status(410).json({
        message: 'Successfully delete map',
        status: 'success',
        data: map,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      })
    }
  },
}
