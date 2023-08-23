const ChatDetail = require("../chat_detail/model");
const PlayerChat = require("./model");
const Player = require("../player/model");
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

      if (!chat) {
        return res.status(404).json({
          message: "Chat not found",
          status: "failed",
        });
      }

      const chatDetails = await ChatDetail.find({ chat_id: chatid }).sort({
        order: 1,
      });

      if (chatDetails.length === 0) {
        return res.status(404).json({
          message: "No chat details found for this chat",
          status: "failed",
        });
      }

      const firstChatDetail = chatDetails[0];

      const existingPlayerChat = await PlayerChat.findOne({
        chat_id: chatid,
        status: firstChatDetail.status,
        order: firstChatDetail.order,
      });

      if (existingPlayerChat) {
        return res.status(200).json({
          message: "Chat has already been initialized for this player",
          status: "success",
          data: existingPlayerChat,
        });
      }

      const newChat = new PlayerChat({
        order: firstChatDetail.order,
        status: firstChatDetail.status,
        title: firstChatDetail.title,
        chat_id: chatid,
        player_id: req.player._id,
        created_at: new Date(),
      });

      if (firstChatDetail.status === "receiver") {
        await Player.findByIdAndUpdate(req.player._id, {
          $push: { player_chats: newChat },
        });

        newChat.save();
      }

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

  replyChat: async (req, res) => {
    try {
      const { chatid } = req.params;

      const chat = await Chat.findOne({ _id: chatid });

      if (!chat) {
        return res.status(404).json({
          message: "Chat not found",
          status: "failed",
        });
      }

      // Ambil data player_chats berdasarkan ID player
      const player = await Player.findById(req.player._id);

      if (!player) {
        return res.status(404).json({
          message: "Player not found",
          status: "failed",
        });
      }

      // Cari nilai order tertinggi dari semua player_chats
      let lastOrder = 0;
      for (const chat of player.player_chats) {
        const playerChat = await PlayerChat.findById(chat);
        if (playerChat.order > lastOrder) {
          lastOrder = playerChat.order;
        }
      }

      const chatDetails = await ChatDetail.find({
        order: lastOrder + 1,
        status: "sender",
      });

      if (chatDetails.length === 0) {
        return res.status(404).json({
          message: "No chat details found for this chat",
          status: "failed",
        });
      }

      chatDetails.map(async (arr, key) => {
        const existingPlayerChat = await PlayerChat.findOne({
          chat_id: chatid,
          status: arr.status,
          order: arr.order,
        });

        if (existingPlayerChat) {
          return res.status(200).json({
            message: "Chat has already been initialized for this player",
            status: "success",
            data: existingPlayerChat,
          });
        }
      });

      chatDetails.map(async (arr, key) => {
        const newChat = new PlayerChat({
          order: arr.order,
          status: arr.status,
          title: arr.title,
          chat_id: chatid,
          player_id: req.player._id,
          created_at: new Date(),
        });

        if (arr.status === "receiver") {
          await Player.findByIdAndUpdate(req.player._id, {
            $push: { player_chats: newChat },
          });

          newChat.save();
        }
      });

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
      const { chatId } = req.params;

      // Ambil koleksi chat dengan chatId
      const chatCollection = await Chat.findOne({ chat_id: chatId });

      if (!chatCollection) {
        return res.status(404).json({
          message: "Chat details not found",
          status: "failed",
        });
      }

      // Ambil data player_chats berdasarkan ID player
      const player = await Player.findById(req.player._id);

      if (!player) {
        return res.status(404).json({
          message: "Player not found",
          status: "failed",
        });
      }

      // Cari nilai order tertinggi dari semua player_chats
      let lastOrder = 0;
      for (const chat of player.player_chats) {
        const playerChat = await PlayerChat.findById(chat);
        if (playerChat.order > lastOrder) {
          lastOrder = playerChat.order;
        }
      }

      const answer = await ChatDetail.find({
        chat_id: chatCollection._id,
        order: lastOrder + 1,
        status: "sender",
      });

      console.log(chatCollection._id);

      res.status(200).json({
        message: "Fetched answer successfully",
        status: "success",
        data: answer,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  getChat: async (req, res) => {
    try {
      const { chatid } = req.params;

      const chatPlayer = await PlayerChat.find({
        chat_id: chatid,
        player_id: req.player._id,
      }).sort({
        order: 1,
      });

      res.status(200).json({
        message: "Fetched chat successfully",
        status: "success",
        data: chatPlayer,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  answerChat: async (req, res) => {
    try {
      const { chatid, id } = req.params;

      const chat = await Chat.findOne({ _id: chatid });

      if (!chat) {
        return res.status(404).json({
          message: "Chat not found",
          status: "failed",
        });
      }

      const chatAnswers = await ChatDetail.findOne({ _id: id });

      const newChat = new PlayerChat({
        order: chatAnswers.order,
        status: chatAnswers.status,
        title: chatAnswers.title,
        chat_id: chatid,
        player_id: req.player._id,
        created_at: new Date(),
      });

      await Player.findByIdAndUpdate(req.player._id, {
        $push: { player_chats: newChat },
      });

      newChat.save();

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
};
