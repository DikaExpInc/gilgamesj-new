var express = require('express')
var router = express.Router()
const {
  index,
  getById,
  actionCreate,
  actionEdit,
  actionDelete,
  getBrowserByStage,
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

router.get('/', index)
router.get('/:id', getById)
router.post(
  '/create',
  upload.fields([
    { name: 'background', maxCount: 1 },
    { name: 'objective', maxCount: 1 },
    { name: 'model', maxCount: 1 },
  ]),
  actionCreate
)
router.put(
  '/edit/:id',
  upload.fields([
    { name: 'background', maxCount: 1 },
    { name: 'objective', maxCount: 1 },
    { name: 'model', maxCount: 1 },
  ]),
  actionEdit
)
router.delete('/delete/:id', actionDelete)
// browser
router.get('/browser/get/bystage', isLoginPlayer, getBrowserByStage)

module.exports = router
