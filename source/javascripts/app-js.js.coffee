#= require ./vendor/_require-js
#= require ./lib/helpers/namespace-js
#= require ./project/config/_require-js
#= require ./lib/_require-js
#= require ./project/_require-js

_ob = @__get_project_namespace__ [ "Startup" ]

_doc = $ document

_doc.ready =>
  
  _ob.init -> Backbone.history.start()

  @