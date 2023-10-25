var express = require('express')
var router = express.Router()
const {
  index,
  getById,
  actionCreate,
  actionEdit,
  actionDelete,
  actionLike,
} = require('./controller')

const multer = require('multer')
const os = require('os')
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'tmp/uploads')
  },
  filename: (req, file, cb) => {
    cb(null, file.fieldname + '-' + Date.now())
  },
})
const upload = multer({ dest: os.tmpdir(), storage: storage })

const { isLoginPlayer } = require('../middleware/auth')

// router.use(isLoginAdmin);
router.get('/', index)
router.get('/:id', getById)
router.post(
  '/create',
  upload.fields([
    { name: 'profile', maxCount: 1 },
    { name: 'post_image', maxCount: 1 },
  ]),
  actionCreate
)
router.put(
  '/edit/:id',
  upload.fields([
    { name: 'profile', maxCount: 1 },
    { name: 'post_image', maxCount: 1 },
  ]),
  actionEdit
)
router.put(
  '/like/:id',
  upload.fields([
    { name: 'profile', maxCount: 1 },
    { name: 'post_image', maxCount: 1 },
  ]),
  isLoginPlayer,
  actionLike
)
router.delete('/delete/:id', actionDelete)

module.exports = router