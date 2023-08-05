const User = require('./model')
const bcrypt = require('bcryptjs')

module.exports = {
  actionLogout: (req, res) => {
    req.session.destroy()
    res.redirect('/')
  },
}
