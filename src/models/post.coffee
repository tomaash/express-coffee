mongoose = require 'mongoose'
jsonSelect = require 'mongoose-json-select'

# Post model
Post = new mongoose.Schema(
  title: String
  body: String
)

Post.set 'toJSON',
  virtuals: true

Post.plugin(jsonSelect, '-_id');

module.exports = mongoose.model 'Post', Post