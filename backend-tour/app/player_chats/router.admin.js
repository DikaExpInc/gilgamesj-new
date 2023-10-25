var express = require("express");
var router = express.Router();
const {
  actionDelete,
  initChat,
  answerChat,
  getAnswer,
  getChat,
} = require("./controller");

const multer = require("multer");
const os = require("os");

const { isLoginPlayer } = require("../middleware/auth");

router.post(
  "/:chatid/initChat",
  multer({ dest: os.tmpdir() }).single("image"),
  isLoginPlayer,
  initChat
);
router.post(
  "/:chatid/:id/answerChat",
  multer({ dest: os.tmpdir() }).single("image"),
  isLoginPlayer,
  answerChat
);
router.get(
  "/:chatid/getAnswer",
  multer({ dest: os.tmpdir() }).single("image"),
  isLoginPlayer,
  getAnswer
);
router.get(
  "/:chatid/getChat",
  multer({ dest: os.tmpdir() }).single("image"),
  isLoginPlayer,
  getChat
);
router.delete("/:chatid/delete/:id", actionDelete);

module.exports = router;
