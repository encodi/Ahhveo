Function NewPlayer(app) as object



this={
      player:CreateObject("roVideoPlayer")
      play:player_play_video
      stop:player_stop_video
      setup:SetupFullScreenCanvas
      playing:false
      paint:     PaintFullScreenCanvas
      canvas:app.canvas
      eventloop: EventLoop
      progress:  0 'buffering progress
      position:  0 'playback position (in seconds)
      paused:    false 'is the video currently paused?
      port:app.port
      layout:app.layout
      app:app
      hideMenu:player_hide_menu
      drawMenu:player_draw_menu
      drawThumb:player_draw_thumb
      hideThumb:player_hide_thumb
      lastRemoteListener:false
      moveNextMenu:player_move_next_menu
      movePrevMenu:player_move_prev_menu
      setPlaylist:player_set_playlist
      playlist:[]
      track:1
      setTrack:player_set_track
      nextTrack:player_next_track
      repeat:false
      timer:CreateObject("roTimespan")
      last_time_menu:0
      last_time_up:0
      last_time_sleep:0
      last_time_off:0
      last_time_trial:0
      expire_menu:5000
      expire_up:500
      restartLastTimeMenu:restart_last_time_menu
      restartLastTimeUp:restart_last_time_up
      restartLastTimeOff:restart_last_time_off
      startTrialTimer:player_start_trial_timer
      menuselected:3
      menulocked:true
      useraction:false
      setFavorite:player_set_favorite
      isFavorite:player_is_favorite
      showUp:player_show_up
      hideUp:player_hide_up
      showingup:false
      set_sleep:false
      setSleep:player_set_sleep
      startSleep:player_start_sleep
      startSleepTimer:player_start_sleep_timer
      shutOff:player_shutoff
      onPlaybackPosition:player_on_playback_position
      'In miliseconds
      send_time_interval:10000
      counter:0
      streaming_time:0
      set_exit:false
      finish:player_finish
      onStop:false
      startAudioPlayer:start_audio_player
      previewmode:false
      previewtime:app.previewtime  ' for 3 minutes 180000
      logstreaming:true
      trialtime:35000    ' When is subscribed and streaming time is over
      firsttrialtime:290000  'When is trial the streaming time is infinite and 10 minutes 600000ms
      ntrack:1
      isShop:false
      temptimer:0
      countertrial:0
      animateIndex:0
      animation:[]
      setupAnimation:setupLoadingAnimation
      updateAnimation:updateLoadingAnimation
     }



return this

end function






Function player_play_video() as Void


    'Validate the Streaming time
    'm.app.audio.player.stop()
    m.set_exit=false
    m.repeat=false
    m.player.SetMessagePort(m.port)
  '  m.player.SetLoop(true)
    m.player.SetPositionNotificationPeriod(1)
    if (IsHD())
        m.player.SetDestinationRect({x:0,y:0,w:1280,h:720})
        m.player.SetMaxVideoDecodeResolution(1280,720)
    else
        m.player.SetDestinationRect({x:0,y:0,w:720,h:480})
        m.player.SetMaxVideoDecodeResolution(1280, 720)
    endif
    m.player.setLoop(true)
    print "playing track"
    print m.track
    print "is type: "
    print type(m.track)
    print "playing: "
    theTrack = m.track
    print theTrack
    print m.playlist[m.track].stream
    m.player.setNext(theTrack)

    vid=m.playlist[theTrack].id

    ws="logCounterVideos.php?user_id="+m.app.userid+"&video_id="+vid
    r=m.app.http.getWs(ws)

    m.temptimer=0
    m.player.Play()
    m.eventLoop()

End Function



function player_finish() as void
    m.set_exit=true
end function

function player_shutoff() as void

       m.stop()
       m.finish()
       m.app.menu.inMain=true
       m.app.menu.render(0)
       m.app.inNews=true
       m.app.section.show(places_section)
       m.app.menu.inMain=true
       m.app.menu.position=0
       m.app.menu.drawLineReference()
       m.isShop=false

       'Reset The app
'       RunUserInterface()
end function



Function player_stop_video()

m.hideThumb()
'm.app.soundFx("click")
m.player.Stop()
m.playing=false
m.useraction=true
m.set_sleep=false
m.previewmode=false
m.player.clearContent()



m.canvas.clearLayer(107)
m.canvas.clearLayer(121)
m.canvas.clearLayer(113)
m.canvas.clearLayer(108)
m.canvas.clearLayer(952)
m.canvas.clearLayer(110)
m.canvas.clearLayer(111)
m.canvas.clearLayer(112)
m.canvas.clearLayer(114)

m.hideMenu()

staticStuff=[]
if (IsHD())
    logo={
        url:"pkg:/images/logo.png",
        TargetRect:{x:40,y:20,w:283,h:85}
    }
    bgmenu = {url:"pkg:/images/bgmenunew.png", TargetRect:{x:0,y:0,w:1280,h:120}}
    sleepmenu = {text: "Relax", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:340,y:50,w:200,h:50}}
        exploremenu = {text: "Sleep", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:530,y:50,w:200,h:50}}
        setupmenu = {text: "Set up", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:740,y:50,w:200,h:50}}
else
    logo={
        url:"pkg:/images/logo.png",
        TargetRect:{x:40,y:20,w:283,h:85}
    }
    bgmenu = {url:"pkg:/images/bgmenunew.png", TargetRect:{x:0,y:0,w:1280,h:120}}
    exploremenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
    sleepmenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
    setupmenu = {text: "Set Up", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
endif
sleepmenunew = {url:"pkg:/images/zzz_active.png", TargetRect:{w:29,h:33,x:660,y:35}}

staticStuff.push(exploremenu)
staticStuff.push(sleepmenu)
staticStuff.push(setupmenu)
m.canvas.setLayer(178, bgmenu)
m.canvas.setLayer(179, staticStuff)
m.canvas.setLayer(199, sleepmenunew)
m.canvas.setLayer(180, logo)


if(type(m.onStop)="roFunction")m.onStop()

end function



function player_set_favorite() as void

    userid=m.app.userid

    video_id=m.playlist[m.track].id

    if(m.isFavorite())

           ws="deleteRelaxNowVideo.php?user_id="+userid+"&video_id="+video_id
           r=m.app.section.http.getWs(ws)
           index=arraySearch(video_id,m.app.favorites)
           if(type(r)<>"roInvalid")
                if(r.done="1")
                   m.app.favorites.delete(index)
                   p={action:2}
                   if(type(m.playerListener.section.onRemoveFavorite)="roFunction")m.playerListener.section.onRemoveFavorite(video_id,m.playerListener)
                   m.drawMenu()
                endif
           endif
    else
        ws="setRelaxNowVideo.php?user_id="+userid+"&video_id="+video_id
           r=m.app.section.http.getWs(ws)
           if(type(r)<>"roInvalid")
                if(r.done="1")
                    video_id=61 ' TODO delete this
                   m.app.favorites.push(video_id)
                   if(type(m.playerListener.section.onAddFavorite)="roFunction")m.playerListener.section.onAddFavorite(r.item,m.playerListener)
                   m.drawMenu()
                endif
           endif

    endif



end function







function player_hide_thumb() as void

    m.canvas.clearLayer(113)
    m.canvas.clearlayer(121)

end function




function player_draw_thumb() as void

        if(m.menulocked=false)return
        c_track=m.track
        nexttrack=c_track+1
        total=m.playlist.Count()-1
        if nexttrack>total
            nexttrack=0
        endif
        positions=m.menupositions
        'if (IsHD())
        'thumb={url:m.playlist[nexttrack].thumbnail,
        '              targetRect:{x:positions[m.menuselected].x-25,y:positions[m.menuselected].y,w:150,h:100}
        '       }
        'else
        '       thumb={url:m.playlist[nexttrack].thumbnail,
        '              targetRect:{x:positions[m.menuselected].x-13,y:positions[m.menuselected].y,w:125,h:75}
        '       }
        'endif

        '''''''''''''''''''''''''''''''''''''''''m.app.size.center_x_full
        if (IsHD())
            thumb={url:m.playlist[c_track].thumbnail,
                      targetRect:{x:m.app.size.center_x_full-50,y:340,w:150,h:100}'targetRect:{x:m.app.size.center_x_full-50,y:340,w:150,h:100}
               }
        else
               thumb={url:m.playlist[c_track].thumbnail,
                      targetRect:{x:m.app.size.center_x_full-50,y:340,w:150,h:100}
               }
        endif
        '''''''''''''''''''''''''''''''''''''''''

        m.canvas.setLayer(113,thumb)

end function


function player_show_up() as void


    if(m.playing=false or m.showingup)return
    up={url:"pkg:/images/show.png",targetRect:{x:m.app.size.center_x_full,y:m.app.size.h-m.app.edge_top-35,w:36,h:35}}
    m.canvas.setLayer(114,up)
    m.restartLastTimeUp()
    m.showingup=true
end function



function player_is_favorite() as boolean

    id=m.playlist[m.track].id
    favorites=m.app.favorites


   exists=false

   for each v in favorites

        if v=id
            exists=true
            exit for
        end if
   end for


    return exists
end function



function player_set_sleep() as void
     if(m.set_sleep)
            m.set_sleep=false
     else
            m.startSleepTimer()
            m.set_sleep=true
     endif
end function


function start_audio_player() as void
    m.app.showScreensaver()
    m.app.sleeping=true
    'while m.app.sleeping
        if m.app.sleeping=false
            'exit while
        endif
        dr = m.app.http.getWs("logState.php?userID="+m.app.getRegistry()+"&leftAt=screensaver")
        if m.app.sleepSound=1 then
        'ocean
            m.app.randomizeScreensaver("screensaver_logo_ocean.png")
        else if m.app.sleepsound=2 then
        'frogs
            m.app.randomizeScreensaver("screensaver_logo_frogs.png")
        else if m.app.sleepsound=3 then
        'rain
            m.app.randomizeScreensaver("screensaver_logo_rain.png")
        else if m.app.sleepsound=5 then
        'crickets
            m.app.randomizeScreensaver("screensaver_logo_cricket.png")
        else if m.app.sleepsound=4 then
        'chorus_frogs
           m.app.randomizeScreensaver("screensaver_logo_chorus_frogs.png")
        else if m.app.sleepsound=0 then
        'sleepy thunder
          m.app.randomizeScreensaver("screensaver_logo_sleepy_thunder.png")
        endif
    'end while
    m.app.audio.play(m.app.settings.sleep_sound,"sleep.wma")
end function



function player_start_sleep() as void
    m.stop()
    m.Finish()

    m.startSleepTimer()
    m.set_sleep=true
    m.startAudioPlayer()
end function



function player_start_sleep_timer() as void

    m.last_time_sleep=m.timer.TotalMilliseconds()+m.app.settings.sleep_timer

end function


function player_start_trial_timer() as void

    m.last_time_trial=m.timer.TotalMilliseconds()+m.trialtime

end function



function player_draw_menu() as void


    'if(m.previewmode and m.isshop)return

    selected=m.menuselected

     if IsHD()
        x_=Fix((m.app.size.w/2)-420)
        top=Fix(m.app.size.h-140)
     else
        x_=Fix((m.app.size.w/2)-236)
        top=Fix(m.app.size.h-93)
     endif

     positions=[]
     for i=0 to 5
     if (IsHD())
        positions[i]={x:x_,y:top,w:100,h:100}
        x_=x_+140
     else
        positions[i]={x:x_,y:top,w:60,h:60}
        x_=x_+90
     endif

     end for


    items=[]

     if IsHD()
        items.push({url:"pkg:/images/hide.png"
                 targetRect:{x:m.app.size.center_x_full,y:positions[0].y-35,w:36,h:35}
                })
     else
        items.push({url:"pkg:/images/hide.png"
                 targetRect:{x:m.app.size.center_x_full,y:positions[0].y-23,w:20,h:23}
                })
     endif



     repeat_image="pkg:/images/repeat.png"
         if(m.repeat)repeat_image="pkg:/images/repeat_active.png"



    sleep_image="pkg:/images/sleep.png"
        if(m.set_sleep)sleep_image="pkg:/images/sleep_active.png"

    items.push({url:sleep_image
                targetRect:positions[0]})


    repeat={url:repeat_image,
               targetRect:positions[1]
               }


    playpause_image="pkg:/images/pause.png"
        if(m.paused)
             playpause_image="pkg:/images/play.png"
        end if
    playpause={url:playpause_image,
               targetRect:positions[2]
               }

    items.Push({url:"pkg:/images/nextvideo.png"
                targetRect:positions[3]})


    favorite_image="pkg:/images/favorites.png"
    if(m.isFavorite())favorite_image="pkg:/images/favorites_filled.png"
    items.Push({url:favorite_image
                targetRect:positions[4]})

    items.Push({url:"pkg:/images/mainmenu.png"
                targetRect:positions[5]})

    ring={url:"pkg:/images/ringplayer.png"
          targetRect:positions[selected]
           }


    ' if(m.menuselected=3)


    '            ring={url:"pkg:/images/ringplayer.png"
    '                  targetRect:positions[m.menuselected]
   '                   }

   ' end if
    m.canvas.setLayer(951, { url:"pkg:/images/player_bottom.png", targetRect:{x:220,y:685,w:850,h:30} })
    dstominutes = "45"
    timetoadvancetext = {text: "Time to Advance Setting: "+dstominutes+" minute(s).", textAttrs: {Color: "#FFFFFF",font: m.app.h4}, targetRect:{x:300,y:681,w:350,h:30}}
    dstohours = "3"
    autoshutofftext = {text: "Auto-ShutOff Setting: "+dstohours+":00 hour(s).", textAttrs: {Color: "#FFFFFF",font: m.app.h4}, targetRect:{x:670,y:681,w:300,h:30}}
    
  '  m.menuselected=2
    dr = m.app.http.getWs("logState.php?userID="+m.app.getRegistry()+"&leftAt=playing_video")

    items.push(timetoadvancetext)
    items.push(autoshutofftext)
    m.canvas.setLayer(952, items)
    m.menupositions=positions
    'm.canvas.setLayer(109,items)
    m.canvas.setLayer(110,playpause)
    m.canvas.setLayer(111,repeat)
    m.canvas.setLayer(112,ring)
    m.restartLastTimeMenu()
    m.showingup=false
    m.hideUp()


'######### Draw the thumbnail when menu displays#######
'    m.drawThumb()
end function


function restart_last_time_menu()

m.last_time_menu=m.timer.TotalMilliseconds()+m.expire_menu

end function


function restart_last_time_up() as void

    m.last_time_up=m.timer.TotalMilliseconds()+m.expire_up

end function

function restart_last_time_off() as void

    m.last_time_off=m.timer.TotalMilliseconds()+m.app.settings.shutoff_timer
    print m.last_time_off

end function



Function player_hide_menu(msel=3) as void
m.hideThumb()
m.canvas.clearLayer(952)
m.canvas.clearLayer(121)
m.canvas.clearLayer(110)
m.canvas.clearLayer(111)
m.canvas.clearLayer(112)
m.canvas.clearLayer(113)
m.canvas.clearLayer(114)
m.canvas.clearLayer(951)
m.menulocked=true
if(m.paused)
    m.menuselected=2
else
    m.menuselected=msel
endif

m.showUp()
end function


function player_hide_up() as void
    m.hideThumb()
    m.canvas.clearLayer(114)
    m.canvas.clearLayer(121)
    m.canvas.clearLayer(113)
end function



Sub EventLoop()



    while true
        msg = wait(450, m.port)


                'Force to stop all, clear and exit while when some special case for example
                'Shutoff timer, Sleep timer or Streaming time off


                if(m.set_exit)
                    m.stop()
                    if (m.previewmode=false)
                        m.finish()
                    else
                        m.app.goHome()
                    endif
                    exit while
                endif

        if msg <> invalid
            'If this is a startup progress status message, record progress
            'and update the UI accordingly:
                 'print msg.isFullResult()

            if msg.isStatusMessage() and msg.GetMessage() = "startup progress"
                m.paused = false
                progress% = msg.GetIndex() / 10
                if m.progress <> progress%
                    m.progress = progress%
                    m.paint()
                else
                    'm.hideThumb()
                end if

            'Playback progress (in seconds):
            else if msg.isPlaybackPosition()

                 m.onPlaybackPosition(msg.getIndex())
                 'm.hideThumb()
 '               m.position = msg.GetIndex()
'                m.paint()

            'If the <UP> key is pressed, jump out of this context:
            else if msg.isRemoteKeyPressed()
                        if(m.app.deviceinfo.getLinkStatus()=false) m.app.dialog.alert2("Your connection to the server was lost. Try checking your network settings. Thank you.")

                        index = msg.GetIndex()

                        if m.app.sleeping=true and index<>32
                            m.app.sleeping=false
                            m.set_sleep=false
                            m.app.hideScreenSaver()
                        endif


                        'if(index=0)

                                        if index=0  '<BACK> or ShutoffTimer was done
                                            m.stop()

                                            'm.app.audio.play(m.app.settings.sleep_sound,"sleep.wma")
                                            'm.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
                                            exit while
                                        else if index = 3 '<DOWN>
                                            m.hideMenu()
                                        else if index=4 or index=5 '<LEFT> or <RIGHT>
                                                    'm.hideThumb()
                                                    if(m.menulocked=false)
                                                            if(index=4)     '<LEFT>'
                                                                 m.movePrevMenu()
                                                            else if index=5 '<RIGHT>
                                                                 m.moveNextMenu()
                                                            endif
                                                            m.drawMenu()
                                                   endif
                                        else if index=6 or index=13 or index=7 'OK or Play/Pause

                                                'Repeat remote Pressed
                                                if(index=7)
                                                     m.stop()
                                                     'm.app.audio.play(m.app.settings.sleep_sound,"sleep.wma")
                                                     'm.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
                                                     exit while
                                                     ' if(m.menulocked=false)
                                                     '     if m.repeat=false m.repeat=true else m.repeat=false
                                                     ' end if
                                                'Play/Pause button pressed
                                                else if(index=13)
                                                    if(m.playing)
                                                            if m.paused then
                                                                m.player.Resume()
                                                                m.restartLastTimeOff()
                                                                m.set_sleep=false
                                                                m.app.sleeping=false
                                                                m.menulocked=false
                                                            else
                                                                m.player.Pause()
                                                                rs=m.app.http.getWs("logSleepUse.php?user_id="+m.app.userid)
                                                                m.setSleep()
                                                                m.menulocked=false
                                                            endif
                                                    end if
                                                else if(m.menulocked=false)
                                                                mselected=m.menuselected
                                                                if(mselected=5) 'Back to Menu Button Pressed
                                                                    m.stop()
                                                                    'm.app.audio.play(m.app.settings.sleep_sound,"sleep.wma")
                                                                    'm.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
                                                                    exit while
                                                                else if mselected=3 'Next Video Button Pressed
                                                                    if m.previewmode
                                                                        m.counter=0
                                                                        m.temptimer=0
                                                                    endif
                                                                    m.nextTrack()
                                                                else if mselected=2 'Play/Pause Button Pressed
                                                                        positions=m.menupositions
                                                                        if m.paused
                                                                            m.player.Resume()
                                                                            m.restartLastTimeOff()
                                                                            m.set_sleep=false
                                                                            m.app.sleeping=false
                                                                        else
                                                                            m.player.Pause()
                                                                            m.setSleep()
                                                                        endif
                                                                else if mselected=1  'Repeat Button
                                                                        positions=m.menupositions
                                                                        if (m.app.trial=false and m.isshop=false)
                                                                            if m.repeat=false m.repeat=true else m.repeat=false
                                                                            print m.repeat
                                                                        endif
                                                                else if mselected=0
                                                                        if (m.app.trial=false and m.isshop=false)
                                                                            rs=m.app.http.getWs("logSleepUse.php?user_id="+m.app.userid)
                                                                            m.setSleep()
                                                                        endif
                                                                else if mselected=4
                                                                        if (m.app.trial=false and m.isshop=false)
                                                                            print "can set favorite"
                                                                            m.setFavorite()
                                                                        endif
                                                                endif
                                                                m.drawMenu()
                                                 endif

                                                                       '<FWD> <REV> buttons
                                                                       '     else if index = 8  '<REV>
                                                                       '         m.position = m.position - 20
                                                                       '         m.player.Seek(m.position * 1000)
                                                                       '     else if index = 9  '<FWD>
                                                                       '         m.position = m.position + 20
                                                                       '         m.player.Seek(m.position * 1000)

                                        end if


                                  '      if index=2 or index=3 or index=4 or index=5 or index=6 or index=13 or index=7  'Show Menu In Each Case

                                        if(index=2 or index=6) 'Show Menu if the <UP> or <OK> buttons are pressed
                                              if(m.playing)
                                                  m.drawMenu()
                                                  m.menulocked=false
                                              endif
                                        end if

                        'else
                        '           m.stop()
                        '           exit while
                        'endif 'End if preview mode



            else if msg.isPaused()
                m.paused = true
                m.paint()
                m.drawMenu()

            else if msg.isResumed()
                m.paused = false
                m.paint()
                m.drawMenu()
            else if msg.isFullResult()  'getMessage()="Playback stopped" 'HANDLING THE REPEAT FUNCTION

            end if





            'Output events for debug
        end if


      if(m.last_time_menu<>0)
                if m.timer.TotalMilliseconds() > m.last_time_menu then
                    if(m.paused)
                        m.hideMenu(2)
                    else
                        m.hideMenu()
                    endif
                    m.last_time_menu=0
                end if
      endif

      if(m.last_time_up<>0)
                if m.timer.TotalMilliseconds() > m.last_time_up then
                    m.hideUp()
                    m.last_time_up=0
                end if
      endif

      if(m.set_sleep and m.last_time_sleep<>0 and m.previewmode=false)

                if(m.timer.TotalMilliseconds()>m.last_time_sleep)
                    m.startSleep()
                    if (m.timer.TotalMilliseconds() MOD 15=0)m.app.ticklesmall()
                    m.last_time_sleep=0

                endif
      endif

      if(m.app.timeover and m.last_time_trial<>0 and m.previewmode=false)
                if(m.timer.TotalMilliseconds()>m.last_time_trial)
                    m.player.stop()
                    m.stop()
                    print "this caused 2"
                    m.finish()
                    m.app.onTimeover()
                    m.last_time_trial=0
                    exit while
                endif
      endif


      if(m.last_time_off<>0 and m.previewmode=false and m.set_sleep=false)
                'print m.timer.TotalMilliseconds()
                'print " > "
                'print m.last_time_off
                if m.timer.TotalMilliseconds() > m.last_time_off then
                    print "this caused 1"
                    m.player.stop()
                    m.finish()
                    'm.app.exitApp()
                    m.last_time_off=0
                end if
       endif

    end while




End Sub





function player_on_playback_position(index) as void
    m.temptimer = m.temptimer+1000
    'Increment the counter
    m.countertrial=m.countertrial+1000
    m.counter=m.counter+1000
    if (m.app.trial or m.isShop)
        m.previewmode=true
    else
        m.previewmode=false
    endif' if user is trial start the previewmode
    if m.temptimer<17999999
        print m.temptimer
    endif
    'When playing in preview mode don�t log the streaming time
    if (m.temptimer>=2400000) '40min 24000000 'now set at 30min to test


        m.temptimer=0
        m.counter=0
        'if(m.useraction=false)

                track=m.track
                if(m.repeat)

                    m.player.stop()
                    'm.player.setNext(track)
                    m.player.SetContentList(m.playlist)
                    m.player.SetNext(track)
                    m.player.Play()

                else

   '             'does nothing
   '                 'm.ntrack=track+1
   '                 'if(m.ntrack>last_track)
    '                '    m.ntrack=0
    '                'endif
    '                'm.track=m.track
                end if
        'endif

        m.useraction=false ' this is false when the user hasnt pressed anything
    'else if (m.temptimer>=m.app.globalvideotimer)
    '                m.player.stop()
    '                m.player.SetContentList(m.playlist)
    '                if (m.repeat)
                        'm.player.SetNext(track+1)
                     'endif
    '                m.player.Play()
    endif

    '' need an else on all the other elements


    if(m.previewmode)
        print "got on preview mode"
        m.app.globaltrialtime = m.app.globaltrialtime - 1000
        print m.app.globaltrialtime
        if(m.countertrial>=m.send_time_interval)
            m.countertrial=0
            video_id=m.playlist[m.track].id
            print "video id: "+video_id
            ws="logStreamingTime.php?user_id="+m.app.userid+"&video_id="+video_id+"&time_watched=10000"
            r=m.app.http.getWs(ws)
            if(type(r)<>"roInvalid")

            end if
        end if
        if m.app.globaltrialtime>5000
            if(m.counter>=m.previewtime)
                m.counter=0
                m.temptimer=0
                if (m.isShop)
                    m.nextTrack()
                    print "nextTrack()"
                    return
                endif
                m.stop()
                m.finish()
                if m.app.trial
                    ws="getPopup.php?id=12"
                    popup=m.app.http.getWs(ws)

                    r=m.app.dialog.confirm2(popup[0].content,[popup[0].option_1,popup[0].option_2])

                    if r then
                       m.app.istrial()
                      'ws="getPopup.php?id=1"
                      'popup=m.app.http.getWs(ws)
                      'r2=m.app.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
                      '  options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                      '    if r2=2
                      '      m.app.subscribe(3)
                      '    else if r2=1
                      '      m.app.subscribe(2)
                      '    else if r2=0
                      '      m.app.subscribe(1)
                      '    endif
                    else
                        m.app.forceSection()
                        return
                    endif
                endif
            endif
        else
            m.counter=0
            m.temptimer=0
            if (m.isShop)
                m.nextTrack()
                return
            endif
            print "error 2"
            m.stop()
            m.finish()
            if m.app.trial
                ws="getPopup.php?id=12"
                popup=m.app.http.getWs(ws)

                r=m.app.dialog.confirm2(popup[0].content,[popup[0].option_1,popup[0].option_2])

                if r then
                    m.app.istrial()
                  'ws="getPopup.php?id=1"
                  'popup=m.app.http.getWs(ws)
                  'r2=m.app.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
                  '  options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                  '    if r2=2
                  '      m.app.subscribe(3)
                  '    else if r2=1
                  '      m.app.subscribe(2)
                  '    else if r2=0
                  '      m.app.subscribe(1)
                  '    endif
                else
                    m.app.forceSection()
                    return
                endif
            endif
        endif
        return
    endif




    if(m.app.trial)
        if(m.counter>=m.firsttrialtime)
            m.counter=0
            m.temptimer=0
            m.stop()
            m.finish()
            m.app.istrial()
            'ws="getPopup.php?id=1"
            '    popup=m.app.http.getWs(ws)
            '    r=m.app.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
            '     options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
            '                  if r=2
            '                    m.app.subscribe(3)
            '                  else if r=1
            '                    m.app.subscribe(2)
            '                  else if r=0
            '                    m.app.subscribe(1)
            '                  else
            '                    m.app.goHome()
            '                  endif
        else
            print "was in here?"
            print m.counter
            if(m.counter>=m.send_time_interval)

                m.counter=0
                video_id=m.playlist[m.track].id
                print "never here in trial?"
                ws="setStreamingTime.php?user_id="+m.app.userid+"&video_id="+video_id+"&time_watched=10000"

                r=m.app.http.getWs(ws)
                if(type(r)<>"roInvalid")
                        if(r.available_time<=0)
                            m.previewmode=true
                            return
                        endif
                end if
            endif
        endif
        return
    endif



    if(m.counter>=m.send_time_interval)
        m.counter=0
        video_id=m.playlist[m.track].id
        'print "never here?"
        ws="setStreamingTime.php?user_id="+m.app.userid+"&video_id="+video_id+"&time_watched=10000"

        r=m.app.http.getWs(ws)
        'print type(r)
        if(type(r)<>"roInvalid")
            print r.available_time
                if(r.available_time<=0)
                     m.app.timeover=true
                     m.finish()
                     print "on this finish"
                     m.stop()



                                 m.app.onTimeOver()


                                 'resp=m.app.dialog.confirm(message)
                                 'if(resp)
                                 '     m.app.section.show(settings_section)
                                 'endif


                else
                    print "failed here"
                endif
        else
            print "error on this zone"
        end if
    endif
end function



function player_move_next_menu() as void
        positions=m.menupositions
        selected=m.menuselected+1
        total=positions.Count()-1
        if(selected>total)
            selected=0
        endif
        m.menuselected=selected
end function


function player_move_prev_menu() as void
        positions=m.menupositions
        selected=m.menuselected-1
        total=positions.Count()-1
        if(selected<0)
            selected=total
        endif
        m.menuselected=selected
end function



function player_set_playlist(playlist) as void

   m.player.setContentList(playlist)
   m.playlist=playlist

end function


function player_set_track(index) as void
    m.track=index
end function



function player_next_track() as void
        m.temptimer=0
        track=m.track
        'm.hideThumb()
        if (m.repeat)
            print "repeating track"
            m.ntrack = track
        else
            print "next track"
            m.ntrack=track+1
        endif
        playlist=m.playlist
        totalplaylist=playlist.count()-1
        print m.ntrack
        print totalplaylist
        if(m.ntrack>totalplaylist and m.isShop=false)
            m.ntrack=0
        else if (m.ntrack>totalplaylist and m.isShop=true)
            m.stop()
            m.finish()
            if m.app.trial
                ws="getPopup.php?id=12"
                popup=m.app.http.getWs(ws)

                r=m.app.dialog.confirm2(popup[0].content,[popup[0].option_1,popup[0].option_2])

                if r then
                    m.app.istrial()
                  'ws="getPopup.php?id=1"
                  'popup=m.app.http.getWs(ws)
                  'r2=m.app.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
                  '  options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                  '    if r2=2
                  ''      m.app.subscribe(3)
                  '    else if r2=1
                  '      m.app.subscribe(2)
                  '    else if r2=0
                  '      m.app.subscribe(1)
                  '    endif
                else
                    m.app.forceSection()
                    return
                endif
            endif
            return
        endif

        m.track=m.ntrack
        params={action:1}
        m.playerListener.playerCallback(params)
        m.playing=false
        m.useraction=true
        m.player.stop()
        m.player.setNext(m.track)
        m.hideMenu()
        m.player.play()

end function



function setupLoadingAnimation() as object
    'm.drawThumb()
    m.animation=[{url:"pkg:/images/frame_000.gif",compositionMode:"Source_Over",targetrect:{x:m.app.size.center_x_full-7,y:260,w:64,h:64}},
                      {url:"pkg:/images/frame_001.gif",compositionMode:"Source_Over",targetrect:{x:m.app.size.center_x_full-7,y:260,w:64,h:64}},
                      {url:"pkg:/images/frame_002.gif",compositionMode:"Source_Over",targetrect:{x:m.app.size.center_x_full-7,y:260,w:64,h:64}},
                      {url:"pkg:/images/frame_003.gif",compositionMode:"Source_Over",targetrect:{x:m.app.size.center_x_full-7,y:260,w:64,h:64}},
                      {url:"pkg:/images/frame_004.gif",compositionMode:"Source_Over",targetrect:{x:m.app.size.center_x_full-7,y:260,w:64,h:64}},
                      {url:"pkg:/images/frame_005.gif",compositionMode:"Source_Over",targetrect:{x:m.app.size.center_x_full-7,y:260,w:64,h:64}},
                      {url:"pkg:/images/frame_006.gif",compositionMode:"Source_Over",targetrect:{x:m.app.size.center_x_full-7,y:260,w:64,h:64}},
                      {url:"pkg:/images/frame_007.gif",compositionMode:"Source_Over",targetrect:{x:m.app.size.center_x_full-7,y:260,w:64,h:64}}]

end function

function updateLoadingAnimation() as void
    if m.animateIndex<7
        m.animateIndex=m.animateIndex+1
    else
        m.animateIndex=0
    endif
   m.canvas.SetLayer(121,m.animation[m.animateIndex])

end function


Sub SetupFullscreenCanvas()
    m.canvas.AllowUpdates(false)
    m.paint()
    m.canvas.AllowUpdates(true)
End Sub

Sub PaintFullscreenCanvas()
    list = []
    if m.progress < 100
        'm.setupAnimation()
        'm.updateAnimation()
        color = "#000000" 'opaque black
        list.Push({
            Text: "Loading..." '+ m.progress.tostr() + "%"
            TextAttrs: { font: m.app.h3 }
            TargetRect: m.layout.full
        })


        'list.Push({url:"pkg:/images/loading.gif",targetRect:{x:m.app.size.center_x_full,y:200,w:128,h:128}})
    else if m.paused
        color = "#80000000" 'semi-transparent black
        list.Push({
            Text: "Paused"
            TextAttrs: { font: "medium" }
            TargetRect: m.layout.full
        })
    else
        color = "#00000000" 'fully transparent

        if(m.playing=false)
            m.drawMenu()
            m.playing=true

                if(m.app.timeover and m.app.trial=false)
                        m.startTrialTimer()
                endif

            m.restartLastTimeOff()
            m.menulocked=false
        endif

    end if

    m.canvas.SetLayer(107, { Color: color, CompositionMode: "Source" })
    m.canvas.SetLayer(108, list)
End Sub

Sub SetupFramedCanvas()
    m.canvas.AllowUpdates(false)
    m.canvas.Clear()
    m.canvas.SetLayer(105, [
        { 'Background:
            Url: m.background
            CompositionMode: "Source"
        },
        { 'The title:
            Text: "Custom Video Player"
            TargetRect: m.layout.top
            TextAttrs: { valign: "bottom", font: m.headerfont, color: m.textcolor }
        },

    ])
    m.paint()
    m.canvas.AllowUpdates(true)
End Sub

Sub PaintFramedCanvas()
    list = []
    if m.progress < 100  'Video is currently buffering
        list.Push({
            Color: "#80000000"
            TargetRect: m.layout.left
        })
        list.Push({
            Text: "Loading..." + m.progress.tostr() + "%",
            TextAttrs: { font: m.app.h3 },
            TargetRect: m.layout.left
        })
        'list.Push({url:"pkg:/images/loading.gif",targetRect:{x:m.app.size.center_x_full,y:200,w:128,h:128}})
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
        list.Push({
            Text: "Current position: " + m.position.tostr() + " seconds"
            TargetRect: m.layout.bottom
            TextAttrs: { halign: "left", valign: "top", color: m.textcolor }
        })
    end if
    m.canvas.SetLayer(106, list)
End Sub
