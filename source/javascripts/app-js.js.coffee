#= require ./lib/helpers/namespace-js
#= require ./vendor/zepto.min
#= require ./vendor/flowplayer-3.2.10.min
#= require ./lib/media/flowplayer/_require-js

_ob = @__get_project_namespace__ [ "Flowplayer" ]

_doc = $ document

_doc.ready =>
  
  props = new _ob.Props()
  props.onResume = (player) -> console.log "onResume"
  props.onPause = (player) -> console.log "onPause"
  props.onMute = (player) -> console.log "onMute"
  props.onUnmute = (player) -> console.log "onUnmute"
  props.onProgressUpdate = (player, progress) -> console.log "onProgressUpdate", progress
  props.onProgressMilestone = (player, percent) -> console.log "onProgressMilestone", percent
    
  player = new _ob.Player props
  
  play_btn = $ "#play_btn"
  play_btn.click (event) -> player.playVideo()
  
  pause_btn = $ "#pause_btn"
  pause_btn.click (event) -> player.pauseVideo()
  
  mute_btn = $ "#mute_btn"
  mute_btn.click (event) -> player.muteSound()
  
  unmute_btn = $ "#unmute_btn"
  unmute_btn.click (event) -> player.unmuteSound()
  
  @