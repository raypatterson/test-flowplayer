_NS = @__get_project_namespace__()

_log = _NS.log "Views"

_init = (callback) ->
  # _log "init"
  if _NS.Config.touchOS is true then $('body').addClass 'touch'
  callback()
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init