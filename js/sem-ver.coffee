###
# Usage
# semver = SemVer.parse "0.2.3"
# isValid = semver.isValid()
#
# or
#
# semver = new SemVer()
# semVer.minor = 3
# isValid = semVer.isValid()
###

class SemVer
  # +++ Todo Protect these from write access once they have been set
  isValid: true
  major:0
  minor:0
  patch:0
  preRelease: null
  metadata: null

  @parse: (versionString)-> new SemVer versionString

  @nextMajorVersion: (prevSemver)->
    # todo

  @nextMinorVersion: (prevSemver)->
    # todo

  @nextPatchVersion: (prevSemver)->
    # todo

  constructor: (versionString=null)->
    @parse versionString if !!versionString

  isBefore: (ver)->
    return false if @isEqual ver
    return false if @major >= ver.major
    return false if @minor >= ver.minor
    return false if @patch >= ver.patch
    # return false if @preRelease is ver.preRelease
    # return false if @preReleaseIsAfter(ver)
    return true

  preReleaseIsAfter: (ver)->
    # +++ ToDo update to handle dotted pre-releases
    return true if @preRelease > ver.preRelease
    return true

  isAfter: (ver)-> not @isEqual(ver) and not @sisBefore(ver)
  isEqual: (ver)->
    @isValid is ver.isValid and @major is ver.major and @minor is ver.minor and @patch is ver.patch and @preRelease is ver.preRelease and @metadata is ver.metadata 

  parse: (versionString)=>
    metadataTokens = "#{versionString}".split "+"
    return @isValid = false if metadataTokens.length > 2
    @parseMetadata metadataTokens[1] if 2 is metadataTokens.length

    preReleaseTokens = metadataTokens[0].split "-"
    return @isValid = false if preReleaseTokens.length > 2

    @parsePreRelease preReleaseTokens[1] if 2 is preReleaseTokens.length
    tokens = preReleaseTokens[0].split "."
    return @isValid = false if 3 isnt tokens.length

    @parseMajor tokens['0']
    @parseMinor tokens['1']
    @parsePatch tokens['2']

  parseMajor: (majorString)=>
    @major = +majorString
    @isValid = @major = false if "#{majorString}".length isnt "#{@major}".length
    @major

  parseMinor: (minorString)=>
    @minor = +minorString
    @isValid = @minor = false if "#{minorString}".length isnt "#{@minor}".length
    @minor

  parsePatch: (patchString)=>
    @patch = +patchString
    @isValid = @patch = false if "#{patchString}".length isnt "#{@patch}".length
    @patch

  parsePreRelease: (@preRelease)=>
    # +++ handle dotted pre release

  parseMetadata: (@metadata)=>

  validate: ->
    # if @major > 0
    #   return @isValid = false if

  toString: ->
    value = "#{@major}.#{@minor}.#{@patch}"
    value = "#{value}-#{@preRelease}" if !!@preRelease
    value

  # SemVer 3
  # Once a versioned package has been released, the contents of that version MUST NOT be modified. Any modifications MUST be released as a new version.
  release: ->
    # +++ ToDo
    # prevent modifications

module.exports = SemVer
