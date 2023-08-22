const PreGame = require("./model");
// const Camera = require("../camera/model");
// const Chat = require("../chat/model");
// const ChatDetail = require("../chat_detail/model");
const path = require("path");
const fs = require("fs");
const config = require("../../config");

module.exports = {
  index: async (req, res) => {
    try {
      const preGames = await PreGame.find();
      res.status(200).json({
        data: preGames,
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
      const preGame = await PreGame.findById(id);
      if (!preGame) {
        return res.status(404).json({ message: "PreGame not found" });
      }
      res.status(200).json({
        data: preGame,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { title, description, order_number, chat_id, camera_id } = req.body;

      const iconFile = req.files["icon "] ? req.files["icon"][0] : null;

      if (!iconFile) {
        return res.status(422).json({
          error: 1,
          message: "Icon files are required.",
        });
      }

      if (!["image/jpeg", "image/png"].includes(iconFile.mimetype)) {
        return res.status(422).json({
          error: 1,
          message:
            "Invalid icon image type. Only JPEG and PNG images are allowed.",
        });
      }

      // Move icon image to the destination folder
      const iconPath = path.resolve(
        config.rootPath,
        `public/uploads/pregame/${iconFile.filename}.${iconFile.originalname
          .split(".")
          .pop()}`
      );
      fs.renameSync(iconFile.path, iconPath);

      // Save the filenames in the MongoDB document
      const preGame = new PreGame({
        icon: `uploads/pregame/${iconFile.filename}.${iconFile.originalname
          .split(".")
          .pop()}`,
        title,
        description,
        order_number,
        chat_id,
        camera_id,
      });

      await preGame.save();

      res.status(201).json({
        message: "Successfully create preGame",
        status: "success",
        data: preGame,
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
      const { title, description, order_number, chat_id, camera_id } = req.body;

      let icon = null;

      if (req.files) {
        if (req.files["icon"]) {
          const iconFile = req.files["icon"][0];

          if (!["image/jpeg", "image/png"].includes(iconFile.mimetype)) {
            return res.status(422).json({
              error: 1,
              message:
                "Invalid icon image type. Only JPEG and PNG images are allowed.",
            });
          }

          const iconPath = path.resolve(
            config.rootPath,
            `public/uploads/pregame/${iconFile.filename}.${iconFile.originalname
              .split(".")
              .pop()}`
          );

          fs.renameSync(iconFile.path, iconPath);
          icon = `uploads/pregame/${iconFile.filename}.${iconFile.originalname
            .split(".")
            .pop()}`;
        }
      }

      const preGame = await PreGame.findById(id);
      if (!preGame) {
        return res
          .status(404)
          .json({ error: 1, message: "Pre Game not found" });
      }

      preGame.icon = icon || preGame.icon;
      preGame.title = title || preGame.title;
      preGame.description = description || preGame.description;
      preGame.order_number = order_number || preGame.order_number;
      preGame.chat_id = chat_id || preGame.chat_id;
      preGame.camera_id = camera_id || preGame.camera_id;

      // Update icon image if provided
      if (icon) {
        fs.unlinkSync(path.resolve(config.rootPath, `public/${preGame.icon}`));
        preGame.icon = icon;
      }

      await preGame.save();

      res.status(200).json({
        message: "Successfully update preGame",
        status: "success",
        data: preGame,
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

      const preGame = await PreGame.findOneAndRemove({
        _id: id,
      });

      // Delete icon image if it exists
      if (preGame.icon) {
        const icon = path.resolve(
          config.rootPath,
          `public/uploads/pregame/${preGame.icon}`
        );
        if (fs.existsSync(icon)) {
          fs.unlinkSync(icon);
        }
      }

      res.status(410).json({
        message: "Successfully delete pre Game",
        status: "success",
        data: preGame,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },
};
