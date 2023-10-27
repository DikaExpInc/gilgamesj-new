const Player = require('../player/model')
const Setting = require('../setting/model')
const Theater = require('../theater/model')
const TheaterSeat = require('../theater_seat/model')
const User = require('../users/model')
const Seat = require('../seat/model')
const config = require('../../config')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')

// Fungsi untuk mengambil tempat duduk yang tersedia dengan pola zigzag
const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
// const rows = 17
// const cols = 11

async function getNextSeat() {
  let currentRow = 1
  let currentCol = 0
  let isForward = true

  const setting = await Setting.findOne({ _id: '64de3fd2843badaf9efc006b' })

  if (!setting) {
    return res.status(404).json({
      message: 'Setting not found',
      status: 'error',
    })
  }

  let cols = columns

  while (currentCol < cols) {
    const query = {
      seatNumber: `${alphabet[currentCol]}${currentRow}`,
      isOccupied: false,
    }

    const seat = await Seat.findOneAndUpdate(query, {
      $set: { isOccupied: true },
    })

    if (seat) {
      return { seat, currentRow, currentCol } // Mengembalikan seat serta nilai currentRow dan currentCol yang telah diupdate
    } else {
      // Mengatur perpindahan berikutnya sesuai dengan pola zigzag
      if (isForward) {
        if (currentRow < rows) {
          currentRow++
        } else {
          currentCol++
          isForward = false
        }
      } else {
        if (currentRow > 1) {
          currentRow--
        } else {
          currentCol++
          isForward = true
        }
      }
    }
  }

  return null // Mengembalikan null jika semua tempat duduk sudah terisi
}

// Function to generate random Columns
function generateRandomColumnsRow(totalColumns) {
  return Math.floor(Math.random() * totalColumns) + 1
}

// async function getNextSeatParent() {
//   let currentRow = 1
//   let currentCol = alphabet.indexOf('G') // Mulai dari kolom G
//   let isForward = true

//   // Pastikan currentCol berada dalam rentang yang valid
//   if (currentCol < 0) {
//     currentCol = 0
//   }

//   while (currentCol < cols) {
//     const query = {
//       seatNumber: `${alphabet[currentCol]}${currentRow}`,
//       isOccupied: false,
//     }

//     const seat = await Seat.findOneAndUpdate(query, {
//       $set: { isOccupied: true },
//     })

//     if (seat) {
//       return { seat, currentRow, currentCol } // Mengembalikan seat serta nilai currentRow dan currentCol yang telah diupdate
//     } else {
//       // Mengatur perpindahan berikutnya sesuai dengan pola zigzag
//       if (isForward) {
//         if (currentRow < rows) {
//           currentRow++
//         } else {
//           currentCol++
//           isForward = false
//         }
//       } else {
//         if (currentRow > 1) {
//           currentRow--
//         } else {
//           currentCol++
//           isForward = true
//         }
//       }
//     }
//   }

//   return null // Mengembalikan null jika semua tempat duduk sudah terisi
// }

// async function getNextSeatDisability() {
//   let currentRow = 1
//   let currentCol = alphabet.indexOf('K') // Mulai dari kolom G
//   let isForward = true

//   // Pastikan currentCol berada dalam rentang yang valid
//   if (currentCol < 0) {
//     currentCol = 0
//   }

//   while (currentCol < cols) {
//     const query = {
//       seatNumber: `${alphabet[currentCol]}${currentRow}`,
//       isOccupied: false,
//     }

//     const seat = await Seat.findOneAndUpdate(query, {
//       $set: { isOccupied: true },
//     })

//     if (seat) {
//       return { seat, currentRow, currentCol } // Mengembalikan seat serta nilai currentRow dan currentCol yang telah diupdate
//     } else {
//       // Mengatur perpindahan berikutnya sesuai dengan pola zigzag
//       if (isForward) {
//         if (currentRow < rows) {
//           currentRow++
//         } else {
//           currentCol++
//           isForward = false
//         }
//       } else {
//         if (currentRow > 1) {
//           currentRow--
//         } else {
//           currentCol++
//           isForward = true
//         }
//       }
//     }
//   }

//   return null // Mengembalikan null jika semua tempat duduk sudah terisi
// }

module.exports = {
  assignSeats: async function (players) {
    let currentRow = 1
    let currentCol = 1 // Mulai dari kolom 1
    let isForward = true

    const assignedSeats = []
    let prevRole = '' // Menyimpan peran sebelumnya

    const setting = await Setting.findOne({ _id: '64de3fd2843badaf9efc006b' })

    if (!setting) {
      return res.status(404).json({
        message: 'Setting not found',
        status: 'error',
      })
    }

    // const { rows, columns } = setting
    const { theater_id } = setting

    const theater = await Theater.findOne({ _id: theater_id })

    if (!theater) {
      return res.status(404).json({
        message: 'Theater not found',
        status: 'error',
      })
    }

    const theaterSeat = await TheaterSeat.find({ theater_id: theater_id })

    if (!theaterSeat) {
      return res.status(404).json({
        message: 'Theater Seat not found',
        status: 'error',
      })
    }

    // Compute the number of columns for each row based on the seats in the theater
    const seatsInRows = {}
    for (const seat of theaterSeat) {
      const [rowNum, colNum] = seat.seatNumber.split('-').map(Number)
      if (!seatsInRows[rowNum]) {
        seatsInRows[rowNum] = []
      }
      if (!seat.seatNumber.includes('empty')) {
        seatsInRows[rowNum].push(colNum)
      }
    }

    let rows = seatsInRows.length

    for (const player of players) {
      // console.log(player.username)
      // console.log(player.seat)
      while (true) {
        const query = {
          seatNumber: `${currentRow}-${currentCol}`,
          isOccupied: false,
          theater_id: theater_id,
        }

        const seat = await TheaterSeat.findOneAndUpdate(query, {
          $set: { isOccupied: true },
        })

        let cols = seatsInRows[currentRow].length

        if (seat) {
          // Hitung setengah jumlah baris
          const halfRows = Math.ceil(cols / 2) // Pembulatan ke atas jika jumlah baris ganjil

          // Misalkan currentRow adalah posisi saat ini
          let position = 'left' // Defaultnya adalah kiri
          if (currentCol > halfRows) {
            position = 'right' // Jika currentRow di atas setengah jumlah baris, maka di sebelah kanan
          }
          await Player.findByIdAndUpdate(player._id, {
            $set: {
              seat: seat.seatNumber,
              status_seat: `row${currentCol}`,
              position,
              stoel: currentRow,
              rij: currentCol,
            },
          })
          assignedSeats.push({ player, seat })
          break // Keluar dari loop jika kursi sudah ditemukan
        } else {
          if (isForward) {
            currentCol++
            if (currentCol > cols) {
              currentRow++
              currentCol = cols // Jika mencapai kolom terakhir, tetap di kolom terakhir
              isForward = false
            }
          } else {
            currentCol--
            if (currentCol < 1) {
              currentRow++
              currentCol = 1 // Jika mencapai kolom pertama, tetap di kolom pertama
              isForward = true
            }
          }
        }

        // Memeriksa peran sebelumnya dan peran saat ini
        const currentRole = player.user_type
        if (prevRole == '') {
          prevRole = currentRole
        }
        if (prevRole !== currentRole) {
          // Jika peran saat ini berbeda dengan peran sebelumnya, reset kolom ke 1
          currentCol += 1
          currentRow = 1
          prevRole = currentRole
        }
      }
    }

    return assignedSeats
  },
  signup: async (req, res, next) => {
    try {
      const payload = req.body
      // Hitung jumlah pengguna saat ini
      const userCount = await User.countDocuments()

      // Hitung grup berdasarkan modulus jumlah pengguna
      const group = userCount

      payload.group = group
      payload.username = 'gilgamesj-' + group
      payload.name = 'gilgamesj' + group
      payload.email = 'gilgamesj' + group + '@gilgamesj.io'

      if (payload.role == undefined) {
        let user = new User(payload)
        await user.save()
        delete user._doc.password

        if (
          !payload.total_player ||
          isNaN(payload.total_player) ||
          payload.total_player <= 0
        ) {
          return res.status(400).json({ error: 'Invalid total player value' })
        }

        const token = jwt.sign(
          {
            user: {
              id: user.id,
              username: user.username,
              email: user.email,
            },
          },
          config.jwtKey
        )

        for (
          let player_num = 1;
          player_num <= payload.total_player;
          player_num++
        ) {
          let player
          if (player_num == 1) {
            player = new Player({
              username: `${user.username}-${player_num}`,
              player_num: player_num,
              user_id: user.id,
              status_play: 'Y',
              user_type: user.user_type,
            })
            await User.findByIdAndUpdate(user.id, {
              $set: { player_now: player_num },
            })
          } else {
            player = new Player({
              username: `${user.username}-${player_num}`,
              player_num: player_num,
              user_id: user.id,
              user_type: user.user_type,
            })
          }

          await player.save()

          await User.findByIdAndUpdate(user.id, {
            $push: { players: player._id },
          })
        }

        res.status(201).json({
          message: 'Successfully create user',
          status: 'success',
          data: { user, token, type: 'Bearer' },
        })
      } else {
        let user = new User(payload)
        await user.save()
        delete user._doc.password

        if (
          !payload.total_player ||
          isNaN(payload.total_player) ||
          payload.total_player <= 0
        ) {
          return res.status(400).json({ error: 'Invalid total player value' })
        }

        const token = jwt.sign(
          {
            user: {
              id: user.id,
              username: user.username,
              email: user.email,
            },
          },
          config.jwtKey
        )

        res.status(201).json({
          message: 'Successfully create user',
          status: 'success',
          data: { user, token, type: 'Bearer' },
        })
      }
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },
  getSeats: async (req, res, next) => {
    try {
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
      const assignedSeats = await assignSeats(sortedPlayers)
      // Menyimpan hasil tempat duduk ke dalam database atau lainnya sesuai kebutuhan

      res.status(200).json({
        message: `Successfully get seats`,
        status: 'success',
        assignedSeats,
      })
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },
  getRowCol: async (req, res, next) => {
    try {
      const setting = await Setting.findOne({ _id: '64de3fd2843badaf9efc006b' })

      if (!setting) {
        return res.status(404).json({
          message: 'Setting not found',
          status: 'error',
        })
      }

      const { rows, columns } = setting

      res.status(200).json({
        message: 'Successfully get seats',
        status: 'success',
        row: rows,
        col: columns,
      })
    } catch (err) {
      return res.status(500).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },
  updateIshtarCall: async () => {
    try {
      const player = await Player.find({})
      const rijValues = player
        .map((item) => parseInt(item.stoel))
        .filter((value) => !isNaN(value)) // Filter nilai NaN

      // Mencari nilai maksimal dari array rijValues
      const maxRij = Math.max(...rijValues)

      // Buat urutan kolom acak
      const randomRow = generateRandomColumnsRow(maxRij)

      // Membuat objek untuk menyimpan jumlah kolom pada setiap row
      const columnCounts = {}

      // Mengelompokkan data berdasarkan nilai rij (row)
      player.forEach((item) => {
        const rij = item.stoel
        if (!columnCounts[rij]) {
          columnCounts[rij] = 0
        }
        columnCounts[rij]++
      })

      // Mengakses jumlah kolom untuk row tertentu (misalnya row 1)
      const rowToRetrieve = randomRow
      const jumlahKolomRow1 = columnCounts[rowToRetrieve] || 0

      // Buat urutan kolom acak
      const randomCol = generateRandomColumnsRow(jumlahKolomRow1)

      await Setting.findOneAndUpdate(
        {
          _id: '64de3fd2843badaf9efc006b',
        },
        {
          ishtarColumns: randomCol,
          istharRows: randomRow,
        }
      )
    } catch (err) {}
  },
  signin: (req, res, next) => {
    const { email, password } = req.body
    User.findOne({ email: email })
      .then((user) => {
        if (user) {
          const checkPassword = bcrypt.compareSync(password, user.password)
          if (checkPassword) {
            const token = jwt.sign(
              {
                user: {
                  id: user.id,
                  username: user.username,
                  email: user.email,
                },
              },
              config.jwtKey
            )

            res.status(200).json({
              data: { token },
            })
          } else {
            res.status(403).json({
              message: 'Your password is wrong',
            })
          }
        } else {
          res.status(403).json({
            message: 'Email not yet registry',
          })
        }
      })
      .catch((err) => {
        res.status(500).json({
          message: err.message || `Internal server error`,
        })
      })
  },
  signinAdmin: (req, res, next) => {
    const { email, password } = req.body
    User.findOne({ email: email })
      .then((user) => {
        if (user) {
          if (user.role === 'admin') {
            const checkPassword = bcrypt.compareSync(password, user.password)
            if (checkPassword) {
              const token = jwt.sign(
                {
                  user: {
                    id: user.id,
                    username: user.username,
                    email: user.email,
                  },
                },
                config.jwtKey
              )

              res.status(200).json({
                data: { token },
              })
            } else {
              res.status(403).json({
                message: 'Your password is wrong',
              })
            }
          } else {
            res.status(403).json({
              message: 'Account is not admin role',
            })
          }
        } else {
          res.status(403).json({
            message: 'Email not yet registry',
          })
        }
      })
      .catch((err) => {
        res.status(500).json({
          message: err.message || `Internal server error`,
        })
      })
  },
  addPlayer: async (req, res, next) => {
    try {
      const { total_player } = req.body

      if (!total_player || isNaN(total_player) || total_player <= 0) {
        return res.status(400).json({ error: 'Invalid total player value' })
      }

      for (let player_num = 1; player_num <= total_player; player_num++) {
        let player
        if (player_num == 1) {
          player = new Player({
            username: `${req.user.username}-${player_num}`,
            player_num: player_num,
            user_id: req.user.id,
            status_play: 'Y',
          })
          await User.findByIdAndUpdate(req.user._id, {
            $set: { player_now: player_num },
          })
        } else {
          player = new Player({
            username: `${req.user.username}-${player_num}`,
            player_num: player_num,
            user_id: req.user.id,
          })
        }

        await player.save()

        await User.findByIdAndUpdate(req.user._id, {
          $push: { players: player._id },
        })
      }

      res.status(201).json({
        message: `Successfully add ${total_player} player`,
        status: 'success',
      })
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },
  getPlayers: async (req, res, next) => {
    try {
      const player = await Player.find({ user_id: req.user.id })
      res.status(200).json({
        message: `Successfully get players`,
        status: 'success',
        data: player,
      })
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },
  getAllPlayers: async (req, res, next) => {
    try {
      const player = await Player.find({})
      res.status(200).json({
        message: `Successfully get players`,
        status: 'success',
        data: player,
      })
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },
  changePlayer: async (req, res, next) => {
    try {
      if (req.body.player_now != undefined) {
        await User.findOneAndUpdate(
          {
            _id: req.user._id,
          },
          {
            player_now: req.player_now++,
          }
        )
        res.status(200).json({
          message: `Successfully change player to ${req.body.player_now}`,
          status: 'success',
        })
      } else {
        res.status(403).json({
          message: `Please fill player_now`,
          status: 'failed',
        })
      }
    } catch (err) {
      return res.status(422).json({
        error: 1,
        message: err.message,
        fields: err.errors,
      })
    }
  },
  changeNamePlayer: async (req, res, next) => {
    try {
      const data = req.body

      if (!data.changes) {
        return res.status(400).json({
          message: 'Please provide the changes',
          status: 'failed',
        })
      }

      const changes = JSON.parse(data.changes)

      if (!Array.isArray(changes)) {
        return res.status(400).json({
          message: 'Changes should be an array',
          status: 'failed',
        })
      }

      const updatedUsers = await Promise.all(
        changes.map(async (change) => {
          const { player_id, playerName } = change

          if (!player_id || !playerName) {
            return null // Melewatkan perubahan yang tidak lengkap
          }

          // Mencari dan mengubah nama pemain dalam database berdasarkan _id
          return await Player.findOneAndUpdate(
            { _id: player_id },
            { username: playerName } // Menggunakan field playerName sesuai dengan model
          )
        })
      )

      const validUpdates = updatedUsers.filter((user) => user !== null)

      if (validUpdates.length === 0) {
        return res.status(404).json({
          message: 'No valid updates found',
          status: 'failed',
        })
      }

      const updatedNames = validUpdates.map((user) => user.playerName)

      res.status(200).json({
        message: `Successfully changed player names to: ${updatedNames.join(
          ', '
        )}`,
        status: 'success',
      })
    } catch (err) {
      res.status(500).json({
        message: 'An error occurred',
        status: 'error',
        error: err.message,
      })
    }
  },
}
