_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_setup = ->
  @ROUTER = _NS.navigationRouter
  @EVENT = _NS.eventBus
  @

_init = ->
  @addProperties()
  @addModels()
  @addViews()
  @addEvents()
  @renderViews()
  @
  
class _NS.BaseModule
    
  className : "BaseModule"
  NS : _NS
  MODELS : _MODELS
  ROUTER : undefined
  EVENT : undefined
  
  constructor : ->
    
    @log = _NS.log @className
    # @log "constructor"
    
    _setup.call @
    _init.call @
    
    @
    
  addProperties : ->
    # @log "addProperties"
    @

  addModels : ->
    # @log "addModels"
    @
    
  addViews : ->
    # @log "addViews"
    @
    
  addEvents : ->
    # @log "addEvents"
    @EVENT.on @EVENT.eventTypes.WINDOW_RESIZE, (width, height) =>
      # @log "#{w}, #{h}"
      @resize width, height
      @
    @
     
  renderViews : ->
    # @log "renderViews"
    
    @
  
  resize : (width, height) ->
    # @log "resize: #{width}, #{height}"
    @