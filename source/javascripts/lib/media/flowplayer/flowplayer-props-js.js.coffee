_ob = __get_project_namespace__ [ "Flowplayer" ]

class _ob.Props
  # Player params
  playerTargetId : "video_player"
  netConnectionUrl : "rtmp://sxklecysxlor2.cloudfront.net/cfx/st"
  bucketName : "test-campaign"
  backgroundImage : "test-poster.jpg"
  bitrates : [
    url : "mp4:test-800"
    width : 960
    bitrate : 800
    isDefault : true
  ,          
    url : "mp4:test-1200"
    width : 960,
    bitrate : 1200
  ,  
    url : "mp4:test-1600"
    width : 960,
    bitrate : 1600
  ]
  debug : false
  autoplay : false
  controls : false
  autohide : true
  autoreset : true
  autoreplay : false
  embedParams :
    src : "/assets/flash/flowplayer-3.2.11.swf"
    bgcolor : "#FFFFFF"
    width : "100%"
    height : "100%"
    wmode : "window"
    allowfullscreen : true
    allowscriptaccess : "samedomain"
    quality : "best"
    onFail : undefined
  # Event handlers
  onLoad : undefined
  onUnload : undefined
  onPlay : undefined
  onPause : undefined
  onMute : undefined
  onUnmute : undefined
  onStart : undefined
  onFinish : undefined
  onProgressUpdate : undefined
  onProgressMilestone : undefined
