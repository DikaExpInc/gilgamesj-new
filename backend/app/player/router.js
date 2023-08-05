var express = require("express");
var router = express.Router();
const { editProfile, profile } = require("./controller");
const { isLoginPlayer } = require("../middleware/auth");
const multer = require("multer");
const os = require("os");

router.get("/profile", isLoginPlayer, profile);
router.put(
  "/profile",
  isLoginPlayer,
  multer({ dest: os.tmpdir() }).single("image"),
  editProfile
);

module.exports = router;
