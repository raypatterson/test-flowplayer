_NS = @__get_project_namespace__()

_log = _NS.log "Events"

_init = (callback) ->
  _NS.eventBus = new _NS.EventBus
  _NS.navigationRouter = new _NS.NavigationRouter
  _initResize()
  callback()

_initResize = ->
  $(window).resize ->
    w = $(@).width()
    h = $(@).height()
    # @log "width: #{w}, height: #{h}"
    _NS.eventBus.trigger 'window:resize', w, h
  @
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init