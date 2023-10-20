var express = require('express')
var router = express.Router()
const { signup, signinAdmin, getAllPlayers } = require('./controller')

router.post('/signup', signup)
router.post('/signin', signinAdmin)
router.get('/getplayers', getAllPlayers)

module.exports = router
