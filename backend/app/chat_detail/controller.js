const ChatDetail = require("./model");
const path = require("path");
const fs = require("fs");
const config = require("../../config");

module.exports = {
  index: async (req, res) => {
    try {
      const chatDetail = await ChatDetail.find();
      res.status(200).json({
        data: chatDetail,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      });
    }
  },

  getById: async (req, res) => {
    const { id } = req.params;
    try {
      const chatDetail = await ChatDetail.findById(id);
      if (!chatDetail) {
        return res.status(404).json({ message: "Social Media not found" });
      }
      res.status(200).json({
        data: chatDetail,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      });
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { title, chat_family_id, chat_sibling_id, order, sender } =
        req.body;
      if (req.file) {
        if (!["image/jpeg", "image/png"].includes(req.file.mimetype)) {
          return res.status(422).json({
            error: 1,
            message: "Invalid file type. Only JPEG and PNG images are allowed.",
          });
        }

        let tmp_path = req.file.path;
        let originaExt =
          req.file.originaltitle.split(".")[
            req.file.originaltitle.split(".").length - 1
          ];
        let image = req.file.filetitle + "." + originaExt;
        let target_path = path.resolve(
          config.rootPath,
          `public/uploads/social-medias/${image}`
        );

        const src = fs.createReadStream(tmp_path);
        const dest = fs.createWriteStream(target_path);

        src.pipe(dest);

        src.on("end", async () => {
          try {
            let chatDetail = new ChatDetail({
              title: title,
              chat_family_id: chat_family_id,
              chat_sibling_id: chat_sibling_id,
              order: order,
              sender: sender,
              profile: image,
            });
            await chatDetail.save();

            res.status(201).json({
              message: "Successfully create social Media",
              status: "success",
              data: chatDetail,
            });
          } catch (err) {
            if (err && err.title === "ValidationError") {
              return res.status(422).json({
                error: 1,
                message: err.message,
                fields: err.errors,
              });
            }
          }
        });
      } else {
        let chatDetail = new ChatDetail({
          title: title,
          chat_family_id: chat_family_id,
          chat_sibling_id: chat_sibling_id,
          order: order,
          sender: sender,
        });
        await chatDetail.save();

        res.status(201).json({
          message: "Successfully create social media",
          status: "success",
          data: chatDetail,
        });
      }
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
      const { title, chat_family_id, chat_sibling_id, order, sender } =
        req.body;

      if (req.file) {
        let tmp_path = req.file.path;
        let originaExt =
          req.file.originaltitle.split(".")[
            req.file.originaltitle.split(".").length - 1
          ];
        let image = req.file.filetitle + "." + originaExt;
        let target_path = path.resolve(
          config.rootPath,
          `public/uploads/social-medias/${image}`
        );

        const src = fs.createReadStream(tmp_path);
        const dest = fs.createWriteStream(target_path);

        src.pipe(dest);

        src.on("end", async () => {
          try {
            const chatDetail = await ChatDetail.findOne({ _id: id });

            let currentImage = `${config.rootPath}/public/uploads/social-medias/${chatDetail.image}`;
            if (fs.existsSync(currentImage)) {
              fs.unlinkSync(currentImage);
            }

            await ChatDetail.findOneAndUpchat_sibling_id(
              {
                _id: id,
              },
              {
                title: title,
                chat_family_id: chat_family_id,
                chat_sibling_id: chat_sibling_id,
                order: order,
                sender: sender,
                profile: image,
              }
            );

            res.status(200).json({
              message: "Successfully upchat_sibling_id social media",
              status: "success",
              data: [],
            });
          } catch (err) {
            if (err && err.title === "ValidationError") {
              return res.status(422).json({
                error: 1,
                message: err.message,
                fields: err.errors,
              });
            }
          }
        });
      } else {
        const chatDetail = await ChatDetail.findOneAndUpchat_sibling_id(
          {
            _id: id,
          },
          {
            title: title,
            chat_family_id: chat_family_id,
            chat_sibling_id: chat_sibling_id,
            order: order,
            sender: sender,
          }
        );
        res.status(200).json({
          message: "Successfully upchat_sibling_id social media",
          status: "success",
          data: [],
        });
      }
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

      const chatDetail = await ChatDetail.findOneAndRemove({
        _id: id,
      });

      let currentImage = `${config.rootPath}/public/uploads/social-medias/${chatDetail.image}`;
      if (fs.existsSync(currentImage)) {
        fs.unlinkSync(currentImage);
      }

      res.status(410).json({
        message: "Successfully delete social media",
        status: "success",
        data: chatDetail,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      });
    }
  },
};
