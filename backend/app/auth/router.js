var express = require('express')
var router = express.Router()
const {
  signup,
  signin,
  addPlayer,
  changePlayer,
  getPlayers,
  changeNamePlayer,
  getSeats,
  getRowCol,
  updateIshtarCall,
  getAllPlayers,
} = require('./controller')
const { isLoginUser } = require('../middleware/auth')

router.post('/signup', signup)
router.post('/signin', signin)
router.post('/addplayer', isLoginUser, addPlayer)
router.post('/getplayer', isLoginUser, getPlayers)
router.post('/getSeats', isLoginUser, getSeats)
router.get('/getrowcol', getRowCol)
router.get('/randomishtar', updateIshtarCall)
router.put('/changeplayer', isLoginUser, changePlayer)
router.put('/changenameplayer', isLoginUser, changeNamePlayer)

module.exports = router
