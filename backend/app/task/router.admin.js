var express = require("express");
var router = express.Router();
const {
  getByStageId,
  getById,
  actionCreate,
  actionEdit,
  actionDelete,
} = require("./controller");

const multer = require("multer");
const os = require("os");

const { isLoginAdmin } = require("../middleware/auth");

// router.use(isLoginAdmin);
router.get("/:id", getByStageId);
router.get("/:id/find/:taskId", getById);
router.post(
  "/:id/create",
  multer({ dest: os.tmpdir() }).single("image"),
  actionCreate
);
router.put(
  "/:id/edit/:taskId",
  multer({ dest: os.tmpdir() }).single("image"),
  actionEdit
);
router.delete("/:id/delete/:taskId", actionDelete);

module.exports = router;
