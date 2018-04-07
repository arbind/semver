class StringUtil
  @squish: (text)-> "#{text}".trim().replace /\s\s+/g, ' '

module.exports = StringUtil
