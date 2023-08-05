const GalleryPhoto = require("./model");
const path = require("path");
const fs = require("fs");
const config = require("../../config");

module.exports = {
  index: async (req, res) => {
    try {
      const galleryPhoto = await GalleryPhoto.find();
      res.status(200).json({
        data: galleryPhoto,
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
      const galleryPhoto = await GalleryPhoto.findById(id);
      if (!galleryPhoto) {
        return res.status(404).json({ message: "GalleryPhoto not found" });
      }
      res.status(200).json({
        data: galleryPhoto,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      });
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { title, date } = req.body;
      if (req.file) {
        if (!["image/jpeg", "image/png"].includes(req.file.mimetype)) {
          return res.status(422).json({
            error: 1,
            message: "Invalid file type. Only JPEG and PNG images are allowed.",
          });
        }

        let tmp_path = req.file.path;
        let originaExt =
          req.file.originalname.split(".")[
            req.file.originalname.split(".").length - 1
          ];
        let image = req.file.filename + "." + originaExt;
        let target_path = path.resolve(
          config.rootPath,
          `public/uploads/gallery-photos/${image}`
        );

        const src = fs.createReadStream(tmp_path);
        const dest = fs.createWriteStream(target_path);

        src.pipe(dest);

        src.on("end", async () => {
          try {
            let galleryPhoto = new GalleryPhoto({
              title: title,
              date: date,
              image: image,
            });
            await galleryPhoto.save();

            res.status(201).json({
              message: "Successfully create galleryPhoto",
              status: "success",
              data: galleryPhoto,
            });
          } catch (err) {
            if (err && err.name === "ValidationError") {
              return res.status(422).json({
                error: 1,
                message: err.message,
                fields: err.errors,
              });
            }
          }
        });
      } else {
        let galleryPhoto = new GalleryPhoto({
          title: title,
          date: date,
        });
        await galleryPhoto.save();

        res.status(201).json({
          message: "Successfully create galleryPhoto",
          status: "success",
          data: galleryPhoto,
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
      const { title, date } = req.body;

      if (req.file) {
        if (!["image/jpeg", "image/png"].includes(req.file.mimetype)) {
          return res.status(422).json({
            error: 1,
            message: "Invalid file type. Only JPEG and PNG images are allowed.",
          });
        }
        let tmp_path = req.file.path;
        let originaExt =
          req.file.originalname.split(".")[
            req.file.originalname.split(".").length - 1
          ];
        let image = req.file.filename + "." + originaExt;
        let target_path = path.resolve(
          config.rootPath,
          `public/uploads/gallery-photos/${image}`
        );

        const src = fs.createReadStream(tmp_path);
        const dest = fs.createWriteStream(target_path);

        src.pipe(dest);

        src.on("end", async () => {
          try {
            const galleryPhoto = await GalleryPhoto.findOne({ _id: id });

            let currentImage = `${config.rootPath}/public/uploads/gallery-photos/${galleryPhoto.image}`;
            if (fs.existsSync(currentImage)) {
              fs.unlinkSync(currentImage);
            }

            await GalleryPhoto.findOneAndUpdate(
              {
                _id: id,
              },
              {
                title: title,
                date: date,
                image: image,
              }
            );

            res.status(200).json({
              message: "Successfully update galleryPhoto",
              status: "success",
              data: [],
            });
          } catch (err) {
            if (err && err.name === "ValidationError") {
              return res.status(422).json({
                error: 1,
                message: err.message,
                fields: err.errors,
              });
            }
          }
        });
      } else {
        await GalleryPhoto.findOneAndUpdate(
          {
            _id: id,
          },
          {
            title: title,
            date: date,
          }
        );
        res.status(200).json({
          message: "Successfully update galleryPhoto",
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

      const galleryPhoto = await GalleryPhoto.findOneAndRemove({
        _id: id,
      });

      let currentImage = `${config.rootPath}/public/uploads/gallery-photos/${galleryPhoto.image}`;
      if (fs.existsSync(currentImage)) {
        fs.unlinkSync(currentImage);
      }

      res.status(410).json({
        message: "Successfully delete galleryPhoto",
        status: "success",
        data: galleryPhoto,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      });
    }
  },
};
