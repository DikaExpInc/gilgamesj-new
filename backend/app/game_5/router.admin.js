var express = require('express')
var router = express.Router()
const { index, getById, actionVote, resetVote } = require('./controller')

const multer = require('multer')
const os = require('os')

const { isLoginAdmin } = require('../middleware/auth')

router.use(isLoginAdmin)
router.get('/', index)
router.get('/:id', getById)
router.put(
  '/vote/:id',
  multer({ dest: os.tmpdir() }).single('image'),
  actionVote
)
router.post('/reset', multer({ dest: os.tmpdir() }).single('image'), resetVote)

module.exports = router
