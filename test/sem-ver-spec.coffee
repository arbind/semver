assert = require('assert')
SemVer = require "../js/sem-ver"


assertValidVersion = (versionString, expectedMajor, expectedMinor, expectedPatch, expectedPreRelease=null, expectedMetadata=null)->
  semver = SemVer.parse versionString
  console.log "-----" + semver.toString()
  assert.equal(semver.major, expectedMajor, "major version is incorrect [#{versionString}]")
  assert.equal(semver.minor, expectedMinor, "minor version is incorrect [#{versionString}]")
  assert.equal(semver.patch, expectedPatch, "patch version is incorrect [#{versionString}]")
  assert.equal(semver.preRelease, expectedPreRelease, "pre-release is incorrect [#{versionString}]")
  assert.equal(semver.metadata, expectedMetadata, "metadata is incorrect [#{versionString}]")
  assert.equal(versionString,semver.toString(), "to string [#{versionString}]")
  assert.equal(semver.isValid, true, "#{versionString} is invalid")
  semver

assertInvalidVersion = (versionString)->
  semver = new SemVer versionString
  assert.equal(semver.isValid, false, "#{versionString} should be invalid")
  semver


describe 'SemVer', ->
  context 'Valid Version Strings', ->
    it '0.0.0',       -> assertValidVersion "0.0.0", 0, 0, 0
    it '1.1.1-alpha', -> assertValidVersion "1.1.1-alpha", 1, 1, 1, "alpha"

  context 'Invalid Version Strings', ->
    it '0.0.0',  -> assertInvalidVersion "0.0.0 34"

    # SemVer 2
    # A normal version number MUST take the form X.Y.Z where X, Y, and Z are non-negative integers
    it '-1.1.1', -> assertInvalidVersion "-1.1.1"
    it '1.-1.1', -> assertInvalidVersion "1.-1.1"
    it '1.1.-1', -> assertInvalidVersion "1.1.-1"

    # SemVer 2
    # A normal version number MUST take the form X.Y.Z where X, Y, and Z MUST NOT contain leading zeroes.
    it '00.1.1', -> assertInvalidVersion "00.1.1"
    it '1.00.1', -> assertInvalidVersion "1.00.1"
    it '1.1.00', -> assertInvalidVersion "1.1.00"

    # Too many dashes
    it '1.1.1--alpha', -> assertInvalidVersion "1.1.1--alpha"
