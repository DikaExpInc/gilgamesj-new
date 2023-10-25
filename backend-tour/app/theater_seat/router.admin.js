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
router.get('/:idTheater/', index)
router.get('/:idTheater/:id', getById)
router.post(
  '/:idTheater/create',
  multer({ dest: os.tmpdir() }).single('image'),
  actionCreate
)
router.put(
  '/:idTheater/edit/:id',
  multer({ dest: os.tmpdir() }).single('image'),
  actionEdit
)
router.delete('/:idTheater/delete/:id', actionDelete)

module.exports = router
