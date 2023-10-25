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

const { isLoginUser } = require('../middleware/auth')

router.use(isLoginUser)
router.get('/', index)
router.get('/:id', getById)
router.post(
  '/create',
  multer({ dest: os.tmpdir() }).single('image'),
  actionCreate
)
router.put(
  '/edit/:id',
  multer({ dest: os.tmpdir() }).single('image'),
  actionEdit
)
router.delete('/delete/:id', actionDelete)

module.exports = router
