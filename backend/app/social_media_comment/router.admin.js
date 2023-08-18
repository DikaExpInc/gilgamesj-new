var express = require('express')
var router = express.Router()
const {
  index,
  getById,
  actionCreate,
  actionEdit,
  actionDelete,
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

const { isLoginUser } = require('../middleware/auth')

router.use(isLoginUser)
router.get('/:sosmedid/', index)
router.get('/:sosmedid/:id', getById)
router.post(
  '/:sosmedid/create',
  upload.fields([
    { name: 'profile', maxCount: 1 },
    { name: 'post_image', maxCount: 1 },
  ]),
  actionCreate
)
router.put(
  '/:sosmedid/edit/:id',
  upload.fields([
    { name: 'profile', maxCount: 1 },
    { name: 'post_image', maxCount: 1 },
  ]),
  actionEdit
)
router.delete('/:sosmedid/delete/:id', actionDelete)

module.exports = router
