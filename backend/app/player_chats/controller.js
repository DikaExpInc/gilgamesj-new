const ChatDetail = require("./model");
const Chat = require("../chat/model");

module.exports = {
  actionDelete: async (req, res) => {
    try {
      const { chatid, id } = req.params;

      const chatDetail = await ChatDetail.findOneAndRemove({
        _id: id,
      });

      await Chat.findByIdAndUpdate(chatid, {
        $pull: { detail_chat: id },
      });

      res.status(410).json({
        message: "Successfully delete chatDetail",
        status: "success",
        data: chatDetail,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  initChat: async (req, res) => {
    try {
      const { chatid } = req.params;

      const chat = await Chat.findOne({ _id: chatid });

      console.log(chat);

      if (!chat) {
        return res.status(404).json({
          message: "Chat not found",
          status: "failed",
        });
      }

      const newChat = new PlayerChat({
        order: initialChat.order,
        status: initialChat.status,
        title: initialChat.title,
        chat_id: chatid,
        created_at: new Date(),
      });

      // newChat.save();

      // await Player.findByIdAndUpdate(req.player._id, {
      //   $push: { player_chats: newChat },
      // });

      res.status(200).json({
        message: "Chat initialized successfully",
        status: "success",
        data: newChat,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  getAnswer: async (req, res) => {
    try {
      const { chatid, id } = req.params;
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  getChat: async (req, res) => {
    try {
      const { chatid } = req.params;
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  answerChat: async (req, res) => {
    try {
      const { chatid, id } = req.params;
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },
};
