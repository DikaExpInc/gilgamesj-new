var express = require("express");
var router = express.Router();
const {
  index,
  getById,
  actionCreate,
  actionEdit,
  actionDelete,
} = require("./controller");

const multer = require("multer");
const os = require("os");
const { isLoginPlayer } = require("../middleware/auth");

router.get("/:chatid/", index);
router.get("/:chatid/:id", getById);
router.post(
  "/:chatid/create",
  multer({ dest: os.tmpdir() }).single("image"),
  actionCreate
);
router.put(
  "/:chatid/edit/:id",
  multer({ dest: os.tmpdir() }).single("image"),
  actionEdit
);
router.delete("/:chatid/delete/:id", actionDelete);

module.exports = router;
