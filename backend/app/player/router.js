var express = require('express')
var router = express.Router()
const { profile } = require('./controller')
const { isLoginPlayer } = require('../middleware/auth')

router.get('/profile', isLoginPlayer, profile)

module.exports = router
