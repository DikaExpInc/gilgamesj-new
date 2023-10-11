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

var server = new Server(53001, '192.168.0.2')
// var server = new Server(53001, '192.168.107.220')

server.on('listening', () => {
  console.log('OSC Server is listening.')
})

server.on('message', async (msg) => {
  const [address, ...args] = msg

  const result = {
    url: address,
    value: args,
  }

  console.log(result)

  if (result['url'] == '/pre_game') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'pre_game',
          player: 'all',
        }
      )
    }
  }

  if (result['url'] == '/go_to_theater') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go_to_theater',
          player: 'all',
        }
      )
    }
    if (result['value'] == 'hemelstier_group') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go_to_theater',
          player: 'hemelstier_group',
        }
      )
    }
  }

  if (result['url'] == '/tablet_holder') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'tablet_holder',
          player: 'all',
        }
      )
    }
  }

  if (result['url'] == '/blank') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'blank',
          player: 'all',
        }
      )
    }
  }

  if (result['url'] == '/go_to_museum_1') {
    if (result['value'] == 'left_side') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go_to_museum_1',
          player: 'left_side',
        }
      )
    }
    if (result['value'] == 'row3_left_side') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go_to_museum_1',
          player: 'row3_left_side',
        }
      )
    }
    if (result['value'] == 'row4-left-side') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go_to_museum_1',
          player: 'row4-left-side',
        }
      )
    }
    if (result['value'] == 'isthar_group') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go_to_museum_1',
          player: 'isthar_group',
        }
      )
    }
  }

  if (result['url'] == '/go_to_museum_2') {
    if (result['value'] == 'right_side') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go_to_museum_2',
          player: 'right_side',
        }
      )
    }
    if (result['value'] == 'row3_right_side') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go_to_museum_2',
          player: 'row3_right_side',
        }
      )
    }
    if (result['value'] == 'row4-right-side') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go_to_museum_2',
          player: 'row4-right-side',
        }
      )
    }
    if (result['value'] == 'gilgamesj_group') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go_to_museum_2',
          player: 'gilgamesj_group',
        }
      )
    }
  }

  if (result['url'] == '/chat_game/wie_is_ut') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'chat_game_wie_is_ut',
          player: 'all',
        }
      )
    }
  }

  if (result['url'] == '/chat_game/finding_enkidu') {
    if (result['value'] == 'museum1,museum2') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'chat_game_finding_enkidu',
          player: 'museum1,museum2',
        }
      )
    }
  }

  if (result['url'] == '/chat_game/find_humbaba') {
    if (result['value'] == 'museum1') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'chat_game_find_humbaba',
          player: 'museum1',
        }
      )
    }
  }

  if (result['url'] == '/chat_game/find_spear') {
    if (result['value'] == 'museum2') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'chat_game_find_spear',
          player: 'museum2',
        }
      )
    }
  }

  if (result['url'] == '/lead_the_audience') {
    if (result['value'] == 'museum1,museum2') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'lead_the_audience',
          player: 'museum1,museum2',
        }
      )
    }
  }

  if (result['url'] == '/music_shake_game') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'music_shake_game',
          player: 'all',
        }
      )
    }
  }

  if (result['url'] == '/klaaglied_volk') {
    if (result['value'] == 'row1') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'klaaglied_volk',
          player: 'row1',
        }
      )
    }
  }

  if (result['url'] == '/music_shake_game_done') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'music_shake_game_done',
          player: 'all',
        }
      )
    }
  }

  if (result['url'] == '/seats') {
    if (result['value'] == 'podium') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'seats',
          player: 'podium',
        }
      )
    }
    if (result['value'] == 'museum1') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'seats',
          player: 'museum1',
        }
      )
    }
    if (result['value'] == 'museum2') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'seats',
          player: 'museum2',
        }
      )
    }
  }

  if (result['url'] == '/give_tablet_to') {
    if (result['value'] == '1,17') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'give_tablet_to',
          player: '1,17',
        }
      )
    }
  }

  if (result['url'] == '/light_game/gilgamesj') {
    if (result['value'] == 'side_seats') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'light_game_gilgamesj',
          player: 'side_seats',
        }
      )
    }
  }

  if (result['url'] == '/light_game/enkidu') {
    if (result['value'] == 'seats7,8,9,10,11') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'light_game_enkidu',
          player: '7,8,9,10,11',
        }
      )
    }
  }

  if (result['url'] == '/light_game') {
    if (result['value'] == 'all_but') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'light_game',
          player: 'all_but',
        }
      )
    }
  }

  if (result['url'] == '/seat_diagram') {
    if (result['value'] == 'podium') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'seat_diagram',
          player: 'podium',
        }
      )
    }
  }

  if (result['url'] == '/choice_game/underwear') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'choice_game_underwear',
          player: 'all',
        }
      )
    }
  }

  if (result['url'] == '/choice_game/sick') {
    if (result['value'] == 'museum1') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'choice_game_sick',
          player: 'museum1',
        }
      )
    }
  }

  if (result['url'] == '/star_game') {
    if (result['value'] == 'all-row4') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'star_game',
          player: 'all-row4',
        }
      )
    }
  }

  if (result['url'] == '/show_humbaba') {
    if (result['value'] == 'all-museum1-museum2') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'show_humbaba',
          player: 'all-museum1-museum2',
        }
      )
    }
  }

  if (result['url'] == '/calling_game/isthar') {
    if (result['value'] == 'row5-random') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'calling_game_isthar',
          player: 'row5-random',
        }
      )
    }
  }

  if (result['url'] == '/choose_your_character') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'choose_your_character',
          player: 'all',
        }
      )
    }
  }

  if (result['url'] == '/tablet_dies') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'tablet_dies',
          player: 'all',
        }
      )
    }
  }

  if (result['url'] == '/reviving_game') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'reviving_game',
          player: 'all',
        }
      )
    }
  }

  if (result['url'] == '/bring_tablets_back') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'bring_tablets_back',
          player: 'all',
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
const seatRouter = require('./app/seat/router')

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
const seatAdminRouter = require('./app/seat/router.admin')

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
app.use(`${URL}/seat`, seatRouter)

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
app.use(`${URL_ADMIN}/seat`, seatAdminRouter)

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
