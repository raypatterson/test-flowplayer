_ob = @__get_project_namespace__ [ "Flowplayer" ]

class _ob.Progress
  
  _this = undefined
  _player = undefined
  _duration = undefined
  _onPlaybackUpdate = undefined
  _onProgressMilestone = undefined
  _frequency = 2000
  
  _timer = undefined
  _timerCount = 0
  _progress = 0
  _milestone25 = false
  _milestone50 = false
  _milestone75 = false
  _milestone100 = false
    
  _startTimer = ->
    
    _stopTimer()
    
    _timerCount = 0
    
    if _timer is undefined
      
      _timer = setInterval (->
        # just in case if it runs too many times...
        _timerCount += 1
    
        if _timerCount > 1500 then _stopProgressTimer()
    
        _duration = _player.getClip().fullDuration
        _progress = _player.getTime() / _duration
        
        _onPlaybackUpdate?.call null, _player, _progress
        
        # @log _progress
        _checkMilestone()
        ), _frequency
    
  _checkMilestone = ->
    if _progress > .25 and _progress <= .5 and _milestone25 is false
      _milestone25 = true
      _milestone50 = false
      _milestone75 = false
      _milestone100 = false
      _onProgressMilestone?.call null, _player, _this.PERCENT_25
    else if _progress > .5 and _progress <= .75 and _milestone50 is false
      _milestone25 = false
      _milestone50 = true
      _milestone75 = false
      _milestone100 = false
      _onProgressMilestone?.call null, _player, _this.PERCENT_50
    else if _progress > .75 and _progress <= .97 and _milestone75 is false
      _milestone25 = false
      _milestone50 = false
      _milestone75 = true
      _milestone100 = false
      _onProgressMilestone?.call null, _player, _this.PERCENT_75
    else if _progress > .97 and _progress <= 1 and _milestone100 is false
      _milestone25 = false
      _milestone50 = false
      _milestone75 = false
      _milestone100 = true
      _onProgressMilestone?.call null, _player, _this.PERCENT_100
      
    
  _stopTimer = ->
    _timerCount = 0
    _progress = 0
    _milestone25 = false
    _milestone50 = false
    _milestone75 = false
    _milestone100 = false
    
    if _timer then clearInterval _timer
    
    _timer = undefined
    
  PERCENT_25 : "percent_25"
  PERCENT_50 : "percent_50"
  PERCENT_75 : "percent_75"
  PERCENT_100 : "percent_100"
  
  constructor : (player, onPlaybackUpdate = undefined, onProgressMilestone = undefined, frequencey = 2000) -> 
    
    _this = @
    _player = player
    _onPlaybackUpdate = onPlaybackUpdate
    _onProgressMilestone = onProgressMilestone
    _frequency = frequencey
    
    @
    
  start : -> _startTimer()

  stop : -> _stopTimer()
  