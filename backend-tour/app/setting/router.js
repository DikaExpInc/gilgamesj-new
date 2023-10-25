var express = require('express')
var router = express.Router()
const {
  index,
  getById,
  actionCreate,
  actionEdit,
  actionDelete,
  actionAddNotification,
} = require('./controller')

const multer = require('multer')
const os = require('os')

const { isLoginAdmin } = require('../middleware/auth')

// router.use(isLoginAdmin);
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
router.put(
  '/shownotification/:id',
  multer({ dest: os.tmpdir() }).single('image'),
  actionAddNotification
)
router.delete('/delete/:id', actionDelete)

module.exports = router
