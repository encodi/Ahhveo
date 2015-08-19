function settings_sleep(s) as object

    this={
          section:s
          remoteCallBack:settings_sleep_remote_callback
          init:settings_sleep_init
          canvas:s.canvas
          app:s.app
          remaining:60
          position:-1
          selected:0
          alarmselected:0
          drawRing:settings_sleep_draw_ring
          changeTimer:settings_sleep_change_timer
          changeSound:settings_sleep_change_sound
          toMinutes:settings_sleep_to_minutes
          enabled:false
          onReturn:settings_sleep_on_return          
          setTimerPicker:settings_sleep_set_timer_picker
          setSoundPicker:settings_sleep_set_sound_picker
          setAlarmSound:settings_sleep_set_alarm_sound
          setAlarmTime:settings_sleep_set_alarm_time
          setAlarm:settings_sleep_set_alarm
          goBack:settings_sleep_go_back
          alarmhour:"7"
          alarmminutes:"00"
          alarmtime:"am"
          alarmsound:"Zen Stones"
          hourlock:false
          minutelock:false
          timelock:false
          alarmsoundlock:false
          changealarmtimer:change_alarm_timer
         }
         
        
return this    
end function



function settings_sleep_init(parent=false) as void
    m.hourlock=false
    m.minutelock=false
    m.timelock=false
    m.alarmsoundlock=false
    m.parent=parent

    size=m.app.size
    sb_w=m.app.sidebar_width
    edge_top=m.app.edge_top
    center_x=sb_w+Fix((size.w-sb_w)/2)
    
    if IsHD()    
        margin_right=50
    else
        margin_right=28
    endif
    w_=(size.w-sb_w)-(margin_right*2)
    x_=sb_w+margin_right
    if IsHD()
        y_=50+edge_top
    else
        y_=33+edge_top
    endif
    w_m=fix((size.w-sb_w)/2)
    
    items=[]
    
    positions=[]
    
    if IsHD()
        header1_rect={x:x_,y:y_,w:w_,h:70}
        y_=y_+70
    
        timer_rect={x:center_x-109,y:y_,w:250,h:50}
        positions.push({x:center_x-56,y:y_+2,w:50,h:50})
    
        y_=y_+70
        text1_rect={y:y_+30,w:w_,x:x_,h:100}
    
        y_=y_+130
        header2_rect={x:x_,y:y_+60,w:w_,h:50}
        y_=y_+50
            
        positions.push({x:center_x-100,y:y_+70,w:230,h:50})
        y_=y_+70
        text2_rect={y:y_+40,w:w_,x:x_,h:100}
        text2_rect2={y:y_+100,w:w_,x:x_,h:100}
        positions.push({x:center_x-100,y:y_+140,w:230,h:50})
        positions.push({x:center_x-100,y:y_+140,w:230,h:50})
        positions.push({x:center_x-100,y:y_+140,w:230,h:50})
        positions.push({x:center_x-100,y:y_+140,w:230,h:50})
    else
        header1_rect={x:x_,y:y_,w:w_,h:36}
        y_=y_+39
    
        timer_rect={x:center_x-60,y:y_+3,w:141,h:33}
        positions.push({x:center_x-28,y:y_+5,w:28,h:33})
    
        y_=y_+46
        text1_rect={y:y_+20,w:w_,x:x_,h:67}
    
        y_=y_+87
        header2_rect={x:x_,y:y_+40,w:w_,h:33}
        y_=y_+33
            
        positions.push({x:center_x-70,y:y_+47,w:160,h:33})
        y_=y_+47
        text2_rect={y:y_+37,w:w_,x:x_,h:67}
        text2_rect2={y:y_+77,w:w_,x:x_,h:67}
         positions.push({x:center_x-70,y:y_+90,w:160,h:33})
         positions.push({x:center_x-70,y:y_+90,w:160,h:33})
         positions.push({x:center_x-70,y:y_+90,w:160,h:33})
         positions.push({x:center_x-70,y:y_+90,w:160,h:33})
    endif
    

    w_m=fix((size.w-sb_w)/2)
    

    items.push({text:"Set a timer to turn off streaming and launch our patent pending, dark, sleep screen saver. WHEN 'SLEEP' IS ACTIVE IN YOUR PLAYER MENU.",textAttrs:{font:m.app.h4},targetRect:header1_rect})
    items.push({url:"pkg:/images/rect.png",targetRect:header1_rect})
    items.push({text:"<        > minutes",textAttrs:{font:m.app.h3},targetRect:timer_rect})
    items.push({text:"Ahhveo can help you Sleep! When playing any title you can bring-up the 'player menu' using the 'up' arrow.  You can then navigate over to 'Sleep', push 'Ok' and Sleep will turn Yellow, (becoming active).  When Sleep is Yellow in a title's Player menu the above timer will control how long before the video stops streaming and is replaced with a dark screensaver and calming nature sounds, (you can select your preferred nature sound just below).  The sleep screensaver and sounds will play for 12 hours with no reduction in your streaming time. 'Sleep' must be activated (turned Yellow) in a title's 'player menu' each time you want to use it. Patent Pending.",
                textAttrs:{font:m.app.h4},
                targetRect:text1_rect})
    
    items.push({text:"Preview and select the sound you want to hear when the Ahhveo Sleep Screensaver comes on... PLEASE BE PATIENT, PREVIEW SOUNDS LOAD SLOWLY.",textAttrs:{font:m.app.h4},targetRect:header2_rect})
    items.push({url:"pkg:/images/rect.png",targetRect:header2_rect})
    
    'items.push({text:"Plan A: Set your nature sounds to Ocean Waves. Fall asleep to the sun setting in the Pacific. Dream of nothing but a warm ocean breeze the whole night through. Plan B: Set your nature sounds to Peaceful Frogs. Fall asleep to the moon reflecting along the shore of a Northern lake. Dream of nothing but camp the whole night through. Plan C: ...?",
    '            textAttrs:{font:m.app.h4},
    '           targetRect:text2_rect})
    
    'ALARM TEXT AND SETTING HERE
    items.push({text:"Ahhveo also helps you wake up! With the alarm feature you can wake up with favorite soothing video! A beautiful forrest, or a sunny beach. (Time is based in your Roku system settings).",
    textAttrs:{font:m.app.h4}, targetRect:text2_rect})
    'ALARM vars
    'm.alarmhour = "7"
    'm.alarmminutes = "00"
    'm.alarmtime = "am"
    'm.alarmsound = "Zen Stones"
    
    'items.push({text:"<   :     >  <             >", textAttrs:{font:m.app.h2}, targetRect:text2_rect2})
    
    settings=m.app.http.getWs("getSettings.php?user_id="+m.app.userid)
    
    if(type(settings)<>"roInvalid")
        m.sleep_timer=settings.sleep_timer
        m.start_sleep_timer=m.sleep_timer
        m.sleep_sound=settings.sleep_sound
        m.start_sleep_sound=m.sleep_sound
        m.sounds=settings.sounds
        'm.app.globalalarm = settings.alarm_hour
        m.alarmhour = settings.alarm_hour
        m.alarmminutes = settings.alarm_minute
        m.alarmtime = settings.alarm_timer
        m.alarmsound = settings.alarm_sound
    endif
    
    'mydate = CreateObject("roDateTime")
    'mydate.toLocalTime()
    ''print "current date time"
    ''print mydate.asDateString("short-date-dashes")+" "+mydate.GetHours().tostr()+":"mydate.GetMinutes().tostr()
    
    if(type(m.sounds)="roArray")
        total=m.sounds.count()
        counter=total-1
        for i=0 to counter
              sound=m.sounds[i]
              if(sound=m.sleep_sound)m.selected=i 
              if(sound=m.alarmsound)m.alarmselected=i              
        endfor
    endif
          
    m.positions=positions
    
    m.canvas.setLayer(1,items)
    m.setTimerPicker()
    m.setSoundPicker()
    m.setAlarm()
    
   'm.drawring()
   if(m.app.menu.inMain=false)m.drawring()
    
    dr = m.app.http.getWs("logState.php?userID="+m.app.getRegistry()+"&leftAt=settings")
end function




function settings_sleep_set_timer_picker() as void
    'm.drawring()
    minutes=m.toMinutes(m.sleep_timer)
    p=m.positions[0]
    sleep_timer={text:minutes,textAttrs:{HAlign:"center",font:m.app.h3},targetRect:m.positions[0]}    
    m.canvas.setLayer(51,sleep_timer)
end function




function settings_sleep_set_sound_picker(frun=false) as void

     txt=m.sleep_sound
    if(txt="")
    
        if(type(m.sounds)="roArray")
            m.sleep_sound=m.sounds[m.selected]
            txt=m.sounds[0]
        endif
    endif
    sleep_sound={text:"<"+txt+">",textAttrs:{HAlign:"center",font:m.app.h3},targetRect:m.positions[1]}
    
    'm.app.audio.play(m.sounds[m.selected],"sleep.wma")
    timer=m.sleep_timer
   
    'shutoff_timer = m.app.settings.shutoff_timer + 1800000
    sound=m.sleep_sound
    userid=m.app.userid
    sound=m.app.http.Http.Escape(sound)
    m.app.sleepSound = m.selected
    ws="setSettings.php?user_id="+userid+"&settings%5Bsleep_timer%5D="+timer+"&settings%5Bsleep_sound%5D="+sound '+"&settings%5Bshutoff_timer%5D="+shutoff_timer.tostr()
    r=m.app.http.getWs(ws)
    
                        
    if(type(r)<>"roInvalid")
        if(r.done=1)
            if (frun)
                m.app.settings.sleep_timer=timer.toInt()
                if m.selected>5 DownloadFile(r.sleep_sound,"sleep.wma")
                if m.selected>5 m.app.audio.play(r.sleep_sound,"sleep.wma")
                if m.selected=1 m.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
                if m.selected=2 m.app.audio.play("Peaceful_Frogs.wma","Peaceful_Frogs.wma")
                if m.selected=3 m.app.audio.play("Summer_Rain.wma","Summer_Rain.wma")
                if m.selected=5 m.app.audio.play("Relaxing_Crickets.wma","Relaxing_Crickets.wma")
                if m.selected=4 m.app.audio.play("Chorus_Frogs.wma","Chorus_Frogs.wma")
                if m.selected=0 m.app.audio.play("Sleepy_Thunder.wma","Sleepy_Thunder.wma")
            endif
        endif
    endif
    
    m.canvas.setLayer(52,sleep_sound)
end function

Function settings_sleep_set_alarm() as void
    
    m.setAlarmSound()
    m.setAlarmTime()
    
End Function

Function settings_sleep_set_alarm_sound() as void
    txt=m.alarmsound
    if(txt="")
        if(type(m.sounds)="roArray")
            m.alarmsound=m.sounds[m.alarmselected]
            txt=m.sounds[0]
        endif
    endif
    alarm_sound_canvas={text:"<"+txt+">",textAttrs:{HAlign:"center",font:m.app.h3},targetRect:{y:600,w:200,x:800,h:60}}
    m.canvas.setlayer(54, alarm_sound_canvas)
End Function

Function settings_sleep_set_alarm_time() as void
    if (m.alarmhour="0")
        m.alarmhour="00"
    endif
    if (m.alarmminutes="0")
        m.alarmminutes="00"
    endif
    alarm_time_canvas = {text:"< "+m.alarmhour+" : "+m.alarmminutes+" "+m.alarmtime+" >",textAttrs:{HAlign:"center",font:m.app.h3},targetRect:{y:600,w:200,x:600,h:60}}
    'sleep_timer={text:minutes,textAttrs:{HAlign:"center",font:m.app.h3},targetRect:m.positions[0]}    
    m.canvas.setLayer(55,alarm_time_canvas)
End Function

Function change_alarm_timer(index) as void
    
    if (index=3)
        if (m.position=2)
            alarm = m.alarmhour.toInt()
            if (alarm<12)
                alarm = alarm + 1
            endif
            m.alarmhour = Str(alarm)
        else if (m.position=3)
            alarm = m.alarmminutes.toInt()
            if (alarm<60)
                alarm = alarm + 5
            endif
            m.alarmminutes = Str(alarm)
        else if (m.position=4)
            if (m.alarmtime="am")
                m.alarmtime="pm"
            else
                m.alarmtime="am"
            endif
        endif
    else if (index=2)
        if (m.position=2)
            alarm = m.alarmhour.toInt()
            if (alarm>0)
                alarm = alarm - 1
            endif
            m.alarmhour = Str(alarm)
        else if (m.position=3)
            alarm = m.alarmminutes.toInt()
            if (alarm>0)
                alarm = alarm - 5
            endif
            m.alarmminutes = Str(alarm)
        else if (m.position=4)
            if (m.alarmtime="am")
                m.alarmtime="pm"
            else
                m.alarmtime="am"
            endif
        endif
    end if
    
    if (m.alarmhour="0")
        m.alarmhour="00"
    endif
    if (m.alarmminutes="0")
        m.alarmminutes="00"
    endif
    
    'print m.alarmhour
    'print m.alarmminutes
    
    alarm_time_canvas = {text:"< "+m.alarmhour+" : "+m.alarmminutes+" "+m.alarmtime+" >",textAttrs:{HAlign:"center",font:m.app.h3},targetRect:{y:600,w:200,x:600,h:60}}
        
    m.canvas.setLayer(55,alarm_time_canvas)
    
End Function

function settings_sleep_to_minutes(t) as string
    
    available_time=t.toInt()
    'Convert the available time to hours
    'And Fix for take only the ours
    integer_minutes=Fix(available_time/60000)
    minutes=integer_minutes.toStr().trim()
       
    
    return minutes

end function




function settings_sleep_draw_ring() as void
    
    if(m.position=-1) 
        m.position=0
        m.drawRing()
        return
    endif
    t=m.positions[m.position]
    
    if IsHD()
        w_=200
    else
        w_=200
    endif
    x_=t.x
    if(m.position=0)
        if IsHD()
            w_=190
            xtemp = x_-23
        else
            w_=50
            xtemp = x_-11
        endif
    else if (m.position=1)
        if IsHD()
            w_=190
            xtemp = x_+23
        else
            w_=120
            xtemp = x_+20
        endif
    else if (m.position=2)
        if IsHD()
            w_=40
            xtemp = 635
            t.y = 600
        else
            w_=40
            xtemp = x_+20
        endif
    else if (m.position=3)
        if IsHD()
             w_=40
            xtemp = 685
            t.y = 600
        else
            w_=120
            xtemp = x_+20
        endif
    else if (m.position=4)
        if IsHD()
             w_=40
            xtemp = 723
            t.y = 600
        else
            w_=120
            xtemp = x_+20
        endif
    else if (m.position=5)
        if IsHD()
             w_=190
            xtemp = 805
            t.y = 600
        else
            w_=120
            xtemp = x_+20
        endif
    endif
    if IsHD()
        trgt={x:xtemp,y:t.y+41,w:w_,h:2}
    else
        trgt={x:xtemp,y:t.y+25,w:w_,h:2}
    endif
    m.canvas.setLayer(53,{color:"#ffFFCC00",targetRect:trgt})

end function


function settings_sleep_hide_ring() as void
    
    m.canvas.clearLayer(53)

end function



function settings_sleep_change_timer(index) as void
                
        timer=m.sleep_timer.toInt()
'        minutes=1800000
        
        minutes=60000
        maxtimer=7200000
        
        if(index=4)
            if(timer>minutes)timer=timer-minutes
        else if index=5
            if(timer<maxtimer)timer=timer+minutes
        end if
        
        m.sleep_timer=timer.toStr()
        m.setTimerPicker()
        
end function


function settings_sleep_change_sound(index) as void

    selected=m.selected
    
    'Avoid runtime error when hasn't sounds
    if type(m.sounds)<>"roArray" return
            
    total=m.sounds.count()
    counter=total-1

    'Reduce the selected position
    if(index=4)
        selected=selected-1
            if(selected<0)selected=counter            
    'Increment the selected position
    else if index=5
        selected=selected+1
            if(selected>counter)selected=0   
    endif
    
    m.selected=selected

    txtselected=m.sounds[selected]
    m.sleep_sound=txtselected
    
    m.setSoundPicker(true)
    
end function




function settings_sleep_remote_callback(index) as void

    'Do anything when in main
    if m.app.menu.inMain return
    'print "index"
    'print index
    
    if(index=4 or index=5)
        'print "position"
        'print m.position
        if (m.hourlock=false AND m.minutelock=false AND m.timelock=false AND m.alarmsoundlock=false)
            if(m.position=0)
                m.changeTimer(index)
            else if(m.position=1)
                m.changeSound(index)
            else if(m.position=2)
                if (index=5)
                    m.position=3
                end if
                m.drawRing()
            else if (m.position=3)
                if (index=4)
                    m.position=2
                else if (index=5)
                    m.position=4
                end if
                m.drawRing()
            else if (m.position=4)
                if (index=4)
                    m.position=3
                else if (index=5)
                    m.position=5
                endif
                m.drawRing()
            else if (m.position=5)
                if (index=4)
                    m.position=4
                endif
                m.drawRing()
            endif
        endif
    else if(index=2 or index=3 or index=6)
       
            if (index=2)
                    if(m.position=0) 
                        m.goBack()
                        return
                    else 
                        if (m.position=1)
                            m.position=0
                        else if (m.position=2)
                            if (m.hourlock=false)
                                m.position=1
                            else
                                m.changealarmtimer(index)
                            endif
                        else if (m.position=3)
                            if (m.minutelock=false)
                                m.position=1
                            else
                                m.changealarmtimer(index)
                            endif
                        else if (m.position=4)
                            if (m.timelock=false)
                                m.position=1
                            else
                                m.changealarmtimer(index)
                            endif
                        else if (m.position=5)
                            if (m.alarmsoundlock=false)
                                m.position=1
                            else
                                m.changealarmtimer(index)
                            endif                            
                        endif
                    endif
                m.drawRing()
            else if(index=3)
                    if(m.position=0)
                        m.position=1
                        m.changeSound(index)
                    else if (m.position=1)
                        m.position=2
                    else if (m.position=2)
                        if (m.hourlock=true)
                            m.changealarmtimer(index)
                        endif
                    else if (m.position=3)
                        if (m.minutelock=true)
                            m.changealarmtimer(index)
                        endif
                    else if (m.position=4)
                        if (m.timelock=true)
                            m.changealarmtimer(index)
                        endif
                    else if (m.position=5)
                        if (m.alarmsoundlock=true)
                            m.changealarmtimer(index)
                        endif
                    endif
                m.drawRing()
            else if (index=6)
                if (m.position=2 and m.hourlock=false)
                    m.hourlock = true
                    alarm_focus = {url:"pkg:/images/updown_focus.png",targetRect:{x:630,y:575,w:48,h:112}}
                    m.canvas.setLayer(56,alarm_focus)
                else if (m.position=3 and m.minutelock=false)
                    m.minutelock = true
                    alarm_focus = {url:"pkg:/images/updown_focus.png",targetRect:{x:680,y:575,w:48,h:112}}
                    m.canvas.setLayer(56,alarm_focus)
                else if (m.position=4 and m.timelock=false)
                    m.timelock = true
                    alarm_focus = {url:"pkg:/images/updown_focus.png",targetRect:{x:720,y:575,w:48,h:112}}
                    m.canvas.setLayer(56,alarm_focus)
                else if (m.position=5 and m.alarmsoundlock=false)
                    m.alarmsoundlock = true
                    alarm_focus = {url:"pkg:/images/updown_focus.png",targetRect:{x:870,y:575,w:48,h:112}}
                    m.canvas.setLayer(56,alarm_focus)
                else if (m.position=2 and m.hourlock=true)
                    m.hourlock = false
                    m.canvas.clearLayer(56)
                else if (m.position=3 and m.minutelock=true)
                    m.minutelock = false
                    m.canvas.clearLayer(56)
                else if (m.position=4 and m.timelock=true)
                    m.timelock = false
                    m.canvas.clearLayer(56)
                else if (m.position=5 and m.alarmsoundlock=true)
                    m.alarmsoundlock = false
                    m.canvas.clearLayer(56)
                endif
                
            endif
            
                
    endif



end function



function settings_sleep_on_return(index) as boolean
        
         m.canvas.clearLayer(53)
         'm.canvas.clearLayer(54)
         'm.canvas.clearLayer(55)
        'Do nothing when in main
         if m.app.menu.inMain return true
        
        'Getting start and final values from settings
        timer_st=m.start_sleep_timer
        timer=m.sleep_timer
        sound_st=m.start_sleep_sound
        sound=m.sleep_sound
        
        'Determine if there are changes to save or not
        if(timer<>timer_st or sound<>sound_st)
            
            if (m.app.trial) then
            m.app.audio.player.stop()
            ws="getPopup.php?id=12"
            popup=m.app.http.getWs(ws)
            r=m.app.dialog.confirm2(popup[0].content,[popup[0].option_1,popup[0].option_2])
                
                if r=1 then
                      'ws="getPopup.php?id=1"
                      'popup=m.app.http.getWs(ws)
                      'r2=m.app.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
                      '  options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                      'if r2=2
                      '  m.app.subscribe(3)
                      'else if r2=1
                      '  m.app.subscribe(2)
                      'else
                      '  m.app.subscribe(1)
                      'endif
                      m.app.istrial()   
                else
                        'Reset to the original values
                    m.sleep_timer=m.start_sleep_timer
                    m.sleep_sound=m.start_sleep_sound
                    
                    m.setTimerPicker()
                    m.setSoundPicker()
                endif
            
                return true
                
            else    
              confirm=m.app.dialog.confirm("Save changes? (Please wait 20 seconds or so while the system implements these changes)",["Yes","No"])
              if(confirm)
                    userid=m.app.userid
                    sound=m.app.http.Http.Escape(sound)
                    m.app.sleepSound = m.selected
                    'shutoff_timer = m.app.settings.shutoff_timer + 1800000
                    ws="setSettings.php?user_id="+userid+"&settings%5Bsleep_timer%5D="+timer+"&settings%5Bsleep_sound%5D="+sound '+"&settings%5Bshutoff_timer%5D="+shutoff_timer.tostr()
                    
                    r=m.app.http.getWs(ws)
                    
                                        
                    if(type(r)<>"roInvalid")
                        if(r.done=1)
                            m.app.settings.sleep_timer=timer.toInt()
                            DownloadFile(r.sleep_sound,"sleep.wma")
                            return true
                        else 
                            return false
                        endif
                    endif
              else
              
                    
                    'Reset to the original values
                    m.sleep_timer=m.start_sleep_timer
                    m.sleep_sound=m.start_sleep_sound
                    
                    m.setTimerPicker()
                    m.setSoundPicker()
                    m.app.audio.player.stop()
              
              endif
            endif
              return true
                        
        endif
    
    st=m.start_shuttime_off

    return true

end function

function settings_sleep_go_back() as void
    m.app.remoteIndex=0
    m.parent.remoteCallback(7)
    m.canvas.clearLayer(53)
end function




