var express = require('express')
var router = express.Router()
const { signup, signinAdmin } = require('./controller')

router.post('/signup', signup)
router.post('/signin', signinAdmin)

module.exports = router
