var express = require('express')
var router = express.Router()
const { actionLogout } = require('./controller')

router.get('/logout', actionLogout)
module.exports = router
