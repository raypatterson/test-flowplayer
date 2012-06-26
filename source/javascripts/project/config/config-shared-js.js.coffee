@__set_project_namespace__ [ "AUDI", "PERFORMANCE" ]

_NS = @__get_project_namespace__()

_NS.Config ?= {}

_$win = $ 'window'

_ob = _NS.Config

_ob.buildNumber = "1"

_ob.touchOS = if typeof window.ontouchstart isnt 'undefined' then true else false

_ob.debug = true

if _ob.debug is true
  try
    console.log "I am build #{_ob.buildNumber}"
  catch e
    # No console

$win = $ window

_ob.loc = window.location
_ob.protocol = "#{_ob.loc.protocol}//"
_ob.port = if _ob.loc.port then ":#{_ob.loc.port}" else ""
_ob.url = "#{_ob.protocol}#{_ob.loc.hostname}#{_ob.port}"

_ob.FilePaths =
  mainData : "javascripts/project/data/main.json"