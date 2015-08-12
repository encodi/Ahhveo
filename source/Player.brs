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
        videoList:[]
        startplayer: Start_Player
        previewmode:false
        setPlaylist:set_playlist
        setTrack:set_track
        play:play_videos
        track:0
        paintSleepMenu:paint_sleep_menu2
        isMenuUp:false
        repeat:false
        isFavorite:false
        alarmAnswer1:"No"
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
        paintSleepDetails:paint_sleep_details2
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
    m.canvas.SetMessageport(m.port)
    
    for i=0 to 999
        m.canvas.clearLayer(i)
    endfor
    m.canvas.SetLayer(1, {
                Color: "#00000000"
                TargetRect: {w:1280,h:720,x:0,y:0}
                CompositionMode: "Source"
            })
    'm.canvas.SetLayer(900, m.player)
    m.app.remoteListener=m

    m.player.SetMessageport(m.port)
    m.player.SetLoop(false)
    m.player.SetPositionNotificationPeriod(1)
    m.player.SetDestinationRect({ x:0, y:0, w:1280, h:720 })
    m.player.SetMaxVideoDecodeResolution(1280, 720)
    m.player.SetContentList([{
        Stream: { url: m.video }
        StreamFormat: "hls"
    }])
    'm.canvas.SetLayer(900, m.player)
    
    m.canvas.Show()
    m.paintSleepMenu()
    m.canvas.AllowUpdates(true)
    m.player.Play()'this start to play the video
    
end function

Function set_playlist(playlist)
    print "set playlist"
    'print playlist[0].stream.url
    m.videoList = playlist
    for each pl in playlist
        print pl
    end for
End Function

Function set_track(track)
    print "set track"
    m.track = track
    print track
End Function

Function play_videos()
    print "play"
    print m.videoList[m.track]
    m.video = m.videoList[m.track].stream.url
    m.startPlayer()
    m.eventloop()
    m.canvas.show()
    'm.paintSleepMenu()
End Function

Sub EventLoop4()
   
    while true
        msg = wait(320, m.port)
        

        if msg <> invalid

            if msg.isStatusMessage() and msg.GetMessage() = "startup progress"

                'm.paused = false
                'progress% = msg.GetIndex() / 10
                'if m.progress <> progress%
                '    m.progress = progress%
                '    m.paint()
                'end if

            else if msg.isPlaybackPosition()
                
                position = msg.GetIndex()
            
            endif
            
           if msg.isRemoteKeyPressed()
                
            index = msg.GetIndex()
            print index
            
            
            else if msg.isPaused()
                
               
            else if msg.isResumed()
               
            end if
            

        end if

    end while

End Sub



Sub SetupFullscreencanvas4()
    m.canvas.AllowUpdates(false)
    'sm.paint()
    m.canvas.AllowUpdates(true)
End Sub

Sub SetupFramedcanvas4()
    m.canvas.AllowUpdates(false)
    m.canvas.Clear()
    m.canvas.AllowUpdates(true)
End Sub

function paint_sleep_menu2(selected=2) as void

    print "painting menu"

    m.isMenuUp = true

    items = []
    positions = []

    if (IsHD())
        x_ = 220
    else
        x_ = 150
    endif

    for i=0 to 5
        if (IsHD())
           positions[i]={x:x_,y:580,w:100,h:100}
           x_=x_+150
        else
           positions[i]={x:x_,y:580,w:60,h:60}
           x_=x_+100
        endif
    end for

    positions.push({})
     if (IsHD())
        items.push({url:"pkg:/images/hide.png"
                 targetRect:{x:630,y:530,w:36,h:35}
                })
        items.push({url:"pkg:/images/mainmenu.png"
                targetRect:{x:220,y:580,w:100,h:100}
                })
        if (m.repeat)
          items.push({url:"pkg:/images/repeat_active.png"
                targetRect:{x:370,y:580,w:100,h:100}
                })
        else
          items.push({url:"pkg:/images/repeat.png"
                targetRect:{x:370,y:580,w:100,h:100}
                })
        endif
        if (NOT m.isFavorite)
            items.push({url:"pkg:/images/favorites.png"
                targetRect:{x:520,y:580,w:100,h:100}
                })
        else
            items.push({url:"pkg:/images/favorites_filled.png"
                targetRect:{x:520,y:580,w:100,h:100}
                })
        endif
        items.push({url:"pkg:/images/nextvideo.png"
                targetRect:{x:670,y:580,w:100,h:100}
                })
        items.push({url:"pkg:/images/sleep_active.png"
                targetRect:{x:820,y:580,w:100,h:100}
                })
        if (m.alarmAnswer1 = "Yes")
            items.push({url:"pkg:/images/videowakeup_active.png"
                targetRect:{x:970,y:580,w:100,h:100}
                })
        else
            items.push({url:"pkg:/images/videowakeup.png"
                targetRect:{x:970,y:580,w:100,h:100}
                })
        endif
     else
        items.push({url:"pkg:/images/hide.png"
                 targetRect:{x:630,y:530,w:36,h:35}
                })
        items.push({url:"pkg:/images/mainmenu.png"
                targetRect:{x:220,y:580,w:100,h:100}
                })
        if (m.repeat)
          items.push({url:"pkg:/images/repeat_active.png"
                targetRect:{x:370,y:580,w:100,h:100}
                })
        else
          items.push({url:"pkg:/images/repeat.png"
                targetRect:{x:370,y:580,w:100,h:100}
                })
        endif
        if (m.isfavorite)
            items.push({url:"pkg:/images/favorites.png"
                targetRect:{x:520,y:580,w:100,h:100}
                })
        else
            items.push({url:"pkg:/images/favorites_filled.png"
                targetRect:{x:520,y:580,w:100,h:100}
                })
        endif
        items.push({url:"pkg:/images/nextvideo.png"
                targetRect:{x:670,y:580,w:100,h:100}
                })
        items.push({url:"pkg:/images/sleep_active.png"
                targetRect:{x:820,y:580,w:100,h:100}
                })
        if (m.alarmAnswer1 = "Yes")
            items.push({url:"pkg:/images/videowakeup_active.png"
                targetRect:{x:970,y:580,w:100,h:100}
                })
        else
            items.push({url:"pkg:/images/videowakeup.png"
                targetRect:{x:970,y:580,w:100,h:100}
                })
        endif
     endif

     items.push({url:"pkg:/images/ringplayer.png", targetRect: positions[selected]})

    m.canvas.setLayer(940, items)
    m.paintsleepdetails()
    m.canvas.show()

end function


function paint_sleep_details2() as void

    'm.canvas.SetLayer(951, { Color: "#50000000", targetRect: {x:220,y:685,w:850,h:30} })
    m.canvas.setLayer(951, { url:"pkg:/images/player_bottom.png", targetRect:{x:220,y:680,w:850,h:30} })
    'dstominutes = Cint((m.darkscreentimer - m.position)/60)
    dstominutes = 10
    if (dstominutes>0)
        dstominutes = Str(dstominutes)
    else
        dstominutes = "0"
    endif
    if (m.alarmAnswer1="Yes")
        x_ = 350
    else
        x_ = 500
    endif
    
    'if (m.wakeuptime[0].toInt()>11 AND m.wakeuptime[0].toInt()<24)
    '  daytime = "pm"
    '  hr = m.wakeuptime[0].toInt() - 12
    '  if (hr=0) hr = 12
    'else
    '  daytime = "am"
    '  hr = m.wakeuptime[0].toInt()
    'endif
    
    'if (hr=24) hr=0
    timetodarkscreentext = {text: "Time to dark screen: "+dstominutes+" min.", textAttrs: {Color: "#FFFFFF",font: m.app.h4}, targetRect:{x:x_,y:681,w:300,h:30}}
    'videowakeuptext = {text: "Video Wake Up: "+hr.toStr()+":"+m.wakeuptime[1]+" "+daytime, textAttrs: {Color: "#FFFFFF",font: m.app.h4}, targetRect:{x:670,y:683,w:300,h:30}}
    m.canvas.setLayer(952, timetodarkscreentext)
    'if (m.alarmAnswer1="Yes") m.canvas.setLayer(953, videowakeuptext)
end function


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
