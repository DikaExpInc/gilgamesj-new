var express = require('express')
var router = express.Router()
const { actionLogout, profile, getAll, getAllPlayer } = require('./controller')
const { isLoginUser } = require('../middleware/auth')

router.get('/all', isLoginUser, getAll)
router.get('/player', isLoginUser, getAllPlayer)
router.get('/profile', isLoginUser, profile)
router.get('/logout', actionLogout)
module.exports = router
