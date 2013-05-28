mongoose = require 'mongoose'
jsonSelect = require 'mongoose-json-select'

# User model
User = new mongoose.Schema(
  firstName: String
  lastName: String
  email: String
)

User.set 'toJSON',
  virtuals: true

User.plugin(jsonSelect, '-_id');
module.exports = mongoose.model 'User', User