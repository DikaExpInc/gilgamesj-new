const Stage = require("../stage/model");
const Player = require("../player/model");
const Task = require("./model");

module.exports = {
  // Get all tasks related to a stage
  getByStageId: async (req, res) => {
    const { id } = req.params;
    try {
      const stage = await Stage.findById(id).populate("tasks");
      if (!stage) {
        return res.status(404).json({ message: "Stage not found" });
      }
      res.status(200).json({
        data: stage.tasks,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  // Get all by players
  getByPlayerId: async (req, res) => {
    const { id } = req.params;
    try {
      const stage = await Stage.findById(id).populate("tasks");

      if (!stage) {
        return res.status(404).json({ message: "Stage not found" });
      }

      const player = await Player.findOne({ _id: req.player._id }).populate(
        "completes.taskId"
      );

      if (!player) {
        return res.status(404).json({ message: "Player not found" });
      }

      const completedTaskIds = player.completes.map((complete) =>
        complete.taskId._id.toString()
      );

      const tasksWithoutCompleted = stage.tasks.filter(
        (task) => !completedTaskIds.includes(task._id.toString())
      );

      res.status(200).json({
        data: tasksWithoutCompleted,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  getById: async (req, res) => {
    const { id, taskId } = req.params;
    try {
      const stage = await Stage.findById(id);
      if (!stage) {
        return res.status(404).json({ message: "Stage not found" });
      }

      const task = await Task.findById(taskId);
      if (!task) {
        return res.status(404).json({ message: "Task not found" });
      }

      res.status(200).json({
        data: task,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  // Create a new task for a stage
  actionCreate: async (req, res) => {
    const { id } = req.params;
    const { title, description, type, detail_id } = req.body;

    try {
      const stage = await Stage.findById(id);
      if (!stage) {
        return res.status(404).json({ message: "Stage not found" });
      }

      const task = new Task({
        title: title,
        description: description,
        stage_id: stage._id,
        type: type,
        detail_id: detail_id,
      });

      await task.save();

      // Add the task's ID to the stage's tasks array
      stage.tasks.push(task._id);
      await stage.save();

      res.status(201).json({
        message: "Successfully create task",
        status: "success",
        data: task,
      });
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      });
    }
  },

  // Edit an existing task
  actionEdit: async (req, res) => {
    const { id, taskId } = req.params;
    const { title, description, type, detail_id } = req.body;

    try {
      const stage = await Stage.findById(id);
      if (!stage) {
        return res.status(404).json({ message: "Stage not found" });
      }

      const task = await Task.findById(taskId);
      if (!task) {
        return res.status(404).json({ message: "Task not found" });
      }

      task.title = title;
      task.description = description;
      task.stage_id = stage._id;
      task.type = type;
      task.detail_id = detail_id;
      await task.save();

      res.status(200).json({
        message: "Successfully update task",
        status: "success",
        data: task,
      });
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      });
    }
  },

  // Delete a task
  actionDelete: async (req, res) => {
    const { id, taskId } = req.params;

    try {
      const stage = await Stage.findById(id);
      if (!stage) {
        return res.status(404).json({ message: "Stage not found" });
      }

      const task = await Task.findById(taskId);
      if (!task || task.stage.toString() !== id) {
        return res.status(404).json({ message: "Task not found" });
      }

      // Remove the task's ID from the stage's tasks array
      stage.tasks = stage.tasks.filter((task) => task.toString() !== taskId);
      await stage.save();

      await Task.findByIdAndRemove(taskId);

      res.status(410).json({
        message: "Successfully delete task",
        status: "success",
        data: task,
      });
    } catch (err) {
      res.status(500).json({
        message: err.message || "Internal server error",
      });
    }
  },

  // Change status to done
  actionDone: async (req, res) => {
    const { id, taskId } = req.params;

    try {
      const stage = await Stage.findById(id);
      if (!stage) {
        return res.status(404).json({ message: "Stage not found" });
      }

      const task = await Task.findById(taskId);
      if (!task) {
        return res.status(404).json({ message: "Task not found" });
      }

      await User.findByIdAndUpdate(req.user._id, {
        $push: { completes: task._id },
      });

      res.status(200).json({
        message: "Successfully update task",
        status: "success",
        data: task,
      });
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      });
    }
  },
};
