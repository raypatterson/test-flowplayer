_NS = @__get_project_namespace__()

_log = _NS.log "Models"

_models = @__get_project_namespace__ [ "Models" ]

_mainData = undefined

_loadData = (callback) ->
  
  url = _NS.Config.FilePaths.mainData
  
  _NS.Loader.getJSON url, ((response) ->
    
    _mainData = response
    
    callback()
    
    ), (error) ->
      
      _log "[ Main data failed to load ]"
      
      callback()
  
_addModels = (callback) ->
  
  callback()

_init = (callback) ->
  
  Nimble.parallel [
    _loadData
    _addModels
  ], callback
  
  @
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init