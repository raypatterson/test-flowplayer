window.DeviceRedirect = class DeviceRedirect
  constructor: (@platforms, @envRegEx, @ignoreList...) ->

  init: ->
    @currentLocation = window.location.href.toLowerCase()
    @isHere = if @currentLocation.match @envRegEx then true else false

    ismobile = (/iphone|ipod|android|blackberry|opera mini|opera mobi|windows phone|palm|iemobile/i.test(navigator.userAgent.toLowerCase()))
    istablet = (/ipad|tablet/i.test(navigator.userAgent.toLowerCase()))
    isdesktop = if ismobile or istablet then false else true
    @isThis =
      "mobile":   ismobile
      "tablet":   istablet
      "desktop":  isdesktop

    @shouldIgnore = false

    if @ignoreList?
      for href in @ignoreList
        @shouldIgnore = true if @currentLocation.match href
    @

  go: ->
    if @currentLocation.match(/localhost/g) or @currentLocation.match(/localtunnel/g) or @shouldIgnore
      console.log "Ignoring this location"
    else
      for platform, location of @platforms
        location = location.toLowerCase()
        notAlreadyThere = if @currentLocation.match(location) then false else true
        if @isThis["#{platform}"] and notAlreadyThere
          window.location = "http://#{location}"
    @

setTimeout ->
  window.devRedirect = new DeviceRedirect(
    mobile: "dev-m.audiLEDs.com"
    tablet: "dev.audiLEDs.com"
    desktop: "dev.audiLEDs.com"
  , /dev/g).init()

  window.stagingRedirect = new DeviceRedirect(
    mobile: "staging-m.audiLEDs.com"
    tablet: "staging.audiLEDs.com"
    desktop: "staging.audiLEDs.com"
  , /staging/g).init()

  window.productionRedirect = new DeviceRedirect(
    mobile: "m.audiLEDs.com"
    tablet: "www.audiLEDs.com"
    desktop: "www.audiLEDs.com"
  , null, "origin.audileds.com").init()

  if devRedirect.isHere
    devRedirect.go()
  else if stagingRedirect.isHere
    stagingRedirect.go()
  else
    productionRedirect.go()

, 500