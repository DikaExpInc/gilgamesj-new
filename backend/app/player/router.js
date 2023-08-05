var express = require('express')
var router = express.Router()
const { profile, getAll } = require('./controller')
const { isLoginPlayer, isLoginUser } = require('../middleware/auth')

router.get('/profile', isLoginPlayer, profile)
router.get('/all', isLoginUser, getAll)

module.exports = router
