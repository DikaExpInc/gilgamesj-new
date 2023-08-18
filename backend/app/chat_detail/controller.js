const ChatDetail = require('./model')
const Chat = require('../chat/model')

module.exports = {
  index: async (req, res) => {
    try {
      const chatDetails = await ChatDetail.find()
      res.status(200).json({
        data: chatDetails,
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
      const chatDetail = await ChatDetail.findById(id)
      if (!chatDetail) {
        return res.status(404).json({ message: 'ChatDetail not found' })
      }
      res.status(200).json({
        data: chatDetail,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  actionCreate: async (req, res) => {
    const { chatid } = req.params
    try {
      const { chat_family_id, chat_sibling_id, order, sender, status, title } =
        req.body

      // Save the profile filename in the MongoDB document
      const chatDetail = new ChatDetail({
        chat_family_id: chat_family_id,
        chat_sibling_id: chat_sibling_id,
        order: order,
        sender: sender,
        status: status,
        title: title,
      })

      await chatDetail.save()

      console.log(req.params)

      await Chat.findByIdAndUpdate(chatid, {
        $push: { detail_chat: chatDetail._id },
      })

      res.status(201).json({
        message: 'Successfully create chatDetail',
        status: 'success',
        data: chatDetail,
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
      const { chat_family_id, chat_sibling_id, order, sender, status, title } =
        req.body

      const chatDetail = await ChatDetail.findById(id)
      if (!chatDetail) {
        return res
          .status(404)
          .json({ error: 1, message: 'ChatDetail not found' })
      }

      chatDetail.chat_family_id = chat_family_id
      chatDetail.chat_sibling_id = chat_sibling_id
      chatDetail.order = order
      chatDetail.sender = sender
      chatDetail.status = status
      chatDetail.title = title

      await chatDetail.save()

      res.status(200).json({
        message: 'Successfully update chat Detail',
        status: 'success',
        data: chatDetail,
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
      const { chatid, id } = req.params

      const chatDetail = await ChatDetail.findOneAndRemove({
        _id: id,
      })

      await Chat.findByIdAndUpdate(chatid, {
        $pull: { detail_chat: id },
      })

      res.status(410).json({
        message: 'Successfully delete chatDetail',
        status: 'success',
        data: chatDetail,
      })
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  initChat: async (req, res) => {
    try {
      const { chatid, id } = req.params
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  getAnswer: async (req, res) => {
    try {
      const { chatid, id } = req.params
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },

  answerChat: async (req, res) => {
    try {
      const { chatid, id } = req.params
    } catch (err) {
      res.status(500).json({
        message: err.message || 'Internal server error',
      })
    }
  },
}
