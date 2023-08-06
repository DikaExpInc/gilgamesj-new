const Stage = require('./model')
const path = require('path')
const fs = require('fs')
const config = require('../../config')

module.exports = {
  index: async (req, res) => {
    try {
      const stages = await Stage.find()
      res.status(200).json({
        data: stages,
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
      const stage = await Stage.findById(id)
      if (!stage) {
        return res.status(404).json({ message: 'Stage not found' })
      }
      res.status(200).json({
        data: stage,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  actionCreate: async (req, res) => {
    try {
      const {
        title,
        description,
        lock_code,
        order_number,
        timer,
        data_game,
        is_bonus,
        total_player,
      } = req.body

      const backgroundImageFile = req.files['background']
        ? req.files['background'][0]
        : null
      const objectiveImageFile = req.files['objective']
        ? req.files['objective'][0]
        : null
      const modelFile = req.files['model'] ? req.files['model'][0] : null

      if (!backgroundImageFile || !objectiveImageFile || !modelFile) {
        return res.status(422).json({
          error: 1,
          message: 'Background, objective, and model files are required.',
        })
      }

      if (!['image/jpeg', 'image/png'].includes(backgroundImageFile.mimetype)) {
        return res.status(422).json({
          error: 1,
          message:
            'Invalid background image type. Only JPEG and PNG images are allowed.',
        })
      }

      if (!['image/jpeg', 'image/png'].includes(objectiveImageFile.mimetype)) {
        return res.status(422).json({
          error: 1,
          message:
            'Invalid objective image type. Only JPEG and PNG images are allowed.',
        })
      }

      if (
        !['model/gltf-binary', 'model/gltf+json'].includes(modelFile.mimetype)
      ) {
        return res.status(422).json({
          error: 1,
          message: 'Invalid model type. Only FBX and OBJ models are allowed.',
        })
      }

      // Move background image to the destination folder
      const backgroundImagePath = path.resolve(
        config.rootPath,
        `public/uploads/stages/${
          backgroundImageFile.filename
        }.${backgroundImageFile.originalname.split('.').pop()}`
      )
      fs.renameSync(backgroundImageFile.path, backgroundImagePath)

      // Move objective image to the destination folder
      const objectiveImagePath = path.resolve(
        config.rootPath,
        `public/uploads/stages/${
          objectiveImageFile.filename
        }.${objectiveImageFile.originalname.split('.').pop()}`
      )
      fs.renameSync(objectiveImageFile.path, objectiveImagePath)

      // Move model to the destination folder
      const modelPath = path.resolve(
        config.rootPath,
        `public/uploads/stages/${modelFile.filename}.${modelFile.originalname
          .split('.')
          .pop()}`
      )
      fs.renameSync(modelFile.path, modelPath)

      // Save the filenames in the MongoDB document
      const stage = new Stage({
        background: `${
          backgroundImageFile.filename
        }.${backgroundImageFile.originalname.split('.').pop()}`,
        objective: `${
          objectiveImageFile.filename
        }.${objectiveImageFile.originalname.split('.').pop()}`,
        model: `${modelFile.filename}.${modelFile.originalname
          .split('.')
          .pop()}`,
        title,
        description,
        lock_code,
        order_number,
        timer,
        data_game,
        is_bonus,
        total_player,
      })

      await stage.save()

      res.status(201).json({
        message: 'Successfully create stage',
        status: 'success',
        data: stage,
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
      const {
        background,
        objective,
        model,
        title,
        description,
        lock_code,
        order_number,
        timer,
        data_game,
        is_bonus,
        total_player,
      } = req.body

      let backgroundImage = null
      let objectiveImage = null
      let modelFile = null

      if (req.files) {
        if (req.files['background']) {
          const backgroundImageFile = req.files['background'][0]

          if (
            !['image/jpeg', 'image/png'].includes(backgroundImageFile.mimetype)
          ) {
            return res.status(422).json({
              error: 1,
              message:
                'Invalid background image type. Only JPEG and PNG images are allowed.',
            })
          }

          const backgroundImagePath = path.resolve(
            config.rootPath,
            `public/uploads/stages/${
              backgroundImageFile.filename
            }.${backgroundImageFile.originalname.split('.').pop()}`
          )

          fs.renameSync(backgroundImageFile.path, backgroundImagePath)
          backgroundImage = `${
            backgroundImageFile.filename
          }.${backgroundImageFile.originalname.split('.').pop()}`
        }

        if (req.files['objective']) {
          const objectiveImageFile = req.files['objective'][0]

          if (
            !['image/jpeg', 'image/png'].includes(objectiveImageFile.mimetype)
          ) {
            return res.status(422).json({
              error: 1,
              message:
                'Invalid objective image type. Only JPEG and PNG images are allowed.',
            })
          }

          const objectiveImagePath = path.resolve(
            config.rootPath,
            `public/uploads/stages/${
              objectiveImageFile.filename
            }.${objectiveImageFile.originalname.split('.').pop()}`
          )

          fs.renameSync(objectiveImageFile.path, objectiveImagePath)
          objectiveImage = `${
            objectiveImageFile.filename
          }.${objectiveImageFile.originalname.split('.').pop()}`
        }

        if (req.files['model']) {
          const modelFileData = req.files['model'][0]

          if (
            !['model/gltf-binary', 'model/gltf+json'].includes(
              modelFileData.mimetype
            )
          ) {
            return res.status(422).json({
              error: 1,
              message:
                'Invalid model type. Only FBX and OBJ models are allowed.',
            })
          }

          const modelPath = path.resolve(
            config.rootPath,
            `public/uploads/stages/${
              modelFileData.filename
            }.${modelFileData.originalname.split('.').pop()}`
          )

          fs.renameSync(modelFileData.path, modelPath)
          modelFile = `${modelFileData.filename}.${modelFileData.originalname
            .split('.')
            .pop()}`
        }
      }

      const stage = await Stage.findById(id)
      if (!stage) {
        return res.status(404).json({ error: 1, message: 'Stage not found' })
      }

      stage.background = background || stage.background
      stage.objective = objective || stage.objective
      stage.model = model || stage.model
      stage.title = title || stage.title
      stage.description = description || stage.description
      stage.lock_code = lock_code || stage.lock_code
      stage.order_number = order_number || stage.order_number
      stage.timer = timer || stage.timer
      stage.data_game = data_game || stage.data_game
      stage.is_bonus = is_bonus || stage.is_bonus
      stage.total_player = total_player || stage.total_player

      // Update background image if provided
      if (backgroundImage) {
        fs.unlinkSync(
          path.resolve(
            config.rootPath,
            `public/uploads/stages/${stage.background}`
          )
        )
        stage.background = backgroundImage
      }

      // Update objective image if provided
      if (objectiveImage) {
        fs.unlinkSync(
          path.resolve(
            config.rootPath,
            `public/uploads/stages/${stage.objective}`
          )
        )
        stage.objective = objectiveImage
      }

      // Update model file if provided
      if (modelFile) {
        fs.unlinkSync(
          path.resolve(config.rootPath, `public/uploads/stages/${stage.model}`)
        )
        stage.model = modelFile
      }

      await stage.save()

      res.status(200).json({
        message: 'Successfully update stage',
        status: 'success',
        data: stage,
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

      const stage = await Stage.findOneAndRemove({
        _id: id,
      })

      // Delete background image if it exists
      if (stage.background) {
        const backgroundImage = path.resolve(
          config.rootPath,
          `public/uploads/stages/${stage.background}`
        )
        if (fs.existsSync(backgroundImage)) {
          fs.unlinkSync(backgroundImage)
        }
      }

      // Delete objective image if it exists
      if (stage.objective) {
        const objectiveImage = path.resolve(
          config.rootPath,
          `public/uploads/stages/${stage.objective}`
        )
        if (fs.existsSync(objectiveImage)) {
          fs.unlinkSync(objectiveImage)
        }
      }

      // Delete model file if it exists
      if (stage.model) {
        const modelFile = path.resolve(
          config.rootPath,
          `public/uploads/stages/${stage.model}`
        )
        if (fs.existsSync(modelFile)) {
          fs.unlinkSync(modelFile)
        }
      }

      res.status(410).json({
        message: 'Successfully delete stage',
        status: 'success',
        data: stage,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },
}
