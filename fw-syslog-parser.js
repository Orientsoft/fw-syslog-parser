var readline = require('readline')
var redis = require('redis')
var parser = require('./lib/parser.js')
var config = require('./config/config.js')

var client = redis.createClient(config.redisPort, config.redisHost)

client.on('error', function(e) {
  console.log('redis client', e)
})

var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
})

client.on('connect', function() {
  rl.on('line', function(line) {
    // got a line, parse
    try {
      var json = parser.parse(line)
      // pub result to redis
      client.publish(config.resultChannel, JSON.stringify(json))
    } catch(e) {
      // pub error to redis
      e.source = line
      client.publish(config.resultChannel + '-error', JSON.stringify(e))
    }
  })
})
