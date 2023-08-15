const Stage = require('./model')
const Browser = require('../browser/model')
const Camera = require('../camera/model')
const Chat = require('../chat/model')
const ChatDetail = require('../chat_detail/model')
const Contact = require('../contact/model')
const GalleryPhoto = require('../gallery_photo/model')
const GalleryVideo = require('../gallery_video/model')
const Map = require('../map/model')
const Phone = require('../phone/model')
const SocialMedia = require('../social_media/model')
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

      if (!modelFile.originalname.endsWith('.glb')) {
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
        background: `uploads/stages/${
          backgroundImageFile.filename
        }.${backgroundImageFile.originalname.split('.').pop()}`,
        objective: `uploads/stages/${
          objectiveImageFile.filename
        }.${objectiveImageFile.originalname.split('.').pop()}`,
        model: `uploads/stages/${modelFile.filename}.${modelFile.originalname
          .split('.')
          .pop()}`,
        title,
        description,
        lock_code,
        order_number,
        timer,
        data_game,
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
          backgroundImage = `uploads/stages/${
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
          objectiveImage = `uploads/stages/${
            objectiveImageFile.filename
          }.${objectiveImageFile.originalname.split('.').pop()}`
        }

        if (req.files['model']) {
          const modelFileData = req.files['model'][0]

          if (!modelFileData.originalname.endsWith('.glb')) {
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
          modelFile = `uploads/stages/${
            modelFileData.filename
          }.${modelFileData.originalname.split('.').pop()}`
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
      stage.total_player = total_player || stage.total_player

      // Update background image if provided
      if (backgroundImage) {
        fs.unlinkSync(
          path.resolve(config.rootPath, `public/${stage.background}`)
        )
        stage.background = backgroundImage
      }

      // Update objective image if provided
      if (objectiveImage) {
        fs.unlinkSync(
          path.resolve(config.rootPath, `public/${stage.objective}`)
        )
        stage.objective = objectiveImage
      }

      // Update model file if provided
      if (modelFile) {
        fs.unlinkSync(path.resolve(config.rootPath, `public/${stage.model}`))
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

  // ===================================================
  // Browser
  getBrowserByStage: async (req, res) => {
    const { id } = req.params
    try {
      const stage = await Stage.findById(req.player.stage_id)
      const newsIds = stage.data_game.news

      const browsers = await Promise.all(
        newsIds.map(async (newsId) => {
          const browser = await Browser.findById(newsId)
          return browser
        })
      )

      if (!browsers.length) {
        return res.status(404).json({ message: 'Browsers not found' })
      }

      res.status(200).json({
        data: browsers,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  // Camera
  getCameraByStage: async (req, res) => {
    const { id } = req.params
    try {
      const stage = await Stage.findById(req.player.stage_id)
      const camerasIds = stage.data_game.cameras

      const cameras = await Promise.all(
        camerasIds.map(async (camerasId) => {
          const camera = await Camera.findById(camerasId)
          return camera
        })
      )

      if (!cameras.length) {
        return res.status(404).json({ message: 'Cameras not found' })
      }

      res.status(200).json({
        data: cameras,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  // Chat
  getChatByStage: async (req, res) => {
    const { id } = req.params
    try {
      const stage = await Stage.findById(req.player.stage_id)
      const chatsIds = stage.data_game.chats

      const chats = await Promise.all(
        chatsIds.map(async (chatsId) => {
          const chat = await Chat.findById(chatsId)
          return chat
        })
      )

      if (!chats.length) {
        return res.status(404).json({ message: 'Chats not found' })
      }

      res.status(200).json({
        data: chats,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  // ChatDetail
  getChatDetailByStage: async (req, res) => {
    const { id } = req.params
    try {
      const stage = await Stage.findById(req.player.stage_id)
      const chatsIds = stage.data_game.chats

      const chats = await Promise.all(
        chatsIds.map(async (chatsId) => {
          const chat = await ChatDetail.findById(chatsId)
          return chat
        })
      )

      if (!chats.length) {
        return res.status(404).json({ message: 'Chat details not found' })
      }

      res.status(200).json({
        data: chats,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  // Contact
  getContactByStage: async (req, res) => {
    const { id } = req.params
    try {
      const stage = await Stage.findById(req.player.stage_id)
      const contactsIds = stage.data_game.contacts

      const contacts = await Promise.all(
        contactsIds.map(async (contactsId) => {
          const contact = await Contact.findById(contactsId)
          return contact
        })
      )

      if (!contacts.length) {
        return res.status(404).json({ message: 'Contacts not found' })
      }

      res.status(200).json({
        data: contacts,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  // GalleryPhoto
  getGalleryPhotoByStage: async (req, res) => {
    const { id } = req.params
    try {
      const stage = await Stage.findById(req.player.stage_id)
      const galleryPhotosIds = stage.data_game.galleryPhotos

      const galleryPhotos = await Promise.all(
        galleryPhotosIds.map(async (galleryPhotosId) => {
          const galleryPhoto = await GalleryPhoto.findById(galleryPhotosId)
          return galleryPhoto
        })
      )

      if (!galleryPhotos.length) {
        return res.status(404).json({ message: 'GalleryPhotos not found' })
      }

      res.status(200).json({
        data: galleryPhotos,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  // GalleryVideo
  getGalleryVideoByStage: async (req, res) => {
    const { id } = req.params
    try {
      const stage = await Stage.findById(req.player.stage_id)
      const galleryVideosIds = stage.data_game.galleryVideos

      const galleryVideos = await Promise.all(
        galleryVideosIds.map(async (galleryVideosId) => {
          const galleryVideo = await GalleryVideo.findById(galleryVideosId)
          return galleryVideo
        })
      )

      if (!galleryVideos.length) {
        return res.status(404).json({ message: 'GalleryVideos not found' })
      }

      res.status(200).json({
        data: galleryVideos,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  // Map
  getMapByStage: async (req, res) => {
    const { id } = req.params
    try {
      const stage = await Stage.findById(req.player.stage_id)
      const mapsIds = stage.data_game.maps

      const maps = await Promise.all(
        mapsIds.map(async (mapsId) => {
          const map = await Map.findById(mapsId)
          return map
        })
      )

      if (!maps.length) {
        return res.status(404).json({ message: 'Maps not found' })
      }

      res.status(200).json({
        data: maps,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  // Phone
  getPhoneByStage: async (req, res) => {
    const { id } = req.params
    try {
      const stage = await Stage.findById(req.player.stage_id)
      const phonesIds = stage.data_game.phones

      const phones = await Promise.all(
        phonesIds.phone(async (phonesId) => {
          const phone = await Phone.findById(phonesId)
          return phone
        })
      )

      if (!phones.length) {
        return res.status(404).json({ message: 'Phones not found' })
      }

      res.status(200).json({
        data: phones,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  // SocialMedia
  getSocialMediaByStage: async (req, res) => {
    const { id } = req.params
    try {
      const stage = await Stage.findById(req.player.stage_id)
      const socialMediasIds = stage.data_game.socialMedias

      const socialMedias = await Promise.all(
        socialMediasIds.socialMedia(async (socialMediasId) => {
          const socialMedia = await SocialMedia.findById(socialMediasId)
          return socialMedia
        })
      )

      if (!socialMedias.length) {
        return res.status(404).json({ message: 'SocialMedias not found' })
      }

      res.status(200).json({
        data: socialMedias,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },
}
