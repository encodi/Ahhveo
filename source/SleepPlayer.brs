' ********************************************************************
' ********************************************************************
' **  Roku Custom Video player2 Channel (BrightScript)
' **
' **  May 2010
' **  Copyright (c) 2010 Roku Inc. All Rights Reserved.
' ********************************************************************
' ********************************************************************


Function SleepPlayer(h, s, v, darkscreentimer, soundfile, soundindex, darkscreensaver, sleeptimeduration, wakeuptime, wakeupvideo, wakeupvideoduration, alarmanswer1, acw, alarmchime, wakeupalarmsound) As Object
    this = {
        h:h
        app:s
        port:      CreateObject("roMessageport")
        progress:  0 'buffering progress
        position:  0 'playback position (in seconds)
        paused:    false 'is the video currently paused?
        fonts:     CreateObject("roFontRegistry") 'global font registry
        canvas:    CreateObject("roImagecanvas") 'user interface
        player:    CreateObject("roVideoplayer")
        setup:     SetupFramedcanvas3
        paint:     PaintFramedcanvas3
        eventloop: EventLoop3
        layout: invalid
        video: v
        darkscreentimer: darkscreentimer
        darkscreensaver: darkscreensaver
        soundfile: soundfile
        finaltime:-1
        soundindex: soundindex
        issleeping:false
        sleepingtimer:CreateObject("roTimespan")
        sleeptimeduration:sleeptimeduration
        paintsleepmenu:paint_sleep_menu
        hidesleepmenu:hide_sleep_menu
        paintDarkScreenSaver:paint_dark_screensaver
        paintSleepDetails:paint_sleep_details
        stopsound:false
        alarmtimer:invalid
        wakeuptime:wakeuptime
        downloaddifftime:0
        difftotaltimeleft:0
        startsalarm:false
        wakeupvideo:wakeupvideo
        inAlarmVideo:false
        wakeupvideoduration:wakeupvideoduration
        sleepmenuindex:2
        isMenuUp:false
        isMenuDown:false
        autoshutofftimer:10800
        soundicon:invalid
        alarmanswer1:alarmanswer1
        alarmchimewhen:acw
        inAlarmSound:false
        showsleepinterruption:show_sleep_alarm_interruption
        insleepdialog:false
        response:false
        ipositions:[]
        iring:[]
        alarmchime:alarmchime
        wakeupalarmsound:wakeupalarmsound
        inafteralarm:false
        repeat:false
        duration:0
        isFavorite:false
    }


    'Setup image canvas2:
    this.canvas.SetMessageport(this.port)
    this.canvas.SetLayer(911, { Color: "#000000" })

    this.darkscreentimer = this.darkscreentimer

    this.app.remoteListener=this

'this.app.remoteListener=this
    'Resolution-specific settings:
    mode = CreateObject("roDeviceInfo").GetDisplayMode()
    if mode = "720p"
        this.layout = {
            full:   this.canvas.GetcanvasRect()
            top:    { x: 0, y: 0, w:1280, h: 720 }
            left:   { x: 0, y: 0, w: 1280, h: 720 }
            right:  { x: 700, y: 177, w: 350, h: 291 }
            bottom: { x: 249, y: 500, w: 780, h: 300 }
        }

    else
        this.layout = {
            full:   this.canvas.GetcanvasRect()
            top:    { x: 0, y: 0, w: 1280, h: 720  }
            left:   { x: 0, y: 0, w: 1280, h: 720 }
            right:  { x: 400, y: 100, w: 220, h: 210 }
            bottom: { x: 100, y: 340, w: 520, h: 140 }
        }

    end if

    this.canvas.Show()

    this.player.SetMessageport(this.port)
    this.player.SetLoop(false)
    this.player.SetPositionNotificationPeriod(1)
    this.player.SetDestinationRect(this.layout.left)
    this.player.SetMaxVideoDecodeResolution(1280,720)
    this.player.SetContentList([{
        Stream: { url: "http://wpc.b624.edgecastcdn.net/00B624/"+v.video_url }
        StreamFormat: "hls"
    }])

    this.app.audio.player.stop()
    'this.canvas.AllowUpdates(true)


    this.player.Play()'this start to play the video

    return this
End Function

Sub EventLoop3()
    timecount = 0
    while true
        msg = wait(320, m.port)
        if (m.issleeping)
            timecount = timecount + 1 'cada 4 timecount es un segundo
            if (timecount MOD 20 = 0)
                ' randomize screensaver logo
                m.paintDarkScreensaver(m.darkscreensaver)
                m.app.ticklesmall()
            endif
            if (timecount >= (m.sleeptimeduration*60*4 - m.downloaddifftime) AND m.stopsound=false)
                ' stop sound
                m.app.audio.stop()
                m.stopsound=true
            endif
            ' wake up
            if (timecount >= (m.difftotaltimeleft*4) AND m.startsalarm=false AND m.inAlarmVideo=false AND m.alarmAnswer1="Yes")
                m.issleeping = false
                m.stopsound=false
                m.startsalarm = true
                m.inAlarmVideo = true
                m.app.sleeping = false
                timecount = 0
                m.app.audio.stop()
                m.player.stop()
                m.canvas.clearLayer(932)
                m.canvas.clearLayer(933)
                m.canvas.clearLayer(937)
                m.canvas.clearLayer(942)
                ''
                ' shots alarm sound here before video
                ''
                print "m.alarmchimewhen"
                print m.alarmchimewhen
                print type(m.alarmchimewhen)
                if (m.alarmchimewhen=0)
                    if (m.inAlarmSound=false)
                        m.inAlarmSound=true
                        'plays alarm
                        sleep(1000)
                        print "plays alarm before video"
                        print m.wakeupalarmsound
                        DownloadFile(m.wakeupalarmsound.url,"alarm.mp3")
                        m.app.audio.play(m.wakeupalarmsound.url,"alarm.mp3")
                    endif
                else if (m.alarmchimewhen=1 OR m.alarmchimewhen=2)
                    print "video to play"
                    print m.wakeupvideo.video_url
                    m.inafteralarm=true
                    sleep(1000)
                    m.player.SetContentList([{
                        Stream: { url: "http://wpc.b624.edgecastcdn.net/00B624/"+m.wakeupvideo.video_url }
                        StreamFormat: "hls"
                    }])
                    m.player.Play()'this start to play the video tutorial
                endif
                print "waking up"
                print msg
            endif
        else
            ' repeat
            if (timecount >= m.duration AND m.repeat)
                print "repeating"
                m.app.audio.stop()
                m.player.stop()
                sleep(1000)
                m.player.SetContentList([{
                    Stream: { url: "http://wpc.b624.edgecastcdn.net/00B624/"+m.video }
                    StreamFormat: "hls"
                }])
                m.player.Play()
            endif
        endif

        if msg <> invalid

            'If this is a startup progress status message, record progress
            'and update the UI accordingly:

            if msg.isStatusMessage() and msg.GetMessage() = "startup progress"
                m.paused = false
                progress% = msg.GetIndex() / 10
                if m.progress <> progress%
                    m.progress = progress%
                    m.paint()
                end if

            'Playback progress (in seconds):
            else if msg.isPlaybackPosition()
                m.position = msg.GetIndex()
                if (m.inAfterAlarm OR m.inAlarmSound)
                    if (m.position>((m.wakeupvideoduration-1)*60))
                        m.app.audio.stop()
                        m.player.stop()
                        'play video wakeup
                        sleep(1000)
                        if (m.inafteralarm)
                            DownloadFile(m.wakeupalarmsound.url,"alarm.mp3")
                            m.app.audio.play(m.wakeupalarmsound.url,"alarm.mp3")
                        else
                            m.player.SetContentList([{
                                Stream: { url: "http://wpc.b624.edgecastcdn.net/00B624/"+m.wakeupvideo.video_url }
                                StreamFormat: "hls"
                            }])
                            m.player.Play()'this start to play the video tutorial
                        endif
                    endif
                endif
                if (m.position=0 AND m.issleeping=false AND m.isMenuUp=false)
                    m.paintSleepMenu(m.sleepmenuindex)
                endif
                if (m.position>0 AND (m.position MOD 10 = 0) AND m.issleeping=false AND m.isMenuUp=true)
                    m.hidesleepmenu()
                endif
                if (m.position>0 AND (m.position MOD 21 = 0) AND m.issleeping=false AND m.isMenuDown=true)
                    m.canvas.clearLayer(940)
                    m.isMenuDown=false
                endif
                print m.position

                if (m.position>=(m.player.GetPlaybackDuration()-1) AND m.issleeping=false) ' end of video
                    print "video is over"
                endif

                if (m.position>m.wakeupvideoduration*60 AND m.inAlarmVideo=true)
                   m.app.hideScreenSaver()
                   m.app.audio.stop()
                   m.player.stop()
                   m.canvas.Clear()
                   m.canvas.clearLayer(911)
                   m.canvas.clearLayer(199)
                   m.player.ClearContent()
                   m.canvas.close()
                   m.app.sleeping = false
                   m.issleeping = false
                   m.app.remoteListener=m.h
                   return
                endif

                if (m.position>m.darkscreentimer AND m.issleeping=false AND m.inAlarmVideo=false)
                    print "go to screensaver"
                    m.player.Stop()
                    m.canvas.clearLayer(940)
                    m.paintDarkScreensaver(m.darkscreensaver)
                    print m.soundfile
                    downloadtime = CreateObject("roTimespan")
                    downloadtime.Mark()
                    loadingtext = {text: "Loading Audio Sample...", textAttrs: {Color: "#666666",font: m.app.h3}, targetRect:{x:450,y:350,w:400,h:38}}
                    m.canvas.setLayer(937, loadingtext)
                    if (m.soundfile<>"No Sound")
                        m.soundicon = {url:"pkg:/images/soundicon.png", targetRect:{x:1200, y: 30, w:32, h: 32}}
                        m.canvas.setLayer(942, m.soundicon)
                        DownloadFile("http://ahhveo.com/_dev/sounds/"+m.soundfile,"sleep.wma")
                        m.app.audio.play("http://ahhveo.com/_dev/sounds/"+m.soundfile,"sleep.wma")
                    endif
                    m.canvas.clearLayer(937)
                    m.downloaddifftime = downloadtime.TotalSeconds()
                    m.issleeping = true
                    m.stopsound = false
                    m.startsalarm = false
                    ' here we mark the time to start countind down for alarm
                    m.alarmtimer = CreateObject("roTimespan")
                    m.alarmtimer.Mark()

                    currentdate = CreateObject("roDateTime")
                    currentdate.ToLocalTime()

                    actualyear = currentdate.GetYear().toStr()
                    actualmonth = currentdate.GetMonth().toStr()
                    actualday = currentdate.GetDayOfMonth().toStr()
                    actualhours = currentdate.GetHours().toStr()
                    actualminutes = currentdate.GetMinutes().toStr()

                    wyear = actualyear
                    wmonth = actualmonth
                    wday = actualday
                    whour = m.wakeuptime[0]
                    wminute = m.wakeuptime[1]

                    whour = whour.toInt()
                    actualhours = actualhours.toInt()

                    wminute = wminute.toInt()
                    actualminutes = actualminutes.toInt()

                    diffhours = whour - actualhours
                    diffminutes = wminute - actualminutes

                    if (diffhours<0)
                        diffhours = 24 + diffhours
                    endif

                    if (diffminutes<0)
                        diffminutes = 60 + diffminutes
                        if (diffhours=0)
                            diffhours = 24
                        endif
                        if (diffhours>0) diffhours = diffhours - 1
                    endif

                    print "difference in hours for alarm"
                    print diffhours
                    print "difference in minutes for alarm"
                    print diffminutes

                    'convert hours to minutes to seconds
                    diffhourstoseconds = diffhours * 60 * 60
                    diffminutestoseconds = diffminutes * 60
                    m.difftotaltimeleft = diffhourstoseconds + diffminutestoseconds

                    print "total seconds left to start the alarm"
                    print m.difftotaltimeleft

                endif

           else if msg.isRemoteKeyPressed()
                if(m.app.deviceinfo.getLinkStatus()=false) m.app.dialog.alert2("Your connection to the server was lost. Try checking your network settings. Thank you.")
                index = msg.GetIndex()
                print index
                if (index<>32 AND m.insleepdialog=false)
                   print index
                   if (m.inAlarmSound OR m.inAfterAlarm)
                        ' stop the alarm sound and start the video
                        m.app.audio.stop()
                        m.player.stop()
                        m.inAlarmSound=false
                        sleep(1000)
                        m.player.SetContentList([{
                            Stream: { url: "http://wpc.b624.edgecastcdn.net/00B624/"+m.wakeupvideo.video_url }
                            StreamFormat: "hls"
                        }])
                        m.player.Play()'this start to play the video
                        m.inAfterAlarm = false
                        m.inAlarmSound = false
                   endif
                   if ((index=7 or index=10) AND m.inAlarmSound=false AND m.inAfterAlarm=false) ' back
                    'm.alarmanswer1="Yes" AND
                       'if (m.insleepdialog = false)
                            print "show dialog"
                            m.insleepdialog = true
                            m.showsleepinterruption("A Wake Up Video alarm has been set, continue the sequence or exit to cancel it.")
                       'endif

                  else if (index=2 AND m.isMenuUp=false AND m.issleeping=false AND m.inAlarmSound=false AND m.inAfterAlarm=false) ' up
                    m.paintSleepMenu(m.sleepmenuindex)
                  else if (index=3 AND m.isMenuUp=true AND m.issleeping=false AND m.inAlarmSound=false AND m.inAfterAlarm=false) ' down
                    m.hidesleepmenu()
                  else if (index=4 AND m.isMenuUp=true AND m.issleeping=false AND m.inAlarmSound=false AND m.inAfterAlarm=false) ' left
                    if (m.sleepmenuindex>0)
                        m.sleepmenuindex = m.sleepmenuindex - 1
                    endif
                    m.paintSleepMenu(m.sleepmenuindex)
                  else if (index=5 AND m.isMenuUp=true AND m.issleeping=false AND m.inAlarmSound=false AND m.inAfterAlarm=false) ' right
                    if (m.sleepmenuindex<5)
                        m.sleepmenuindex = m.sleepmenuindex + 1
                    endif
                    m.paintSleepMenu(m.sleepmenuindex)
                  else if (index=6 AND m.isMenuUp=true AND m.issleeping=false AND m.inAlarmSound=false AND m.inAfterAlarm=false) ' OK
                      if (m.sleepmenuindex=0) ' menu to exit
                          m.app.hideScreenSaver()
                          m.app.audio.stop()
                          m.player.stop()
                          m.canvas.Clear()
                          m.canvas.clearLayer(911)
                          m.canvas.clearLayer(199)
                          m.canvas.clearLayer(942)
                          m.player.ClearContent()
                          m.canvas.close()
                          m.app.sleeping = false
                          m.issleeping = false
                          m.app.remoteListener=m.h
                          return
                      else if (m.sleepmenuindex=1) ' repeat
                          m.duration = m.player.GetPlaybackDuration() 'duration of video
                          print (duration)
                          if (m.repeat)
                            m.repeat=false
                          else
                            m.repeat=true
                          endif
                          m.paintSleepMenu(m.sleepmenuindex)
                      else if (m.sleepmenuindex=2) ' favorite
                          if (m.inAlarmVideo)
                            print m.wakeupvideo
                          else
                            print m.video
                          endif
                          if (m.isfavorite) 
                            m.isfavorite=false
                          else
                            m.isfavorite=true
                          endif
                          m.paintSleepMenu(m.sleepmenuindex)
                      else if (m.sleepmenuindex=3) ' next

                      else if (m.sleepmenuindex=4) ' sleep

                      else if (m.sleepmenuindex=5) ' video wake up

                      endif
                  endif

                else if (index<>32 AND m.insleepdialog=true)
                    'Move Left or right
                    if(index=4 or index=5)

                        if(m.response)
                            m.response=false
                            ringposition=1
                         else
                            m.response=true
                            ringposition=0
                        endif

                        if (IsHD())
                            m.iring.targetRect={x:m.ipositions[ringposition].x,y:m.ipositions[ringposition].y+28,w:m.ipositions[ringposition].w,h:2}
                        else
                            m.iring.targetRect={x:m.ipositions[ringposition].x,y:m.ipositions[ringposition].y+19,w:m.ipositions[ringposition].w,h:2}
                        endif

                       m.canvas.setLayer(995,m.iring)

                    else if(index=0 or index=7 or index=10 OR index=6)

                        if (m.response)
                            m.canvas.clearLayer(991)
                            m.canvas.clearLayer(992)
                            m.canvas.clearLayer(993)
                            m.canvas.clearLayer(994)
                            m.canvas.clearLayer(995)
                            m.insleepdialog=false
                        else
                            'exit
                            m.app.hideScreenSaver()
                            m.app.audio.stop()
                            m.player.stop()
                            m.canvas.Clear()
                            m.canvas.clearLayer(911)
                            m.canvas.clearLayer(199)
                            m.canvas.clearLayer(942)
                            m.player.ClearContent()
                            m.canvas.close()
                            m.app.sleeping = false
                            m.issleeping = false
                            m.app.remoteListener=m.h
                            return
                        endif

                    endif
                endif


            else if msg.isPaused()
                m.paused = true
                m.paint()
                'm.drawMenu()
            else if msg.isResumed()
                m.paused = false
                m.paint()
                'm.drawMenu()
            end if
            'Output events for debug

            'if msg.GetInfo() <> invalid print msg.GetInfo();

        end if

    end while

End Sub

function paint_dark_screensaver(ss_image_url="/pkg:images/screensaver_logo_ocean.png") as void
    'paint icon of sound or not sound


    'paint dark screensaver
    info=CreateObject("roDeviceInfo")
    size=info.GetDisplaySize()
    w_=size.w
    h_=size.h

    if IsHD()
        x_=Rnd(w_-263)
        y_=Rnd(h_-24)
    else
        x_=Rnd(w_-148)
        y_=Rnd(h_-16)
    endif
    m.canvas.setLayer(932,{Color:"#000204",CompositionMode: "Source"})
    if IsHD()
        m.canvas.SetLayer(933,{url:ss_image_url,targetRect:{x:x_,y:y_,w:263,h:24}})
    else
        m.canvas.SetLayer(933,{url:ss_image_url,targetRect:{x:x_,y:y_,w:148,h:16}})
    endif

    m.canvas.show()

end function

Sub SetupFullscreencanvas3()
    m.canvas.AllowUpdates(false)
    m.paint()
    m.canvas.AllowUpdates(true)
End Sub

Sub PaintFullscreencanvas3()

End Sub

Sub SetupFramedcanvas3()
    m.canvas.AllowUpdates(false)
    m.canvas.Clear()
    m.paint()
    m.canvas.AllowUpdates(true)

End Sub

function paint_sleep_details() as void

    'm.canvas.SetLayer(951, { Color: "#50000000", targetRect: {x:220,y:685,w:850,h:30} })
    m.canvas.setLayer(951, { url:"pkg:/images/player_bottom.png", targetRect:{x:220,y:685,w:850,h:30} })
    dstominutes = Cint((m.darkscreentimer - m.position)/60)
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
    if (m.wakeuptime[0].toInt()>11 AND m.wakeuptime[0].toInt()<24)
      daytime = "pm"
      hr = m.wakeuptime[0].toInt() - 12
      if (hr=0) hr = 12
    else
      daytime = "am"
      hr = m.wakeuptime[0].toInt()
    endif
    if (hr=24) hr=0
    timetodarkscreentext = {text: "Time to dark screen: "+dstominutes+" min.", textAttrs: {Color: "#FFFFFF",font: m.app.h4}, targetRect:{x:x_,y:683,w:300,h:30}}
    videowakeuptext = {text: "Video Wake Up: "+hr.toStr()+":"+m.wakeuptime[1]+" "+daytime, textAttrs: {Color: "#FFFFFF",font: m.app.h4}, targetRect:{x:670,y:683,w:300,h:30}}
    m.canvas.setLayer(952, timetodarkscreentext)
    if (m.alarmAnswer1="Yes") m.canvas.setLayer(953, videowakeuptext)
end function

function paint_sleep_menu(selected=2) as void

    m.isMenuUp = true
    print "painting menu"

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
        if (m.isFavorite)
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

function show_sleep_alarm_interruption(msg,options=["Continue","Exit"]) as void
    m.response=false
    ' Size of dialog is 442 x 269
     if (IsHD())
         w_=442
         h_=269
         x_=Fix(m.app.size.w/2)-221
         y_=Fix(m.app.size.h/2)-134
    else
         w_=249
         h_=179
         x_=Fix(m.app.size.w/2)-124
         y_=Fix(m.app.size.h/2)-89
    endif


     dialog={url:"pkg:/images/dialog.png",targetRect:{x:x_,y:y_,w:w_,h:h_}}

    if (IsHD())
        txt={text:msg,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_+10}}
    else
        txt={text:msg,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+7}}
    endif

    m.ipositions=[]

    if (IsHD())
        m.ipositions[0]={w:200,h:25,x:(x_+10),y:(y_+h_)-50}
        m.ipositions[1]={w:200,h:25,x:x_+230,y:(y_+h_)-50}
    else
        m.ipositions[0]={w:113,h:17,x:(x_+6),y:(y_+h_)-33}
        m.ipositions[1]={w:113,h:17,x:x_+129,y:(y_+h_)-33}
    endif

    yes={text:options[0],textAttrs:{HAlign:"center",font:m.app.menufont},targetRect:m.ipositions[0]}
    no={text:options[1],textAttrs:{HAlign:"center",font:m.app.menufont},targetRect:m.ipositions[1]}

    if (IsHD())
        m.iring={url:"pkg:/images/ringdialog2.png",targetRect:{w:200,h:2,x:m.ipositions[1].x,y:m.ipositions[1].y+28}}
    else
        m.iring={url:"pkg:/images/ringdialog2.png",targetRect:{w:113,h:2,x:m.ipositions[1].x,y:m.ipositions[1].y+19}}
    endif

    m.canvas.setLayer(991,dialog)
    m.canvas.setLayer(992,txt)
    m.canvas.setLayer(993,yes)
    m.canvas.setLayer(994,no)
    m.canvas.setLayer(995,m.iring)


end function

Function hide_sleep_menu() as void
    m.isMenuUp=false
    m.isMenuDown=true
    m.canvas.clearLayer(938)
    m.canvas.clearLayer(951)
    m.canvas.clearLayer(952)
    m.canvas.clearLayer(953)
    items = []
    items.push({url:"pkg:/images/show.png"
                 targetRect:{x:630,y:670,w:36,h:35}
                })
    m.canvas.setLayer(940, items)
    m.canvas.show()
End Function


Sub PaintFramedcanvas3()
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
