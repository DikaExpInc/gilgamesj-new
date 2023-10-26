var express = require('express')
var router = express.Router()
const {
  index,
  getById,
  actionCreate,
  actionEdit,
  actionDelete,
  getTheaterSeatsRowCol,
} = require('./controller')

const multer = require('multer')
const os = require('os')

router.get('/', index)
router.get('/:id', getById)
router.post(
  '/seat',
  multer({ dest: os.tmpdir() }).single('image'),
  getTheaterSeatsRowCol
)
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
