var express = require('express')
var router = express.Router()
const {
  signup,
  signin,
  addPlayer,
  changePlayer,
  getPlayers,
} = require('./controller')
const { isLoginUser } = require('../middleware/auth')

router.post('/signup', signup)
router.post('/signin', signin)
router.post('/addplayer', isLoginUser, addPlayer)
router.post('/getplayer', isLoginUser, getPlayers)
router.post('/changeplayer', isLoginUser, changePlayer)

module.exports = router
