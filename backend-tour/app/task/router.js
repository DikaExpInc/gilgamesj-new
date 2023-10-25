var express = require('express')
var router = express.Router()
const {
  getByStageId,
  actionCreate,
  actionEdit,
  actionDelete,
  actionDone,
  getByPlayerId,
  getById,
} = require('./controller')

const multer = require('multer')
const os = require('os')

const { isLoginPlayer } = require('../middleware/auth')

router.get('/:id', getByStageId)
router.get('/:id/findplayer', isLoginPlayer, getByPlayerId)
router.get('/:id/find/:taskId', getById)
router.get('/:id/done/:taskId', isLoginPlayer, actionDone)
router.post(
  '/:id/create',
  multer({ dest: os.tmpdir() }).single('image'),
  actionCreate
)
router.put(
  '/:id/edit/:taskId',
  multer({ dest: os.tmpdir() }).single('image'),
  actionEdit
)
router.delete('/:id/delete/:taskId', actionDelete)

module.exports = router
