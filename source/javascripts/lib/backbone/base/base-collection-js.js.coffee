_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_setup = ->
  @ROUTER = _NS.navigationRouter
  @EVENT = _NS.eventBus
  @

_init = ->
  @addProperties()
  @

class _NS.BaseCollection extends Backbone.Collection

  className : "BaseCollection"
  NS : _NS
  MODELS : _MODELS
  ROUTER : undefined
  EVENT : undefined
  
  initialize : ->
    @log = _NS.log @className
    # @log "initialize"
    
    _setup.call @
    _init.call @
    
    @

  addProperties : ->
    # @log "addProperties"
    @