var express = require('express')
var router = express.Router()
const { index, getById, actionVote } = require('./controller')

const multer = require('multer')
const os = require('os')

const { isLoginUser } = require('../middleware/auth')

router.use(isLoginUser)
router.get('/', index)
router.get('/:id', getById)
router.put(
  '/vote/:id',
  multer({ dest: os.tmpdir() }).single('image'),
  actionVote
)

module.exports = router
