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
const Player = require('./app/player/model')
const Seat = require('./app/seat/model')

var server = new Server(53001, '192.168.0.2')
// var server = new Server(53001, '192.168.41.220')

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

  if (result['url'] == '/signaling/lightning') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'lightning',
          player: 'all',
        }
      )
    }
    if (result['value'] == 'all-museum1') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'lightning',
          player: 'all-museum1',
        }
      )
    }
  }
  if (result['url'] == '/control/volume-tablet-up') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          player: 'all',
          control: 'volume-tablet-up',
        }
      )
      setTimeout(async () => {
        await Setting.findOneAndUpdate(
          {
            _id: '64de3fd2843badaf9efc006b',
          },
          {
            player: 'all',
            control: '',
          }
        )
      }, 2000)
    }
  }
  if (result['url'] == '/control/volume-tablet-down') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          player: 'all',
          control: 'volume-tablet-down',
        }
      )
      setTimeout(async () => {
        await Setting.findOneAndUpdate(
          {
            _id: '64de3fd2843badaf9efc006b',
          },
          {
            player: 'all',
            control: '',
          }
        )
      }, 2000)
    }
  }
  if (result['url'] == '/control/volume-tablet-0') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          player: 'all',
          control: 'volume-tablet-0',
        }
      )
      setTimeout(async () => {
        await Setting.findOneAndUpdate(
          {
            _id: '64de3fd2843badaf9efc006b',
          },
          {
            player: 'all',
            control: '',
          }
        )
      }, 2000)
    }
  }
  if (result['url'] == '/control/volume-tablet-25') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          player: 'all',
          control: 'volume-tablet-25',
        }
      )
      setTimeout(async () => {
        await Setting.findOneAndUpdate(
          {
            _id: '64de3fd2843badaf9efc006b',
          },
          {
            player: 'all',
            control: '',
          }
        )
      }, 2000)
    }
  }
  if (result['url'] == '/control/volume-tablet-50') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          player: 'all',
          control: 'volume-tablet-50',
        }
      )
      setTimeout(async () => {
        await Setting.findOneAndUpdate(
          {
            _id: '64de3fd2843badaf9efc006b',
          },
          {
            player: 'all',
            control: '',
          }
        )
      }, 2000)
    }
  }
  if (result['url'] == '/control/volume-tablet-75') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          player: 'all',
          control: 'volume-tablet-75',
        }
      )
      setTimeout(async () => {
        await Setting.findOneAndUpdate(
          {
            _id: '64de3fd2843badaf9efc006b',
          },
          {
            player: 'all',
            control: '',
          }
        )
      }, 2000)
    }
  }
  if (result['url'] == '/control/volume-tablet-100') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          player: 'all',
          control: 'volume-tablet-100',
        }
      )
      setTimeout(async () => {
        await Setting.findOneAndUpdate(
          {
            _id: '64de3fd2843badaf9efc006b',
          },
          {
            player: 'all',
            control: '',
          }
        )
      }, 2000)
    }
  }
  if (result['url'] == '/control/brightness-tablet-0') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          player: 'all',
          control: 'brightness-tablet-0',
        }
      )
      setTimeout(async () => {
        await Setting.findOneAndUpdate(
          {
            _id: '64de3fd2843badaf9efc006b',
          },
          {
            player: 'all',
            control: '',
          }
        )
      }, 2000)
    }
  }
  if (result['url'] == '/control/brightness-tablet-25') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          player: 'all',
          control: 'brightness-tablet-25',
        }
      )
      setTimeout(async () => {
        await Setting.findOneAndUpdate(
          {
            _id: '64de3fd2843badaf9efc006b',
          },
          {
            player: 'all',
            control: '',
          }
        )
      }, 2000)
    }
  }
  if (result['url'] == '/control/brightness-tablet-50') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          player: 'all',
          control: 'brightness-tablet-50',
        }
      )
      setTimeout(async () => {
        await Setting.findOneAndUpdate(
          {
            _id: '64de3fd2843badaf9efc006b',
          },
          {
            player: 'all',
            control: '',
          }
        )
      }, 2000)
    }
  }
  if (result['url'] == '/control/brightness-tablet-75') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          player: 'all',
          control: 'brightness-tablet-75',
        }
      )
      setTimeout(async () => {
        await Setting.findOneAndUpdate(
          {
            _id: '64de3fd2843badaf9efc006b',
          },
          {
            player: 'all',
            control: '',
          }
        )
      }, 2000)
    }
  }
  if (result['url'] == '/control/brightness-tablet-100') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          player: 'all',
          control: 'brightness-tablet-100',
        }
      )
      setTimeout(async () => {
        await Setting.findOneAndUpdate(
          {
            _id: '64de3fd2843badaf9efc006b',
          },
          {
            player: 'all',
            control: '',
          }
        )
      }, 2000)
    }
  }
  if (result['url'] == '/signaling/error') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'error',
          player: 'all',
        }
      )
    }
  }
  if (result['url'] == '/control/panic') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'panic',
          player: 'all',
        }
      )
    }
  }
  if (result['url'] == '/game/pre-game') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'pre-game',
          player: 'all',
        }
      )
    }
  }
  if (result['url'] == '/movement/go-to-theater') {
    if (result['value'] == 'all') {
      const players = await Player.find({})

      // Memisahkan pemain menjadi tiga array berdasarkan user_type
      const childrenPlayers = players.filter(
        (player) => player.user_type === 'children'
      )
      const parentPlayers = players.filter(
        (player) => player.user_type === 'parent'
      )
      const disabilityPlayers = players.filter(
        (player) => player.user_type === 'disability'
      )

      // Menggabungkan kembali array pemain dalam urutan yang diinginkan
      const sortedPlayers = [
        ...childrenPlayers,
        ...parentPlayers,
        ...disabilityPlayers,
      ]

      await Seat.updateMany({}, { $set: { isOccupied: false } })
      // Memberikan tempat duduk sesuai urutan
      await assignSeats(sortedPlayers)

      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go-to-theater',
          player: 'all',
        }
      )
    }
    if (result['value'] == 'group-hemelstier') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go-to-theater',
          player: 'group-hemelstier',
        }
      )
    }
  }
  if (result['url'] == '/movement/go-to-museum1') {
    if (result['value'] == 'row1') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go-to-museum1',
          player: 'row1',
        }
      )
    }
    if (result['value'] == 'row2-left-side') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go-to-museum1',
          player: 'row2-left-side',
        }
      )
    }
    if (result['value'] == 'group-ishtar') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go-to-museum1',
          player: 'group-ishtar',
        }
      )
    }
  }
  if (result['url'] == '/movement/go-to-museum2') {
    if (result['value'] == 'row2-right-side') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go-to-museum2',
          player: 'row2-right-side',
        }
      )
    }
    if (result['value'] == 'group-gilgamesj') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'go-to-museum2',
          player: 'group-gilgamesj',
        }
      )
    }
  }
  if (result['url'] == '/game/game11-rebus') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game11-rebus',
          player: 'all',
        }
      )
    }
  }
  if (result['url'] == '/signaling/give-the-tablet') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'give-the-tablet',
          player: 'all',
        }
      )
    }
    if (result['value'] == 'all+parent&mobility') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'give-the-tablet',
          player: 'all+parent&mobility',
        }
      )
    }
    if (result['value'] == 'all-museum1+2') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'give-the-tablet',
          player: 'all-museum1+2',
        }
      )
    }
    if (result['value'] == 'museum1') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'give-the-tablet',
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
          page: 'give-the-tablet',
          player: 'museum2',
        }
      )
    }
  }
  if (result['url'] == '/signaling/blank') {
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
    if (result['value'] == 'all-podium') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'blank',
          player: 'all-podium',
        }
      )
    }
    if (result['value'] == 'all-museum1+2') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'blank',
          player: 'all-museum1+2',
        }
      )
    }
    if (result['value'] == 'museum1') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'blank',
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
          page: 'blank',
          player: 'museum2',
        }
      )
    }
  }
  if (result['url'] == '/game/game1-shake') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game1-shake',
          player: 'all',
        }
      )
    }
  }
  if (result['url'] == '/game/game8-light') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game8-light',
          player: 'all',
        }
      )
    }
  }
  if (result['url'] == '/game/game2-gilgamesj') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game2-gilgamesj',
          player: 'all',
        }
      )
    }
  }
  if (result['url'] == '/game/game2-gilgamesj-winner') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game2-gilgamesj-winner',
          player: 'all',
        }
      )
    }
  }
  if (result['url'] == '/game/game5-choice-underwear') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game5-choice-underwear',
          player: 'all',
        }
      )
    }
  }
  if (result['url'] == '/game/game5-choice-underwear-winner') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game5-choice-underwear-winner',
          player: 'all',
        }
      )
    }
  }
  if (result['url'] == '/game/chat-find-humbaba') {
    if (result['value'] == 'museum1') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'chat-find-humbaba',
          player: 'museum1',
        }
      )
    }
  }
  if (result['url'] == '/game/chat-find-spear') {
    if (result['value'] == 'museum2') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'chat-find-spear',
          player: 'museum2',
        }
      )
    }
  }
  if (result['url'] == '/game/star-game') {
    if (result['value'] == 'all-museum1+2') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'star-game',
          player: 'all-museum1+2',
        }
      )
    }
  }
  if (result['url'] == '/game/game4-humbaba') {
    if (result['value'] == 'all-museum1+2') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game4-humbaba',
          player: 'all-museum1+2',
        }
      )
    }
  }
  if (result['url'] == '/movement/show-humbaba') {
    if (result['value'] == 'museum1') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'show-humbaba',
          player: 'museum1',
        }
      )
    }
  }
  if (result['url'] == '/signaling/give-spear') {
    if (result['value'] == 'museum2') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'give-spear',
          player: 'museum2',
        }
      )
    }
  }
  if (result['url'] == '/game/ishtar-calling') {
    if (result['value'] == 'random') {
      await updateIshtarCall()
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'ishtar-calling',
          player: 'random',
        }
      )
    }
  }
  if (result['url'] == '/game/game7-chat-hemelstier') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game7-chat-hemelstier',
          player: 'all',
        }
      )
    }
  }
  if (result['url'] == '/game/choose-your-character') {
    if (result['value'] == 'all+parent') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'choose-your-character',
          player: 'all+parent',
        }
      )
    }
  }
  if (result['url'] == '/game/game10-die-tablet') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'game10-die-tablet',
          player: 'all',
        }
      )
    }
  }
  if (result['url'] == '/signaling/give-tablet-back') {
    if (result['value'] == 'all') {
      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          page: 'give-tablet-back',
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
const game2Router = require('./app/game_2/router')
const game5Router = require('./app/game_5/router')

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
const game2AdminRouter = require('./app/game_2/router.admin')
const game5AdminRouter = require('./app/game_5/router.admin')
const {
  getSeats,
  assignSeats,
  updateIshtarCall,
} = require('./app/auth/controller')

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
app.use(`${URL}/selfie`, arCameraRouter)
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
app.use(`${URL}/game2`, game2Router)
app.use(`${URL}/game5`, game5Router)

// admin master
app.use(`${URL_ADMIN}/browser`, browserAdminRouter)
app.use(`${URL_ADMIN}/socialmedia`, socialMediaAdminRouter)
app.use(`${URL_ADMIN}/socialmediacomment`, socialMediaCommentAdminRouter)
app.use(`${URL_ADMIN}/camera`, cameraAdminRouter)
app.use(`${URL_ADMIN}/selfie`, arCameraAdminRouter)
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
app.use(`${URL_ADMIN}/game2`, game2AdminRouter)
app.use(`${URL_ADMIN}/game5`, game5AdminRouter)

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
