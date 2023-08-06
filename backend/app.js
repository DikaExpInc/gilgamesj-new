var createError = require('http-errors')
var express = require('express')
var path = require('path')
var cookieParser = require('cookie-parser')
var logger = require('morgan')
const methodOverride = require('method-override')
const session = require('express-session')
const flash = require('connect-flash')
var cors = require('cors')
const { Client, Server } = require('node-osc')

var server = new Server(53000, '192.168.1.4') // set IP and Port of Server

server.on('listening', () => {
  console.log('OSC Server is listening.')
})

server.on('message', (msg) => {
  const [address, ...args] = msg

  const result = {
    url: address,
    value: args,
  }

  console.log(result)
})

// player API
const authRouter = require('./app/auth/router')
const browserRouter = require('./app/browser/router')
const socialMediaRouter = require('./app/social_media/router')
const cameraRouter = require('./app/camera/router')
const chatRouter = require('./app/chat/router')
const contactRouter = require('./app/contact/router')
const phoneRouter = require('./app/phone/router')
const galleryPhotoRouter = require('./app/gallery_photo/router')
const galleryVideoRouter = require('./app/gallery_video/router')
const mapRouter = require('./app/map/router')
const stageRouter = require('./app/stage/router')
const taskRouter = require('./app/task/router')
const usersRouter = require('./app/users/router')
const playerRouter = require('./app/player/router')

// Admin API
const authAdminRouter = require('./app/auth/router.admin')
const browserAdminRouter = require('./app/browser/router.admin')
const socialMediaAdminRouter = require('./app/social_media/router.admin')
const cameraAdminRouter = require('./app/camera/router.admin')
const chatAdminRouter = require('./app/chat/router.admin')
const contactAdminRouter = require('./app/contact/router.admin')
const phoneAdminRouter = require('./app/phone/router.admin')
const galleryPhotoAdminRouter = require('./app/gallery_photo/router.admin')
const galleryVideoAdminRouter = require('./app/gallery_video/router.admin')
const mapAdminRouter = require('./app/map/router.admin')
const stageAdminRouter = require('./app/stage/router.admin')
const taskAdminRouter = require('./app/task/router.admin')
const usersAdminRouter = require('./app/users/router.admin')
const playerAdminRouter = require('./app/player/router.admin')

const app = express()
const URL = `/api/v1`
const URL_ADMIN = `/admin/api/v1`
app.use(cors())

app.use(
  session({
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: true,
    cookie: {},
  })
)
app.use(flash())
app.use(methodOverride('_method'))
app.use(logger('dev'))
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.use(cookieParser())
app.use(express.static(path.join(__dirname, 'public')))

// player master
app.use(`${URL}/browser`, browserRouter)
app.use(`${URL}/socialmedia`, socialMediaRouter)
app.use(`${URL}/camera`, cameraRouter)
app.use(`${URL}/chat`, chatRouter)
app.use(`${URL}/contact`, contactRouter)
app.use(`${URL}/phone`, phoneRouter)
app.use(`${URL}/galleryphoto`, galleryPhotoRouter)
app.use(`${URL}/galleryvideo`, galleryVideoRouter)
app.use(`${URL}/map`, mapRouter)
app.use(`${URL}/stage`, stageRouter)
app.use(`${URL}/task`, taskRouter)
app.use(`${URL}/users`, usersRouter)
app.use(`${URL}/players`, playerRouter)
app.use(`${URL}/auth`, authRouter)

// admin master
app.use(`${URL_ADMIN}/browser`, browserAdminRouter)
app.use(`${URL_ADMIN}/socialmedia`, socialMediaAdminRouter)
app.use(`${URL_ADMIN}/camera`, cameraAdminRouter)
app.use(`${URL_ADMIN}/chat`, chatAdminRouter)
app.use(`${URL_ADMIN}/contact`, contactAdminRouter)
app.use(`${URL_ADMIN}/phone`, phoneAdminRouter)
app.use(`${URL_ADMIN}/galleryphoto`, galleryPhotoAdminRouter)
app.use(`${URL_ADMIN}/galleryvideo`, galleryVideoAdminRouter)
app.use(`${URL_ADMIN}/map`, mapAdminRouter)
app.use(`${URL_ADMIN}/stage`, stageAdminRouter)
app.use(`${URL_ADMIN}/task`, taskAdminRouter)
app.use(`${URL_ADMIN}/users`, usersAdminRouter)
app.use(`${URL_ADMIN}/players`, playerAdminRouter)
app.use(`${URL_ADMIN}/auth`, authAdminRouter)
// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404))
})

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message
  res.locals.error = req.app.get('env') === 'development' ? err : {}

  // Send JSON response for the error
  res.status(err.status || 500).json({ error: err.message })
})

module.exports = app
