readline = require 'readline'
SemVer = require "./sem-ver"
StringUtil = require "./string-util"

# +++ ToDo needs refactoring

class SemVerRepl
  @config:
    input: process.stdin
    output: process.stdout,
    terminal: false

  @start: ->
    rl = readline.createInterface @config
    rl.on 'line', @processLine
    rl.on "close", @stop

  @stop: -> console.log "done"

  @processLine: (line)->
      # +++ ToDo modularize this better
      input = StringUtil.squish line
      return unless !!input # skip empty lines

      tokens = input.split " "
      return console.log "invalid" unless 2 is tokens.length # expect 2 version strings

      semver1 = SemVer.parse tokens[0]
      semver2 = SemVer.parse tokens[1]
      return console.log "invalid" if not semver1.isValid
      return console.log "invalid" if not semver2.isValid
      # +++ ToDo move to comparator pattern to return -1, 0 or 1  
      return console.log "equal" if semver1.isEqual(semver2)
      return console.log "before" if semver1.isBefore(semver2)
      return console.log "after" if semver2.isBefore(semver1)
      return console.log semver1.toString() + " < ? > " + semver2.toString() # should never run

module.exports = SemVerRepl
