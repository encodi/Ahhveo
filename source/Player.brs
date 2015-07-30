' ********************************************************************
' ********************************************************************
' **  Roku Custom Video player2 Channel (BrightScript)
' **
' **  May 2010
' **  Copyright (c) 2010 Roku Inc. All Rights Reserved.
' ********************************************************************
' ********************************************************************


Function NewPlayer(s) As Object
    this = {
        app:s
        port:      CreateObject("roMessageport")
        progress:  0 'buffering progress
        position:  0 'playback position (in seconds)
        paused:    false 'is the video currently paused?
        fonts:     CreateObject("roFontRegistry") 'global font registry
        canvas:    CreateObject("roImagecanvas") 'user interface
        player:    CreateObject("roVideoplayer")
        setup:     SetupFramedcanvas4
        paint:     PaintFramedcanvas4
        eventloop: EventLoop4
        layout: invalid
        video: " "
        startplayer: Start_Player
        previewmode:false
        setPlaylist:set_playlist
        setTrack:set_track
        play:play_videos
        'darkscreentimer: darkscreentimer
        'darkscreensaver: darkscreensaver
        'soundfile: soundfile
        'finaltime:-1
        'soundindex: soundindex
        'issleeping:false
        'sleepingtimer:CreateObject("roTimespan")
        'sleeptimeduration:sleeptimeduration
        'paintsleepmenu:paint_sleep_menu
        'hidesleepmenu:hide_sleep_menu
        'paintDarkScreenSaver:paint_dark_screensaver
        'paintSleepDetails:paint_sleep_details
        'stopsound:false
        'alarmtimer:invalid
        'wakeuptime:wakeuptime
        'downloaddifftime:0
        'difftotaltimeleft:0
        'startsalarm:false
        'wakeupvideo:wakeupvideo
        'inAlarmVideo:false
        'wakeupvideoduration:wakeupvideoduration
        'sleepmenuindex:2
        'isMenuUp:false
        'isMenuDown:false
        'autoshutofftimer:10800
        'soundicon:invalid
        'alarmanswer1:alarmanswer1
        'alarmchimewhen:acw
        'inAlarmSound:false
        'showsleepinterruption:show_sleep_alarm_interruption
        'insleepdialog:false
        'response:false
        'ipositions:[]
        'iring:[]
        'alarmchime:alarmchime
        'wakeupalarmsound:wakeupalarmsound
        'inafteralarm:false
        'repeat:false
        'duration:0
        'isFavorite:false
    }

    return this
End Function

Function Start_Player() 
      'Setup image canvas2:
    m.canvas.SetMessageport(m.port)
    m.canvas.SetLayer(911, { Color: "#000000" })

    m.app.remoteListener=this

    'Resolution-specific settings:
    mode = CreateObject("roDeviceInfo").GetDisplayMode()
    if mode = "720p"
        m.layout = {
            full:   m.canvas.GetcanvasRect()
            top:    { x: 0, y: 0, w:1280, h: 720 }
            left:   { x: 0, y: 0, w: 1280, h: 720 }
            right:  { x: 700, y: 177, w: 350, h: 291 }
            bottom: { x: 249, y: 500, w: 780, h: 300 }
        }

    else
        m.layout = {
            full:   m.canvas.GetcanvasRect()
            top:    { x: 0, y: 0, w: 1280, h: 720  }
            left:   { x: 0, y: 0, w: 1280, h: 720 }
            right:  { x: 400, y: 100, w: 220, h: 210 }
            bottom: { x: 100, y: 340, w: 520, h: 140 }
        }

    end if

    m.canvas.Show()

    m.player.SetMessageport(this.port)
    m.player.SetLoop(false)
    m.player.SetPositionNotificationPeriod(1)
    m.player.SetDestinationRect(this.layout.left)
    m.player.SetMaxVideoDecodeResolution(1280,720)
    m.player.SetContentList([{
        Stream: { url: "http://wpc.b624.edgecastcdn.net/00B624/"+m.video}
        StreamFormat: "hls"
    }])

    m.app.audio.player.stop()

    m.player.Play()'this start to play the video
end function

Function set_playlist(playlist)
    print "set playlist"
    'print playlist[0].stream.url
    for each pl in playlist
        print pl
    end for
End Function

Function set_track(track)
    print "set track"
    print track
End Function

Function play_videos()
    print "play"
End Function

Sub EventLoop4()
   
    while true
        msg = wait(320, m.port)
        

        if msg <> invalid

            

           if msg.isRemoteKeyPressed()
                


            else if msg.isPaused()
                
               
            else if msg.isResumed()
               
            end if
            

        end if

    end while

End Sub



Sub SetupFullscreencanvas4()
    m.canvas.AllowUpdates(false)
    m.paint()
    m.canvas.AllowUpdates(true)
End Sub

Sub SetupFramedcanvas4()
    m.canvas.AllowUpdates(false)
    m.canvas.Clear()
    m.canvas.AllowUpdates(true)

End Sub


Sub PaintFramedcanvas4()
    list = []
    if m.progress < 100  'Video is currently buffering
        list.Push({
            Color: "#80000000"
            TargetRect: m.layout.left
        })
        list.Push({
            Text: "Loading...",' + m.progress.tostr() + "%"
            TextAttrs: { font: m.app.h3 },
            TargetRect: m.layout.left
        })
    else  'Video is currently playing
        if m.paused
            list.Push({
                Color: "#80000000"
                TargetRect: m.layout.left
                CompositionMode: "Source"
            })
            list.Push({
                Text: "Paused"
                TargetRect: m.layout.left
            })
        else  'not paused
            list.Push({
                Color: "#00000000"
                TargetRect: m.layout.left
                CompositionMode: "Source"
            })
        end if
    end if
    m.canvas.SetLayer(199, list)



End Sub
