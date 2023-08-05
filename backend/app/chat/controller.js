const Chat = require("./model");
const path = require("path");
const fs = require("fs");
const config = require("../../config");

module.exports = {
  index: async (req, res) => {
    try {
      const chats = await Chat.find();
      res.status(200).json({
        data: chats,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  getById: async (req, res) => {
    const { id } = req.params;
    try {
      const chat = await Chat.findById(id);
      if (!chat) {
        return res.status(404).json({ message: "Chat not found" });
      }
      res.status(200).json({
        data: chat,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { name, contact_number } = req.body;
      const profileImageFile = req.file;

      if (!profileImageFile) {
        return res.status(422).json({
          error: 1,
          message: "Profile image is required.",
        });
      }

      if (!["image/jpeg", "image/png"].includes(profileImageFile.mimetype)) {
        return res.status(422).json({
          error: 1,
          message:
            "Invalid profile image type. Only JPEG and PNG images are allowed.",
        });
      }

      // Move profile image to the destination folder
      const profileImagePath = path.resolve(
        config.rootPath,
        `public/uploads/chats/${
          profileImageFile.filename
        }.${profileImageFile.originalname.split(".").pop()}`
      );
      fs.renameSync(profileImageFile.path, profileImagePath);

      // Save the profile filename in the MongoDB document
      const chat = new Chat({
        name: name,
        contact_number: contact_number,
        profile: `${profileImageFile.filename}.${profileImageFile.originalname
          .split(".")
          .pop()}`,
      });

      await chat.save();

      res.status(201).json({
        message: "Successfully create chat",
        status: "success",
        data: chat,
      });
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      });
    }
  },

  actionEdit: async (req, res) => {
    try {
      const { id } = req.params;
      const { name, contact_number } = req.body;
      const profileImageFile = req.file;

      let profileImage = null;

      if (profileImageFile) {
        if (!["image/jpeg", "image/png"].includes(profileImageFile.mimetype)) {
          return res.status(422).json({
            error: 1,
            message:
              "Invalid profile image type. Only JPEG and PNG images are allowed.",
          });
        }

        // Move profile image to the destination folder
        const profileImagePath = path.resolve(
          config.rootPath,
          `public/uploads/chats/${
            profileImageFile.filename
          }.${profileImageFile.originalname.split(".").pop()}`
        );
        fs.renameSync(profileImageFile.path, profileImagePath);

        profileImage = `${
          profileImageFile.filename
        }.${profileImageFile.originalname.split(".").pop()}`;
      }

      const chat = await Chat.findById(id);
      if (!chat) {
        return res.status(404).json({ error: 1, message: "Chat not found" });
      }

      chat.name = name;
      chat.contact_number = contact_number;

      // Update profile image if provided
      if (profileImage) {
        fs.unlinkSync(
          path.resolve(config.rootPath, `public/uploads/chats/${chat.profile}`)
        );
        chat.profile = profileImage;
      }

      await chat.save();

      res.status(200).json({
        message: "Successfully update chat",
        status: "success",
        data: chat,
      });
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      });
    }
  },

  actionDelete: async (req, res) => {
    try {
      const { id } = req.params;

      const chat = await Chat.findOneAndRemove({
        _id: id,
      });

      // Delete profile image if it exists
      if (chat.profile) {
        let profileImage = `${config.rootPath}/public/uploads/chats/${chat.profile}`;
        if (fs.existsSync(profileImage)) {
          fs.unlinkSync(profileImage);
        }
      }

      res.status(410).json({
        message: "Successfully delete chat",
        status: "success",
        data: chat,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },
};
