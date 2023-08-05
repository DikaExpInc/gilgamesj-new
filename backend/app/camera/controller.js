const Camera = require("./model");

module.exports = {
  index: async (req, res) => {
    try {
      const camera = await Camera.find();
      res.status(200).json({
        data: camera,
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
      const camera = await Camera.findById(id);
      if (!camera) {
        return res.status(404).json({ message: "Camera not found" });
      }
      res.status(200).json({
        data: camera,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      });
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { code, name } = req.body;

      let camera = new Camera({
        code: code,
        name: name,
      });

      await camera.save();

      res.status(201).json({
        message: "Successfully create camera",
        status: "success",
        data: camera,
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
      const { code, name } = req.body;

      await Camera.findOneAndUpdate(
        {
          _id: id,
        },
        {
          code: code,
          name: name,
        }
      );
      res.status(200).json({
        message: "Successfully update camera",
        status: "success",
        data: [],
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

      await Camera.findOneAndRemove({
        _id: id,
      });

      res.status(410).json({
        message: "Successfully delete camera",
        status: "success",
        data: [],
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      });
    }
  },
};
