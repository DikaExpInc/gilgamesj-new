const Notification = require("./model");

module.exports = {
  index: async (req, res) => {
    try {
      const notification = await Notification.find();
      res.status(200).json({
        data: notification,
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
      const notification = await Notification.findById(id);
      if (!notification) {
        return res.status(404).json({ message: "Notification not found" });
      }
      res.status(200).json({
        data: notification,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || `Internal server error`,
      });
    }
  },

  actionCreate: async (req, res) => {
    try {
      const { description, name } = req.body;

      let notification = new Notification({
        description: description,
        name: name,
      });

      await notification.save();

      res.status(201).json({
        message: "Successfully create notification",
        status: "success",
        data: notification,
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
      const { description, name } = req.body;

      await Notification.findOneAndUpdate(
        {
          _id: id,
        },
        {
          description: description,
          name: name,
        }
      );
      res.status(200).json({
        message: "Successfully update notification",
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

      await Notification.findOneAndRemove({
        _id: id,
      });

      res.status(410).json({
        message: "Successfully delete notification",
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
