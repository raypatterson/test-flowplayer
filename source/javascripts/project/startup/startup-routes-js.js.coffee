_NS = @__get_project_namespace__()

_log = _NS.log "Routes"

_init = (callback) ->
  callback()
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init