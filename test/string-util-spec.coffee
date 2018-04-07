assert = require('assert')
StringUtil = require "../js/string-util"


describe 'StringUtil', ->
  context 'squish', ->
    it "compacts all white spaces", ->
      text = " a   b "
      squished = StringUtil.squish text
      assert.equal squished, "a b"
