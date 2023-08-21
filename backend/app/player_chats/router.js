var express = require("express");
var router = express.Router();
const {
  actionDelete,
  answerChat,
  getAnswer,
  initChat,
  getChat,
} = require("./controller");

const multer = require("multer");
const os = require("os");
const { isLoginPlayer } = require("../middleware/auth");

router.post(
  "/:chatid/initchat",
  multer({ dest: os.tmpdir() }).single("image"),
  isLoginPlayer,
  initChat
);
router.post(
  "/:chatid/:id/answerchat",
  multer({ dest: os.tmpdir() }).single("image"),
  isLoginPlayer,
  answerChat
);
router.get(
  "/:chatid/getanswer",
  multer({ dest: os.tmpdir() }).single("image"),
  isLoginPlayer,
  getAnswer
);
router.get(
  "/:chatid/getchat",
  multer({ dest: os.tmpdir() }).single("image"),
  isLoginPlayer,
  getChat
);
router.delete("/:chatid/delete/:id", actionDelete);

module.exports = router;
