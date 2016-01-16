var readline = require('readline')
var redis = require('redis')
var classifier = require('./lib/classifier.js')
var policyParser = require('./lib/policy.js')
var atckParser = require('./lib/atck.js')
var streamParser = require('./lib/stream.js')
var config = require('./config/config.js')

var client = redis.createClient(config.redisPort, config.redisHost)

client.on('error', function(e) {
  console.log('redis client', e)
  client.publish(config.resultChannel + '-log', JSON.stringify(e))
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
      var json = classifier.parse(line)
      switch (json.brief)
      {
        case 'POLICYDENY':
        case 'POLICYPERMIT':
        var content = policyParser.parse(json.secInfo)
        json.secInfo = content
        break;

        case 'ATCKDF':
        var content = atckParser.parse(json.secInfo)
        json.secInfo = content
        break;

        case 'STREAM':
        var content = streamParser.parse(json.secInfo)
        json.secInfo = content
        break;

        default:
        client.publish(config.resultChannel + '-log', JSON.stringify({message: 'unknow brief', source: line}))
        break;
      }
      // pub result to redis
      client.publish(config.resultChannel, JSON.stringify(json))
    } catch(e) {
      // pub error to redis
      e.source = line
      client.publish(config.resultChannel + '-log', JSON.stringify(e))
    }
  })
})
