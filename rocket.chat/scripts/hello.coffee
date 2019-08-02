module.exports = (robot) ->
  robot.hear /hello/i, (res) ->
    res.send "你好"

  robot.respond /你好/i, (res) ->
    res.reply "hello"

  robot.hear /I like pie/i, (res) ->
    res.emote "makes a freshly baked pie"
  
  robot.respond /exec\s(.*)/i, (msg) ->
    data = '```bash \n'
    exec = msg.match[1].trim()
    spawn = require('child_process').spawn
    proc = spawn 'bash', ['-c', exec]
    proc.stdout.on 'data', (chunk) ->
      data += chunk.toString()
    proc.stderr.on 'data', (chunk) ->
      msg.reply chunk.toString()
    proc.stdout.on 'end', () ->
      msg.reply data.toString() + '```'
