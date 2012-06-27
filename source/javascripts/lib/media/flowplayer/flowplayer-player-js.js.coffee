_ob = @__get_project_namespace__ [ "Flowplayer" ]

class _ob.Player
  
  _this = undefined
  # Player Props
  _playerProps = undefined
  _progress = undefined 
  
  # Proprties
  _flowplayer = $f
  _win = window
  _doc = _win.document
  _player = undefined
  
  # Flags
  _isLoaded = false
  _isPaused = false
  
  _log = ->
    try
      console.log "[Flowplayer]", arg for arg in arguments
    catch e
      # no console
    @
  
  _load = ->
    _log "Player init"
    
    debug = _playerProps.debug
    
    backgroundImage = "url(http://s3.amazonaws.com/test-campaign/" + _playerProps.backgroundImage + ")"
    
    content =
      url : "assets/flash/flowplayer.content-3.2.8.swf"
      top : 0
      left : 0
      width : 400
      height : 150
      backgroundColor : 'transparent'
      backgroundGradient : 'none'
      border : 0
      textDecoration : 'outline'
      style :
        body :
          fontSize : 14
          fontFamily : 'Arial'
          textAlign : 'center'
          color : '#FFFFFF'
    
    config = 
      clip :
        urlResolvers : "bwcheck"
        provider : 'rtmp'
        scaling : 'fit'
        autoPlay : _playerProps.autoplay
        bitrates : _playerProps.bitrates
        onPlay : _onPlay
        onPause : _onPause
        onResume : _onResume
        

      play :
        opacity : 0.0
        label : null
        replayLabel : null
        
      canvas :
        backgroundGradient : "none"
        backgroundColor : "#FFFFFF"
        # backgroundImage: backgroundImage
        
      onKeypress : -> return
      onLoad : _onLoad
      onUnload : _onUnload
      onMute : _onMute
      onUnmute : _onUnmute
      onStart : _onStart
      onFinish : _onFinish
                  
      plugins :
        content : if debug then content else null
        
        controls : null
        
        bwcheck :
          url : "/assets/flash/flowplayer.bwcheck-3.2.10.swf"
          serverType : 'fms'
          dynamic : true
          netConnectionUrl : _playerProps.netConnectionUrl
          
          onStreamSwitchBegin : (newItem, currentItem) ->
            if debug then _flowplayer().getPlugin('content').setHtml("Will switch to: " + newItem.streamName + " from " + currentItem.streamName)
            
          onStreamSwitch : (newItem) ->
            if debug then _flowplayer().getPlugin('content').setHtml("Switched to: " + newItem.streamName)

        rtmp :
          url : '/assets/flash/flowplayer.rtmp-3.2.10.swf'
          netConnectionUrl : _playerProps.netConnectionUrl
        
    _flowplayer _playerProps.playerTargetId, _playerProps.embedParams, config
    @
  
  _onLoad = ->
    _log 'onLoad'
    
    _isPaused = !_playerProps.autoplay
    _isLoaded = true
    _player = _flowplayer _playerProps.playerTargetId
    _progress = new _ob.Progress _player, _playerProps.onProgressUpdate, _playerProps.onProgressMilestone, 500
    
    if _playerProps.debug is true 
      _flowplayer().mute()
    else
      _flowplayer().unmute()
    
    _playerProps.onLoad?.call null, _this
    @
  
  _onUnload = ->
    _log 'onUnloaded'
    _playerProps.onUnload?.call null, _this
    @
  
  _onPlay = ->
    _log 'onPlay'
    _progress.start()
    _playerProps.onPlay?.call null, _this
    @
  
  _onResume = ->
    _log 'onResume'
    _progress.start()
    _playerProps.onResume?.call null, _this
    @
  
  _onPause = ->
    _log 'onPause'
    _progress.stop()
    _playerProps.onPause?.call null, _this
    @
  
  _onMute = ->
    _log 'onMute'
    _playerProps.onMute?.call null, _this
    @
  
  _onUnmute = ->
    _log 'onUnmute'
    _playerProps.onUnmute?.call null, _this
    @
  
  _onStart = ->
    _log 'onStart'
    _progress.start()
    _playerProps.onStart?.call null, _this
    @
  
  _onFinish = ->
    _log 'onFinish'
    
    if _playerProps.autoreplay is true 
      _log 'autoreplay'
      _player.seek(0)
      _player.play()
    else if _playerProps.autoreset is true 
      _log 'autoreset'
      _player.seek(0)
      _player.pause()
    else
      _log 'rest'
      _player.pause()

    _playerProps.onFinish?.call null, _this
    @
    
  # Public methods
  constructor : (playerProps) ->
    
    _this = @
    
    _playerProps = playerProps or new _ob.Initializer
    
    _load()
    
    @
  
  playVideo : ->
    _log "playVideo"
  
    if not _isPaused then return
    
    _isPaused = false
    
    _player.show()
    _player.play()
    _player.resume()
    
    @
  
  pauseVideo : ->  
    _log "pauseVideo"
    
    if _isPaused then return
    
    _isPaused = true
    
    _player.pause()
    
    @
  
  muteSound : ->
    _log "muteSound"
    _player.mute()
    @
  
  unmuteSound : ->  
    _log "unmuteSound"
    _player.unmute()
    @
  
  seekTo : (seconds) ->
    _log "SEEK VIDEO : #{seconds}"
    _player.seek seconds
    
    @
  
  getProgress : -> _progress