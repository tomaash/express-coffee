request = require 'supertest'

User = require process.cwd() + '/.app/models/user'
app = require process.cwd() + '/.app'


INITIAL_DATA = {
  "firstName":"Some Data"
}

UPDATED_DATA = {
  "firstName":"Another data"
}

cleanDB = (done) ->
  User.remove {}, ->
    done()

describe 'User', ->
  before cleanDB

  user_id = null

  it "should be created", (done) ->
    request(app)
      .post("/api/users")
      .send(INITIAL_DATA)
      .expect 201, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "id"
        res.body["id"].should.be.ok
        user_id = res.body["id"]
        done()

  it "should be accessible by id", (done) ->
    request(app)
      .get("/api/users/#{user_id}")
      .expect 200, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "id"
        res.body["id"].should.be.eql user_id
        done()

  it "should be listed in list", (done) ->
    request(app)
      .get("/api/users")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 1
        res.body[0].should.include(INITIAL_DATA)
        done()

  it "should be updated", (done) ->
    request(app)
      .put("/api/users/#{user_id}")
      .send(UPDATED_DATA)
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        done()

  it "should be persisted after update", (done) ->
    request(app)
      .get("/api/users/#{user_id}")
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        res.body.should.have.property "id"
        res.body["id"].should.be.eql user_id
        done()

  it "should be removed", (done) ->
    request(app)
      .del("/api/users/#{user_id}")
      .expect 200, (err, res) ->
        done()

  it "should not be listed after remove", (done) ->
    request(app)
      .get("/api/users")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 0
        done()

  after cleanDB
