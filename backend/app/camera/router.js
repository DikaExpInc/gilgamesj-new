var express = require("express");
var router = express.Router();
const {
  index,
  getById,
  actionCreate,
  actionEdit,
  actionDelete,
} = require("./controller");

const { isLoginAdmin } = require("../middleware/auth");

// router.use(isLoginAdmin);
router.get("/", index);
router.get("/:id", getById);
router.post("/create", actionCreate);
router.put("/edit/:id", actionEdit);
router.delete("/delete/:id", actionDelete);

module.exports = router;
