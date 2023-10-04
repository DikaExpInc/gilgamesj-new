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
const Setting = require('./app/setting/model')

// var server = new Server(53001, '192.168.0.2')
var server = new Server(53001, '192.168.107.220')

server.on('listening', () => {
  console.log('OSC Server is listening.')
})

server.on('message', async (msg) => {
  const [address, ...args] = msg

  const result = {
    url: address,
    value: args,
  }

  if (result['url'] == '/mode') {
    if (result['value'] == 'phone') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'phone',
        }
      )
    } else if (result['value'] == 'light') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'light',
        }
      )
    } else if (result['value'] == 'notification') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'notification',
        }
      )
    } else if (result['value'] == 'blank') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'blank',
        }
      )
    } else if (result['value'] == 'clap') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'clap',
        }
      )
    } else if (result['value'] == 'group') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'group',
        }
      )
    } else if (result['value'] == 'performance') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'performance',
        }
      )
    } else if (result['value'] == 'pre_game') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'pre_game',
        }
      )
    } else if (result['value'] == 'go_to_theater') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go_to_theater',
        }
      )
    } else if (result['value'] == 'game_descibel') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_descibel',
        }
      )
    } else if (result['value'] == 'game_music') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_music',
        }
      )
    } else if (result['value'] == 'game_music_theater') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_music_theater',
        }
      )
    } else if (result['value'] == 'game_shake') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_shake',
        }
      )
    } else if (result['value'] == 'game_light') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_light',
        }
      )
    } else if (result['value'] == 'game_light_done') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_light_done',
        }
      )
    } else if (result['value'] == 'game_star') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_star',
        }
      )
    } else if (result['value'] == 'game_star_solving') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_star_solving',
        }
      )
    } else if (result['value'] == 'game_star_timer') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_star_timer',
        }
      )
    } else if (result['value'] == 'game_star_done') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_star_done',
        }
      )
    } else if (result['value'] == 'game_choice') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_choice',
        }
      )
    } else if (result['value'] == 'game_music_shake') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_music_shake',
        }
      )
    } else if (result['value'] == 'game_music_shake_done') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_music_shake_done',
        }
      )
    } else if (result['value'] == 'game_chat') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_chat',
        }
      )
    } else if (result['value'] == 'game_chat_done') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_chat_done',
        }
      )
    } else if (result['value'] == 'game_call_humbaba') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_call_humbaba',
        }
      )
    } else if (result['value'] == 'game_call_humbaba_done') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_call_humbaba_done',
        }
      )
    } else if (result['value'] == 'game_chat_and_call') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game_chat_and_call',
        }
      )
    }
  }
})

// player API
const authRouter = require('./app/auth/router')
const browserRouter = require('./app/browser/router')
const socialMediaRouter = require('./app/social_media/router')
const socialMediaCommentRouter = require('./app/social_media_comment/router')
const cameraRouter = require('./app/camera/router')
const chatRouter = require('./app/chat/router')
const chatDetailRouter = require('./app/chat_detail/router')
const contactRouter = require('./app/contact/router')
const phoneRouter = require('./app/phone/router')
const galleryPhotoRouter = require('./app/gallery_photo/router')
const galleryVideoRouter = require('./app/gallery_video/router')
const mapRouter = require('./app/map/router')
const stageRouter = require('./app/stage/router')
const taskRouter = require('./app/task/router')
const usersRouter = require('./app/users/router')
const playerRouter = require('./app/player/router')
const playerChatRouter = require('./app/player_chats/router')
const lightRouter = require('./app/light/router')
const settingRouter = require('./app/setting/router')
const preGameRouter = require('./app/pregame/router')
const arCameraRouter = require('./app/ar_camera/router')

// Admin API
const authAdminRouter = require('./app/auth/router.admin')
const browserAdminRouter = require('./app/browser/router.admin')
const socialMediaAdminRouter = require('./app/social_media/router.admin')
const socialMediaCommentAdminRouter = require('./app/social_media_comment/router.admin')
const cameraAdminRouter = require('./app/camera/router.admin')
const chatAdminRouter = require('./app/chat/router.admin')
const chatDetailAdminRouter = require('./app/chat_detail/router.admin')
const contactAdminRouter = require('./app/contact/router.admin')
const phoneAdminRouter = require('./app/phone/router.admin')
const galleryPhotoAdminRouter = require('./app/gallery_photo/router.admin')
const galleryVideoAdminRouter = require('./app/gallery_video/router.admin')
const mapAdminRouter = require('./app/map/router.admin')
const stageAdminRouter = require('./app/stage/router.admin')
const taskAdminRouter = require('./app/task/router.admin')
const usersAdminRouter = require('./app/users/router.admin')
const playerAdminRouter = require('./app/player/router.admin')
const playerAdminChatRouter = require('./app/player_chats/router.admin')
const lightAdminRouter = require('./app/light/router.admin')
const settingAdminRouter = require('./app/setting/router.admin')
const preGameAdminRouter = require('./app/pregame/router.admin')
const arCameraAdminRouter = require('./app/ar_camera/router.admin')

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
app.use(`${URL}/socialmediacomment`, socialMediaCommentRouter)
app.use(`${URL}/camera`, cameraRouter)
app.use(`${URL}/chat`, chatRouter)
app.use(`${URL}/chatdetail`, chatDetailRouter)
app.use(`${URL}/contact`, contactRouter)
app.use(`${URL}/phone`, phoneRouter)
app.use(`${URL}/galleryphoto`, galleryPhotoRouter)
app.use(`${URL}/galleryvideo`, galleryVideoRouter)
app.use(`${URL}/map`, mapRouter)
app.use(`${URL}/stage`, stageRouter)
app.use(`${URL}/task`, taskRouter)
app.use(`${URL}/users`, usersRouter)
app.use(`${URL}/players`, playerRouter)
app.use(`${URL}/playerchats`, playerChatRouter)
app.use(`${URL}/auth`, authRouter)
app.use(`${URL}/light`, lightRouter)
app.use(`${URL}/setting`, settingRouter)
app.use(`${URL}/pregame`, preGameRouter)
app.use(`${URL}/arcamera`, arCameraRouter)

// admin master
app.use(`${URL_ADMIN}/browser`, browserAdminRouter)
app.use(`${URL_ADMIN}/socialmedia`, socialMediaAdminRouter)
app.use(`${URL_ADMIN}/socialmediacomment`, socialMediaCommentAdminRouter)
app.use(`${URL_ADMIN}/camera`, cameraAdminRouter)
app.use(`${URL_ADMIN}/chat`, chatAdminRouter)
app.use(`${URL_ADMIN}/chatdetail`, chatDetailAdminRouter)
app.use(`${URL_ADMIN}/contact`, contactAdminRouter)
app.use(`${URL_ADMIN}/phone`, phoneAdminRouter)
app.use(`${URL_ADMIN}/galleryphoto`, galleryPhotoAdminRouter)
app.use(`${URL_ADMIN}/galleryvideo`, galleryVideoAdminRouter)
app.use(`${URL_ADMIN}/map`, mapAdminRouter)
app.use(`${URL_ADMIN}/stage`, stageAdminRouter)
app.use(`${URL_ADMIN}/task`, taskAdminRouter)
app.use(`${URL_ADMIN}/users`, usersAdminRouter)
app.use(`${URL_ADMIN}/players`, playerAdminRouter)
app.use(`${URL_ADMIN}/playerchats`, playerAdminChatRouter)
app.use(`${URL_ADMIN}/auth`, authAdminRouter)
app.use(`${URL_ADMIN}/light`, lightAdminRouter)
app.use(`${URL_ADMIN}/setting`, settingAdminRouter)
app.use(`${URL_ADMIN}/pregame`, preGameAdminRouter)
app.use(`${URL_ADMIN}/arcamera`, arCameraAdminRouter)

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
