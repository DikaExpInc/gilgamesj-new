var express = require('express')
var router = express.Router()
const {
  index,
  getById,
  actionCreate,
  actionEdit,
  actionDelete,
  getBrowserByStage,
  getCameraByStage,
  getChatByStage,
  getChatDetailByStage,
  getContactByStage,
  getGalleryPhotoByStage,
  getGalleryVideoByStage,
  getMapByStage,
  getPhoneByStage,
  getSocialMediaByStage,
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
// get by id
router.get('/browser/get/bystage', isLoginPlayer, getBrowserByStage)
router.get('/camera/get/bystage', isLoginPlayer, getCameraByStage)
router.get('/chat/get/bystage', isLoginPlayer, getChatByStage)
router.get('/chatdetail/get/bystage', isLoginPlayer, getChatDetailByStage)
router.get('/contact/get/bystage', isLoginPlayer, getContactByStage)
router.get('/galleryphoto/get/bystage', isLoginPlayer, getGalleryPhotoByStage)
router.get('/galleryvideo/get/bystage', isLoginPlayer, getGalleryVideoByStage)
router.get('/map/get/bystage', isLoginPlayer, getMapByStage)
router.get('/phone/get/bystage', isLoginPlayer, getPhoneByStage)
router.get('/socialmedia/get/bystage', isLoginPlayer, getSocialMediaByStage)

module.exports = router
