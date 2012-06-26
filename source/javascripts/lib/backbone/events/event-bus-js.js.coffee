_NS = @__get_project_namespace__()
_NS.EventBus = ->
  
  _.extend @, Backbone.Events
  
  @eventTypes = 
    WINDOW_RESIZE : "window_resize"
    
  @