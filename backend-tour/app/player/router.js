var express = require('express')
var router = express.Router()
const {
  profile,
  getAll,
  checkAvailableBonus,
  getAllByUser,
} = require('./controller')
const { isLoginPlayer, isLoginUser } = require('../middleware/auth')

router.get('/profile', isLoginPlayer, profile)
router.get('/all', isLoginUser, getAll)
router.get('/all/byuser', isLoginUser, getAllByUser)
router.get('/availablebonus', isLoginPlayer, checkAvailableBonus)

module.exports = router
