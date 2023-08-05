const Player = require("./model");
const path = require("path");
const fs = require("fs");
const config = require("../../config");

module.exports = {
  profile: async (req, res) => {
    try {
      const player = {
        id: req.player._id,
        username: req.player.username,
        email: req.player.email,
        name: req.player.name,
        avatar: req.player.avatar,
        phone_number: req.player.phoneNumber,
      };

      res.status(200).json({ data: player });
    } catch (err) {
      res.status(500).json({ message: err.message || `Internal server error` });
    }
  },

  editProfile: async (req, res, next) => {
    try {
      const { name = "", phoneNumber = "" } = req.body;

      const payload = {};

      if (name.length) payload.name = name;
      if (phoneNumber.length) payload.phoneNumber = phoneNumber;

      if (req.file) {
        let tmp_path = req.file.path;
        let originaExt =
          req.file.originalname.split(".")[
            req.file.originalname.split(".").length - 1
          ];
        let filename = req.file.filename + "." + originaExt;
        let target_path = path.resolve(
          config.rootPath,
          `public/uploads/${filename}`
        );

        const src = fs.createReadStream(tmp_path);
        const dest = fs.createWriteStream(target_path);

        src.pipe(dest);

        src.on("end", async () => {
          let player = await Player.findOne({ _id: req.player._id });

          let currentImage = `${config.rootPath}/public/uploads/${player.avatar}`;
          if (fs.existsSync(currentImage)) {
            fs.unlinkSync(currentImage);
          }

          player = await Player.findOneAndUpdate(
            {
              _id: req.player._id,
            },
            {
              ...payload,
              avatar: filename,
            },
            { new: true, runValidators: true }
          );

          console.log(player);

          res.status(201).json({
            data: {
              id: player.id,
              name: player.name,
              phoneNumber: player.phoneNumber,
              avatar: player.avatar,
            },
          });
        });

        src.on("err", async () => {
          next(err);
        });
      } else {
        const player = await Player.findOneAndUpdate(
          {
            _id: req.player._id,
          },
          payload,
          { new: true, runValidators: true }
        );

        res.status(201).json({
          data: {
            id: player.id,
            name: player.name,
            phoneNumber: player.phoneNumber,
            avatar: player.avatar,
          },
        });
      }
    } catch (err) {
      if (err && err.name === "ValidationError") {
        res.status(422).json({
          error: 1,
          message: err.message,
          fields: err.errors,
        });
      }
    }
  },
};
