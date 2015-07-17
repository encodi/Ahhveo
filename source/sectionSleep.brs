Function sleep_section(s) as void

this={
     app:s.app
     canvas:s.app.canvas
     remoteCallback:sleep_remote_callback
     sleepPaint:sleep_paint
     sleepPaintAdvanced:sleep_advanced
     clearSleep:clear_sleep
     clearSleepAdvanced:clear_sleep_advanced
     sleepPaintStatic:paint_static2
     paintTopMenuSelector:paint_top_menu_selector2
     paintSubTopMenuSelector:paint_subtop_menu_selector2
     clearTop:clear_top
     clearSubTop:clear_subtop
     inTopMenu:true
     inSubTopMenu:false
     inBelowItems:false
     isnatural:false
     topMenuIndex:1
     subTopMenuIndex:0
     paintBedTimeText:paint_bedtime_text
     paintBedTimeThumby:paint_bedtime_thumby
     paintBedTimeSelector:paint_bedtime_selector
     paintBedTimeTimer:paint_bedtime_timer
     paintBedTimeSound:paint_bedtime_sound
     sleepyData:[]
     sleepyThumbnails:[]
     sleepyBG:[]
     paintSleepyBG:paint_sleepy_bg
     clearSleepyBG:clear_sleepy_bg
     sleepyLimit:4
     paintWakeUpText:paint_wakeup_text
     paintWakeUpThumby:paint_wakeup_thumby
     paintWakeUpTimer:paint_wakeup_timer
     paintWakeUpAlarm:paint_wakeup_alarm
     wakeupData:[]
     wakeupThumbnails:[]
     wakeupBG:[]
     paintWakeUpBG:paint_wakeup_bg
     clearWakeUpBG:clear_wakeup_bg
     paintAlarmBG:paint_alarm_bg
     clearAlarmBG:clear_alarm_bg
     paintSoundDurationText:paint_soundduration_text
     paintSleepTimeDuration:paint_sleeptime_duration
     paintWakeUpDurationText:paint_wakeupduration_text
     paintWakeUpTimeDuration:paint_wakeup_duration
     clearBTSelector:clear_bt_selector
     clearWUSelector:clear_wu_selector
     bMoveLeft:b_move_left
     bMoveRight:b_move_right
     wMoveLeft:w_move_left
     wMoveRight:w_move_right
     dMoveLeft:d_move_left
     dMoveRight:d_move_right
     tbs:1
     sss:0
     sleepsound:["No Sound","Ocean Waves","Peaceful Frogs","Relaxing Crickets","Sleepy Thunder","Summer Rain","Chorus Frogs"]
     wakeuptime:["7","00","am"]
     alarmchime:["Coo Coo Clock","Buzz Clock"]
     alarmchimewhen:["Yes, before the video","Yes, after the video","No, thanks"]
     std:0
     wuvd:0
     belowItemsIndex:0
     paintBelowItemsSelector:paint_below_items_selector
     clearBelowItemsSelector:clear_below_items_selector
     paintBedTimeArrows:paint_bedtime_arrows
     isInCarousel1:false
     isInCarousel2:false
     inBedTimeTimer:false
     inBedTimeSound:false
     inWakeUpTimer:false
     inAlarmSounds:false
     inAlarmWhen:false
     inSleepTimeDuration:false
     inWakeUpTimeDuration:false
     paintWakeUpArrows:paint_wakeup_arrows
     ac:0
     acw:0
     sleeptimeduration:0
     wakeupvideoduration:0
     sleepSettingsData:[]
     bedtime_video_id:0
     wakeup_video_id:0
     currentdate:CreateObject("roDateTime")
     paintNowDate:paint_now_date
     timeflag:false
     saveSettings:save_settings
     clearAll:clear_all2
     startYourSleepButton:start_your_sleep_button
     sleepStartMessage:sleep_start_message
     clearSleepStartMessage:clear_sleep_start_message
     resetButton:reset_button
     mainSelector:main_selector
     clearMainSelector:clear_main_selector
     inStartYourSleepButton:false
     inResetSleepButton:false
     inMainSelector:false
     menuSelectorIndex:0
     inBedTimeSelector:false
     inDarkScreenSelector:false
     paintSaveButton1:paint_save_button_1
     paintSaveButton2:paint_save_button_2
     paintSaveButton3:paint_save_button_3
     inSaveButton1:false
     inSaveButton2:false
     inSaveButton3:false
     clearMainSelection:clear_main_selection
     paintDarkScreenSoundsThumby:paint_dark_screen_sounds_thumby
     darkScreenSoundData:[]
     darkScreenThumbnails:[]
     paintAudioPlayTime:paint_audio_play_time
     inDarkScreenAudioSelect:false
     inAudioTimerChoice:false
     audioTimerIndex:0
     inAudioTimerSubChoice:false
     inAlarmQuestion1:false
     inAlarmQuestion2:false
     inAlarmQuestion3:false
     inAlarmQuestion4:false
     paintQuestion1:paint_question_1
     paintQuestion2:paint_question_2
     paintQuestion3:paint_question_3
     paintQuestion4:paint_question_4
     alarmAnswer1:"No"
     inWakeUpCarousel:false
     inStopVideoAfter:false
     paintStopVideoAfter:paint_stop_video_after
     selectedBedVideoIndex:0
     selectedAlarmSoundIndex:0
     selectedWakeUpVideoIndex:0
     paintBedTimeThumb:paint_bedtime_thumb
     paintBedTimeSoundThumb:paint_bedtime_sound_thumb
     paintWakeUpThumb:paint_wakeup_thumb
     clearSleepSection:clear_sleep_section
     resetPreferences:reset_preferences
     isThumb1:false
     isThumb2:false
     isThumb3:false
     showSubSectionOptions:show_subsection_options
     clearSubSectionOptions:clear_subsection_options
     updatedflag:false
     paintSleepArrowDown:paint_sleep_arrow_down
     responseToAnswer1:"No"
     darkscreenselectedindex:0
     inStep:1
     sleepLength:0
     wakeupLength:0
     inPreviewSound:false
     previewSoundText:preview_sound_text
     wakeupalarmsound:invalid
     wakeupalarms:invalid
     naturaltimesdata:invalid
     naturaltimes:[]
     paintSleepMarketing:paint_marketing2
     clearSleepMarketing:clear_marketing2
     }

this.currentdate.ToLocalTime()
this.sleepPaint()
this.sleepPaintStatic()
s.app.remoteListener=this

end Function

Function sleep_paint() as void
    m.canvas.clearLayer(29)
    m.canvas.clearLayer(38)
    m.canvas.clearLayer(39)
    m.canvas.clearLayer(40)
    m.canvas.clearLayer(41)
    m.canvas.clearLayer(42)
    m.canvas.clearLayer(43)
    m.canvas.clearLayer(50)
    m.canvas.clearLayer(51)
    m.canvas.clearLayer(60)
    m.canvas.clearLayer(61)
    m.canvas.clearLayer(62)
    m.canvas.clearLayer(30)
    m.canvas.clearLayer(31)
    m.canvas.clearLayer(32)
    'm.canvas.clearLayer(33)
    m.canvas.clearLayer(34)
    m.canvas.clearLayer(35)
    m.canvas.clearLayer(70)
    m.canvas.clearLayer(131)

    m.sleepStartMessage()

    m.sleepSettingsData=m.app.http.getWs("getSleepSettings.php?user_id="+m.app.userid)
    '''
    m.tbs = m.sleepSettingsData.bedtime_before_sleep.toInt()
    m.sss = m.sleepSettingsData.bedtime_sound.toInt()
    m.wakeuptime[0] = m.sleepSettingsData.wakeup_time_h
    m.wakeuptime[1] = m.sleepSettingsData.wakeup_time_m
    m.wakeuptime[2] = m.sleepSettingsData.wakeup_time_dt
    m.responseToAnswer1 = m.sleepSettingsData.answer1
    m.ac = m.sleepSettingsData.wakeup_sound.toInt()
    m.acw = m.sleepSettingsData.wakeup_sound_when.toInt()
    m.sleeptimeduration = m.sleepSettingsData.bedtime_sound_duration.toInt()
    print "sleeptimeduration"
    print m.sleeptimeduration
    m.wakeupvideoduration = m.sleepSettingsData.wakeup_video_duration.toInt()
    m.bedtime_video_id = m.sleepSettingsData.bedtime_video_id.toInt()
    m.wakeup_video_id = m.sleepSettingsData.wakeup_video_id.toInt()
    m.audiotimerindex = m.sleepSettingsData.audiotimerindex.toInt()

    if (m.sleepSettingsData.updated="1")
        m.updatedflag = true
        'painting
        m.sleepyData=m.app.http.getWs("getSleepy.php")
        m.selectedBedVideoIndex = m.sleepyData[m.app.bIndex]
        m.paintBedTimeThumb()

        m.darkScreenSoundData=m.app.http.getWs("getSleepSound.php?user_id="+m.app.userid)
        m.selectedAlarmSoundIndex = m.darkScreenSoundData[m.app.sIndex]
        m.paintBedTimeSoundThumb()

        ''' list of alarms
        m.alarmchime = []

        m.wakeupalarms = m.app.http.getWs("getWakeUpAlarms.php")
        for each alarm in m.wakeupalarms
            m.alarmchime[alarm.array_index.toInt()] = alarm.name
        end for
        
        ''' alarm sound for wake up
        m.wakeupalarmsound = m.app.http.getWs("getWakeUpAlarmSound.php?user_id="+m.app.userid)

        'm.naturaltimesdata = m.app.http.getWs("getVideosLength.php")
        'for each natural in m.naturaltimesdata
        '    print natural
        'endfor


        m.wakeupData=m.app.http.getWs("getWakeUp.php")
        m.selectedWakeUpVideoIndex = m.wakeupData[m.app.wIndex]
        m.alarmAnswer1 = m.responseToAnswer1
        if (m.acw=2)
            if (m.alarmAnswer1="No")
                m.paintWakeUpThumb("No")
            else
                m.paintWakeUpThumb("NoSound")
            endif
        else
            if (m.alarmAnswer1="No")
                m.paintWakeUpThumb("No")
            else
                m.paintWakeUpThumb()
            endif
        endif
    else
        m.updatedflag = false
        if (m.inResetSleepButton)
            m.inResetSleepButton = false
            m.inTopMenu=true
            m.sleepPaintStatic()
        endif
    endif
    '''
    'newShadow = {url:"pkg:/images/ringdialog.png",targetRect:{w:1400,h:3,x:0,y:110}}
    'm.canvas.setLayer(10, newShadow)

    'newShadow = {url:"pkg:/images/newshadow.png",targetRect:{w:1400,h:50,x:0,y:90}}
    'm.canvas.setLayer(10, newShadow)


    if (m.updatedFlag)
        m.startYourSleepButton()
        m.resetButton()
    else
       ' starts at first main selector on click
    endif
    '#m.sleepStartMessage()

    if (m.updatedFlag=false)
        m.paintBedTimeText()
        'm.paintBedTimeThumby()
        'm.paintBedTimeTimer("No")
        m.paintBedtimeSound()
        m.paintWakeUpText()
    endif
    'm.paintNowDate()
   ' m.paintWakeUpThumby()
   ' m.paintWakeUpTimer()
  ' m.paintWakeUpAlarm()
   ' m.paintSleepyBG()
   ' m.paintWakeUpBG()
End Function


Function start_your_sleep_button(active = false) as void

    if (active)
        sleepTextTitle = {url:"pkg:/images/rect_active.png",targetRect:{w:255,h:38,x:100,y:125}}
        sleepText = {text: "Start Sleep", textAttrs: {Color: "#FFFF55",font: m.app.h3}, targetRect:{x:100,y:130,w:255,h:38}}
    else
        sleepTextTitle = {url:"pkg:/images/rect.png",targetRect:{w:255,h:38,x:100,y:125}}
        sleepText = {text: "Start Sleep", textAttrs: {Color: "#FFFFFF",font: m.app.h3}, targetRect:{x:100,y:130,w:255,h:38}}
    endif


    m.canvas.setLayer(50, sleepText)
    m.canvas.setLayer(51, sleepTextTitle)

End Function

Function main_selector(index=0, thumbselector=false) as void
    if (thumbselector=true)
        if (index=0)
            selector = {url:"pkg:/images/ring_level_1_active.png",targetRect:{w:265,h:140,x:95,y:180}}
        else if (index=1)
            selector = {url:"pkg:/images/ring_level_1_active.png",targetRect:{w:265,h:140,x:505,y:180}}
        else if (index=2)
            selector = {url:"pkg:/images/ring_level_1_active.png",targetRect:{w:265,h:140,x:915,y:180}}
        end if

    else
       if (index=0)
            selector = {url:"pkg:/images/ring_level_1_active.png",targetRect:{w:265,h:140,x:95,y:180}}
        else if (index=1)
            selector = {url:"pkg:/images/ring_level_1_active.png",targetRect:{w:265,h:140,x:505,y:180}}
        else if (index=2)
            selector = {url:"pkg:/images/ring_level_1_active.png",targetRect:{w:265,h:140,x:915,y:180}}
        end if
    endif

    m.canvas.setLayer(102, selector)

End Function


Function paint_sleep_arrow_down(index=0) as void

    arrows = []
    arrows.push({url:"pkg:/images/sleeparrowdown.png", targetRect:{w:16,h:16,x:200,y:320}})
    arrows.push({url:"pkg:/images/sleeparrowdown.png", targetRect:{w:16,h:16,x:630,y:270}})
    arrows.push({url:"pkg:/images/sleeparrowdown.png", targetRect:{w:16,h:16,x:960,y:270}})

    'm.canvas.setLayer(555, arrows[index])

End Function

Function reset_button(active = false) as void

    if (active)
        sleepTextTitle = {url:"pkg:/images/ring_play_100.png",targetRect:{w:220,h:2,x:370,y:160}}
        resetText = {text:"Reset Sleep Preferences", textAttrs: {Color: "#FFFF55", font: m.app.h4}, targetRect: {x:355,y:130,w:250,h:40}}
        m.canvas.setLayer(41, sleepTextTitle)
    else
        m.canvas.clearLayer(41)
        'sleepTextTitle = {url:"pkg:/images/ring_play_100.png",targetRect:{w:250,h:2,x:450,y:160}}
        resetText = {text:"Reset Sleep Preferences", textAttrs: {Color: "#FFFFFF", font: m.app.h4}, targetRect: {x:355,y:130,w:250,h:40}}
    endif

    'm.canvas.setLayer(41, sleepTextTitle)
    m.canvas.setLayer(40, resetText)


End function


Function sleep_start_message(mkt=true) as void

    tutorialImage = {url:"pkg:/images/tutorial_image2.png", targetRect:{w:1148,h:210,x:85,y:410}}

    startMessage = {text:"Go to sleep with a sunset, sleep with the sound of the ocean waves and awakened by the sunrise.", textAttrs:{HAlign:"Center",Color:"#FFFFFF",font: m.app.h3}, targetRect:{x:60,y:610,w:1150,h:50}}

    copyright = {text:"Patent Pending, Copyright 2015 Ahhveo Inc.", textAttrs:{HAlign:"Center",Color:"#CCCCCC",font: m.app.h4}, targetRect:{x:480,y:670,w:1150,h:50}}
    'm.canvas.setLayer(101, startMessage)

    if (mkt) m.canvas.setLayer(69, tutorialimage)
    m.canvas.setLayer(777, copyright)

End Function



Function save_settings() as void
    wutime = m.wakeuptime[0]+","+m.wakeuptime[1]+","+m.wakeuptime[2]
    if (m.inStep=3)
        update="1"
    else
        update="0"
    endif
    datastring = "?user_id="+m.app.userid+"&bedtime_video_id="+m.bedtime_video_id.toStr()+"&bedtime_before_sleep="+m.tbs.toStr()+"&bedtime_sound="+m.sss.toStr()+"&wakeup_video_id="+m.wakeup_video_id.toStr()+"&wakeup_time="+wutime+"&wakeup_sound="+m.ac.toStr()+"&wakeup_sound_when="+m.acw.toStr()+"&bedtime_sound_duration="+m.sleeptimeduration.toStr()+"&wakeup_video_duration="+m.wakeupvideoduration.toStr()+"&wakeup_answer_1="+m.alarmAnswer1+"&audiotimerindex="+m.audiotimerindex.toStr()+"&update="+update
    dataResponse = m.app.http.getWs("setSleepSettings.php"+datastring)
    print dataResponse
    m.updatedFlag = dataResponse.update
    if (m.updatedFlag="0")
        m.updatedFlag=false
    else if (m.updatedFlag="1")
        m.updatedFlag=true
    endif
End Function

Function paint_now_date() as void
    m.currentdate = CreateObject("roDateTime")
    m.currentdate.ToLocalTime()
    if (m.currentdate.GetHours()>11 AND m.currentdate.GetHours()<24)
        dt = "pm"
        hr = m.currentdate.GetHours()-12
    else
        if (m.currentdate.GetHours()=24)
            hr = 0
        else
            hr = m.currentdate.GetHours()
        endif
        dt = "am"
    endif
    if (m.currentdate.GetMinutes()<10)
        nowdatetext = {text: "Current time: "+hr.toStr()+":0"+m.currentdate.GetMinutes().toStr()+" "+dt, textAttrs: {Color:"#FFFFFF",HAlign:"Left",font: m.app.h4}, targetRect:{x:60,y:670,w:300,h:50}}
    else
        nowdatetext = {text: "Current time: "+hr.toStr()+":"+m.currentdate.GetMinutes().toStr()+" "+dt, textAttrs: {Color:"#FFFFFF",HAlign:"Left",font: m.app.h4}, targetRect:{x:60,y:670,w:300,h:50}}
    endif
    m.canvas.setLayer(300, nowdatetext)

End Function




Function sleep_advanced() as void
    m.paintSoundDurationText()
    'm.paintSleepTimeDuration()
    m.paintWakeUpDurationText()
    m.paintWakeUpTimeDuration()
End Function


Function paint_soundduration_text(active="No") as void
    sounddurationTextTitle = {url:"pkg:/images/rect.png",targetRect:{w:730,h:30,x:40,y:165}}
    if (active="No")
        sounddurationText = {text: "Choose duration of time you want the sound to be playing with the screensaver", textAttrs: {Color:"#666666",HAlign:"Left",font: m.app.h4}, targetRect:{x:60,y:160,w:1050,h:50}}
    else if (active="Yes")
        sounddurationText = {text: "Choose duration of time you want the sound to be playing with the screensaver", textAttrs: {Color:"#FFFFFF",HAlign:"Left",font: m.app.h4}, targetRect:{x:60,y:160,w:1050,h:50}}
    endif
    m.canvas.setLayer(70, sounddurationText)
    m.canvas.setLayer(71, sounddurationTextTitle)
end function


Function paint_sleeptime_duration(active="No", inmovement=false, innumbermovement=false) as void
    sleepText = []
    sleepTextPositions = []
    sleepTextPositions.push({x:880,y:425,w:400,h:50})
    sleepTextPositions.push({x:880,y:470,w:400,h:50})
    sleepTextPositions.push({x:880,y:515,w:400,h:50})

    if (m.selectedBedVideoIndex.length.toInt()>0 AND inmovement=false AND innumbermovement=false)
        secs = m.selectedBedVideoIndex.length.toInt()
        m.tbs = secs
        m.isnatural=true
    else if (m.selectedBedVideoIndex.length.toInt()>0 AND inmovement=true AND innumbermovement=false)
        secs = m.selectedBedVideoIndex.length.toInt()
        m.tbs=secs
        m.isnatural=true
    else if (m.selectedBedVideoIndex.length.toInt()>0 AND inmovement=true AND innumbermovement=true)
        secs = m.tbs
        print m.selectedBedVideoIndex.length.toInt()
        if (m.selectedBedVideoIndex.length.toInt()=secs)
            m.isnatural=true
        else
            m.isnatural=false
        endif
    else
        secs = m.tbs
        m.isnatural=false
    endif

    secs = CINT(secs/60)

    if (m.isnatural)
        naturalsecs = "("+secs.toStr()+" minutes)"
    else
        naturalsecs = "( - )"
    endif

    if (active="No")
        sleepText.push({text: "Go to dark screen after: ", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:sleepTextPositions[0]})
        if (m.isnatural) sleepText.push({text: "Natural", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:sleepTextPositions[1]})
        sleepText.push({text: "<   "+secs.toStr()+"   > minutes", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:sleepTextPositions[2]})
    else if (active="Yes")
        sleepText.push({text: "Go to dark screen after: ", textAttrs: {Color:"#FFFFFF",font: m.app.h3}, targetRect:sleepTextPositions[0]})
        if (m.isnatural) sleepText.push({text: "Natural", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:sleepTextPositions[1]})
        sleepText.push({text: "<   "+secs.toStr()+"   > minutes", textAttrs: {Color:"#FFFFFF",font: m.app.h3}, targetRect:sleepTextPositions[2]})
    else if (active="Active")
        sleepText.push({text: "Go to dark screen after: ", textAttrs: {Color:"#FFFFFF",font: m.app.h3}, targetRect:sleepTextPositions[0]})
        if (m.isnatural) sleepText.push({text: "Natural", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:sleepTextPositions[1]})
        sleepText.push({text: "<   "+secs.toStr()+"   > minutes", textAttrs: {Color:"#FFFF55",font: m.app.h3}, targetRect:sleepTextPositions[2]})
    endif
    m.canvas.setlayer(84,sleepText)
    'm.canvas.setlayer(83,sleepNaturalText)
End Function


Function paint_save_button_1(active = "No") as void
    if (active = "Active")
        saveborder = {url:"pkg:/images/rect_active.png",targetRect:{w:170,h:32,x:1000,y:580}}
        savetext = {text: "Save", textAttrs: {Color:"#FFFF55",HAlign:"Center",font: m.app.h3}, targetRect:{x:1000,y:585,w:170,h:32}}
    else
        saveborder = {url:"pkg:/images/rect.png",targetRect:{w:170,h:32,x:1000,y:580}}
        savetext = {text: "Save", textAttrs: {Color:"#666666",HAlign:"Center",font: m.app.h3}, targetRect:{x:1000,y:585,w:170,h:32}}
    endif
    m.canvas.setLayer(85, saveborder)
    m.canvas.setLayer(86, savetext)
End Function


Function paint_save_button_2(active = "No") as void
    if (active = "Active")
        saveborder = {url:"pkg:/images/rect_active.png",targetRect:{w:170,h:32,x:975,y:555}}
        savetext = {text: "Save", textAttrs: {Color:"#FFFF55",HAlign:"Center",font: m.app.h3}, targetRect:{x:975,y:560,w:170,h:32}}
    else
        saveborder = {url:"pkg:/images/rect.png",targetRect:{w:170,h:32,x:975,y:555}}
        savetext = {text: "Save", textAttrs: {Color:"#666666",HAlign:"Center",font: m.app.h3}, targetRect:{x:975,y:560,w:170,h:32}}
    endif
    m.canvas.setLayer(85, saveborder)
    m.canvas.setLayer(86, savetext)
End Function

Function paint_save_button_3(active = "No") as void
    if (active = "Active")
        saveborder = {url:"pkg:/images/rect_active.png",targetRect:{w:170,h:32,x:980,y:597}}
        savetext = {text: "Save", textAttrs: {Color:"#FFFF55",HAlign:"Center",font: m.app.h3}, targetRect:{x:980,y:600,w:170,h:32}}
    else
        saveborder = {url:"pkg:/images/rect.png",targetRect:{w:170,h:32,x:980,y:597}}
        savetext = {text: "Save", textAttrs: {Color:"#666666",HAlign:"Center",font: m.app.h3}, targetRect:{x:980,y:600,w:170,h:32}}
    endif
    m.canvas.setLayer(85, saveborder)
    m.canvas.setLayer(86, savetext)
End Function


Function paint_wakeupduration_text(active="No") as void
    wakeupdurationTextTitle = {url:"pkg:/images/rect.png",targetRect:{w:560,h:30,x:40,y:300}}
    if (active="No")
        wakeupdurationText = {text: "Choose duration of time you want the wake up video to play", textAttrs: {Color:"#666666",HAlign:"Left",font: m.app.h4}, targetRect:{x:60,y:295,w:650,h:50}}
    else if (active="Yes")
        wakeupdurationText = {text: "Choose duration of time you want the wake up video to play", textAttrs: {Color:"#FFFFFF",HAlign:"Left",font: m.app.h4}, targetRect:{x:60,y:295,w:650,h:50}}
    endif
    m.canvas.setLayer(74, wakeupdurationText)
    m.canvas.setLayer(75, wakeupdurationTextTitle)
End Function

Function preview_sound_text(loading=false, specialcase=false) as void

    if (m.inPreviewSound AND loading=false)
        textabove = {text: "Push again to choose", textAttrs: {Color:"#FFFFFF",HAlign:"Left",font: m.app.h5}, targetRect:{x:110,y:490,w:140,h:50}}
    else if (loading=false)
        textabove = {text: "Select to hear", textAttrs: {Color:"#FFFFFF",HAlign:"Left",font: m.app.h5}, targetRect:{x:110,y:480,w:140,h:50}}
    else if (loading=true)
        textabove = {text: "Loading Sample...", textAttrs: {Color:"#FFFFFF",HAlign:"Left",font: m.app.h5}, targetRect:{x:110,y:480,w:140,h:50}}
    endif

    m.canvas.setLayer(281, textabove)

End Function

Function paint_wakeup_duration(active="No") as void
    if (active="No")
        wakeupText = {text: "Wake Up Video Duration: ", textAttrs: {Color:"#666666",font: m.app.h4}, targetRect:{x:45,y:350,w:300,h:50}}
        wakeupTextSelector = {text: "<   "+m.wakeupvideoduration.toStr()+"   > minutes", textAttrs: {Color:"#666666",font: m.app.h4}, targetRect:{x:45,y:370,w:300,h:50}}
    else if (active="Yes")
        wakeupText = {text: "Wake Up Video Duration: ", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:45,y:350,w:300,h:50}}
        wakeupTextSelector = {text: "<   "+m.wakeupvideoduration.toStr()+"   > minutes", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:45,y:370,w:300,h:50}}
    else if (active="Active")
        wakeupText = {text: "Wake Up Video Duration: ", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:45,y:350,w:300,h:50}}
        wakeupTextSelector = {text: "<   "+m.wakeupvideoduration.toStr()+"   > minutes", textAttrs: {Color:"#FFFF55",font: m.app.h4}, targetRect:{x:45,y:370,w:300,h:50}}
    endif
    m.canvas.setlayer(76,wakeupText)
    m.canvas.setlayer(77,wakeupTextSelector)
End Function

Function paint_bedtime_text(active=true) as void

    if (active)
        sleepText = {text: "Choose your bedtime video and how long it should play.", textAttrs: {HAlign:"Center",Color: "#FFFFFF",font: m.app.hnova}, targetRect:{x:105,y:230,w:245,h:50}}
    else
        sleepText = {text: "Choose your bedtime video and how long it should play.", textAttrs: {HAlign:"Center",Color: "#666666",font: m.app.hnova}, targetRect:{x:105,y:230,w:245,h:50}}
    endif
    m.canvas.setLayer(52, sleepText)

end function

Function paint_bedtime_thumb() as void
    bedtimethumb = []
    secs = CINT(m.tbs/60)
    bedtimethumb.push({url: m.selectedBedVideoIndex.thumbnail, targetRect: {x:100, y: 185, w:256, h:130}}) '176x98
    bedtimethumb.push( {text: "Will play for around      minutes.", textAttrs: {HAlign:"Left",Color: "#FFFFFF",font: m.app.h4}, targetRect:{x:95,y:305,w:300,h:50}})
    bedtimethumb.push( {text: secs.toStr(), textAttrs: {HAlign:"Left",Color: "#fe7902",font: m.app.h4}, targetRect:{x:265,y:305,w:300,h:50}})
    m.canvas.setLayer(52, bedtimethumb)
End Function

Function paint_bedtime_thumby(movement=false, active=false) as void
    if (NOT movement)
        m.sleepyData=m.app.http.getWs("getSleepy.php")
        m.selectedBedVideoIndex = m.sleepyData[0]
    endif
    m.sleepyThumbnails=[]
    xSleepy = 0
    i = 0
    if (active)
        bedtimeText = {text: "Choose a video to fall sleep to:", textAttrs: {HAlign:"Center",Color: "#FFFFFF",font: m.app.h3}, targetRect:{x:65,y:420,w:400,h:50}}
    else
        bedtimeText = {text: "Choose a video to fall sleep to:", textAttrs: {HAlign:"Center",Color: "#666666",font: m.app.h3}, targetRect:{x:65,y:420,w:400,h:50}}
    endif
    for each thumb in m.sleepyData
        if (i<m.sleepyLimit)
            m.sleepyThumbnails.push({url: thumb.thumbnail, targetRect: {x:100 + xSleepy, y: 490, w:176, h: 98}}) '176x98
            xSleepy = xSleepy + 191
        end if
        i = i + 1
    end for
    m.paintBedTimeArrows("No")
    m.canvas.setlayer(71, bedtimeText)
    m.canvas.setlayer(72, m.sleepyThumbnails)

End Function


Function paint_dark_screen_sounds_thumby(movement=false,active=false) as void

    if (NOT movement)
       m.darkScreenSoundData=m.app.http.getWs("getSleepSound.php?user_id="+m.app.userid)
       m.selectedAlarmSoundIndex = m.darkScreenSoundData[0]
    endif
    m.darkScreenThumbnails=[]
    xDarkScreen = 0
    i = 0
    if (active)
        darkScreenText = {text: "Choose the sound you want with the dark screen:", textAttrs: {HAlign:"Center",Color: "#FFFFFF",font: m.app.h3}, targetRect:{x:65,y:420,w:600,h:50}}
        darkScreenDescription = {text: "Dark screen and sounds continue for 12 hours or until Video Wake Up, they do not use streaming time.", textAttrs: {HAlign:"Center",Color: "#FFFFFF",font: m.app.h5}, targetRect:{x:100,y:580,w:750,h:50}}
    else
        darkScreenText = {text: "Choose the sound you want with the dark screen:", textAttrs: {HAlign:"Center",Color: "#666666",font: m.app.h3}, targetRect:{x:65,y:420,w:600,h:50}}
        darkScreenDescription = {text: "Dark screen and sounds continue for 12 hours or until Video Wake Up, they do not use streaming time.", textAttrs: {HAlign:"Center",Color: "#666666",font: m.app.h5}, targetRect:{x:100,y:580,w:750,h:50}}
    endif
    for each thumb in m.darkScreenSoundData
        if (i<m.sleepyLimit)
            m.darkScreenThumbnails.push({url: thumb.thumbnail, targetRect: {x:100 + xDarkScreen, y: 490, w:176, h: 98}})
            xDarkScreen = xdarkScreen + 191
        end if
        i = i + 1
    end for
    m.canvas.setLayer(131, m.darkScreenThumbnails)
    m.canvas.setLayer(120, darkScreenText)
    m.canvas.setLayer(122, darkScreenDescription)
End Function


Function paint_audio_play_time(active="No") as void

    audioplaytimetext=[]
    if (active="Yes")
        audioplaytimetext.Push({text: "How long do you want the sounds to play?", textAttrs: {Color:"#ffffff",font: m.app.h3}, targetRect:{x:940,y:415,w:260,h:40}})
        audioplaytimetext.Push({text: "All Night", textAttrs: {Color:"#ffffff",font: m.app.h3}, targetRect:{x:910,y:480,w:300,h:40}})
        'audioplaytimetext.Push({text: "No Sound", textAttrs: {Color:"#ffffff",font: m.app.h4}, targetRect:{x:910,y:600,w:300,h:40}})
        audioplaytimetext.Push({text: "< Stop after "+m.sleepTimeDuration.toStr()+" min. >", textAttrs: {Color:"#ffffff",font: m.app.h3}, targetRect:{x:910,y:515,w:300,h:40}})
    else if (active="No")
        audioplaytimetext.Push({text: "How long do you want the sounds to play?", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:{x:940,y:415,w:260,h:40}})
        if (m.audioTimerIndex=0)
            audioplaytimetext.Push({text: "All Night", textAttrs: {Color:"#fe7902",font: m.app.h3}, targetRect:{x:910,y:480,w:300,h:40}})
            'audioplaytimetext.Push({text: "No Sound", textAttrs: {Color:"#666666",font: m.app.h4}, targetRect:{x:910,y:600,w:300,h:40}})
            audioplaytimetext.Push({text: "< Stop after "+m.sleepTimeDuration.toStr()+" min. >", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:{x:910,y:515,w:300,h:40}})
        else if (m.audioTimerIndex=1)
            audioplaytimetext.Push({text: "All Night", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:{x:910,y:480,w:300,h:40}})
            'audioplaytimetext.Push({text: "No Sound", textAttrs: {Color:"#fe7902",font: m.app.h4}, targetRect:{x:910,y:600,w:300,h:40}})
            audioplaytimetext.Push({text: "< Stop after "+m.sleepTimeDuration.toStr()+" min. >", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:{x:910,y:515,w:300,h:40}})
        else if (m.audioTimerIndex=2)
            audioplaytimetext.Push({text: "All Night", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:{x:910,y:480,w:300,h:40}})
            'audioplaytimetext.Push({text: "No Sound", textAttrs: {Color:"#666666",font: m.app.h4}, targetRect:{x:910,y:600,w:300,h:40}})
            audioplaytimetext.Push({text: "< Stop after "+m.sleepTimeDuration.toStr()+" min. >", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:{x:910,y:515,w:300,h:40}})
        endif
    else if (active="Special")
        audioplaytimetext.Push({text: "How long do you want the sounds to play?", textAttrs: {Color:"#ffffff",font: m.app.h3}, targetRect:{x:940,y:415,w:260,h:40}})
        audioplaytimetext.Push({text: "All Night", textAttrs: {Color:"#ffffff",font: m.app.h3}, targetRect:{x:910,y:480,w:300,h:40}})
        'audioplaytimetext.Push({text: "No Sound", textAttrs: {Color:"#ffffff",font: m.app.h4}, targetRect:{x:910,y:600,w:300,h:40}})
        audioplaytimetext.Push({text: "< Stop after "+m.sleepTimeDuration.toStr()+" min. >", textAttrs: {Color:"#ffff55",font: m.app.h3}, targetRect:{x:910,y:515,w:300,h:40}})
    else
        audioplaytimetext.Push({text: "How long do you want the sounds to play?", textAttrs: {Color:"#ffffff",font: m.app.h3}, targetRect:{x:940,y:415,w:260,h:40}})
        audioplaytimetext.Push({text: "All Night", textAttrs: {Color:"#ffffff",font: m.app.h3}, targetRect:{x:910,y:480,w:300,h:40}})
        'audioplaytimetext.Push({text: "No Sound", textAttrs: {Color:"#ffffff",font: m.app.h4}, targetRect:{x:910,y:600,w:300,h:40}})
        audioplaytimetext.Push({text: "< Stop after "+m.sleepTimeDuration.toStr()+" min. >", textAttrs: {Color:"#ffffff",font: m.app.h3}, targetRect:{x:910,y:515,w:300,h:40}})
    endif
    m.canvas.setlayer(190, audioplaytimetext)

End Function


Function paint_sleepy_bg(active=false) as void
    m.sleepyBG = []
    xSleepyBG = 0
    i = 0
    for each thumb in m.sleepyData
        if (i<m.sleepyLimit)
            m.sleepyBG.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:100 + xSleepyBG, y: 490, w:176, h: 98}})
            xSleepyBG = xSleepyBG + 191
        endif
        i = i + 1
    endfor
    if (NOT active)
        m.canvas.setlayer(400,m.sleepyBG)
    else
        m.canvas.clearLayer(400)
    endif
End Function


Function paint_bedtime_arrows(active="No") as void
    sleepyarrows=[]
    if (active="Yes")
        sleepyarrows.Push({text: "<", textAttrs: {Color:"#ffffff",font: m.app.h2}, targetRect:{x:45,y:520,w:40,h:40}})
        sleepyarrows.Push({text: ">", textAttrs: {Color:"#ffffff",font: m.app.h2}, targetRect:{x:860,y:520,w:40,h:40}})
    else if (active="No")
        sleepyarrows.Push({text: "<", textAttrs: {Color:"#666666",font: m.app.h2}, targetRect:{x:45,y:520,w:40,h:40}})
        sleepyarrows.Push({text: ">", textAttrs: {Color:"#666666",font: m.app.h2}, targetRect:{x:860,y:520,w:40,h:40}})
    else
        sleepyarrows.Push({text: "<", textAttrs: {Color:"#ffff55",font: m.app.h2}, targetRect:{x:45,y:520,w:40,h:40}})
        sleepyarrows.Push({text: ">", textAttrs: {Color:"#ffff55",font: m.app.h2}, targetRect:{x:860,y:520,w:40,h:40}})
    endif
    m.canvas.setlayer(110, sleepyarrows)
End Function

Function paint_wakeup_thumby(movement=false, active="Yes") as void
    if (NOT movement)
        m.wakeupData=m.app.http.getWs("getWakeUp.php")
        m.selectedWakeUpVideoIndex = m.wakeupData[0]
    end if
    m.wakeupThumbnails=[]
    wakeupTitle=[]
    xSleepy = 0
    i = 0
    if (active="No")
        wakeuptitle.push({text: "Choose a video to wake up with:", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:{x:87,y:480,w:400,h:40}})
    else if (active="Yes")
        wakeuptitle.push({text: "Choose a video to wake up with:", textAttrs: {Color:"#FFFFFF",font: m.app.h3}, targetRect:{x:87,y:480,w:400,h:40}})
    else if (active="Active")
        wakeuptitle.push({text: "Choose a video to wake up with:", textAttrs: {Color:"#FFFFFF",font: m.app.h3}, targetRect:{x:87,y:480,w:400,h:40}})
    endif
    for each thumb in m.wakeupData
        if (i<m.sleepyLimit)
            m.wakeupThumbnails.push({url: thumb.thumbnail, targetRect: {x:100 + xSleepy, y: 535, w:177, h: 98}})
            xSleepy = xSleepy + 191
        end if
        i = i + 1
    end for
    m.paintWakeUpArrows("Yes")
    m.canvas.setlayer(60, m.wakeupThumbnails)
    m.canvas.setlayer(247, wakeuptitle)

End Function

Function paint_wakeup_thumb(awakened="Yes") as void
    wakeupthumb = []
    if (awakened="Yes")
        wakeupthumb.push({url: m.selectedWakeUpVideoIndex.thumbnail, targetRect: {x:920, y: 185, w:256, h:130}}) '176x98
        wakeupthumb.push( {text: "Wake up video plays at ", textAttrs: {HAlign:"Left",Color: "#FFFFFF",font: m.app.h4}, targetRect:{x:905,y:305,w:300,h:50}})
        if (m.wakeuptime[0].toInt()>11 AND m.wakeuptime[0].toInt()<24)
          daytime = "pm"
          hr = m.wakeuptime[0].toInt() - 12
          if (hr=0) hr = 12
        else
          daytime = "am"
          hr = m.wakeuptime[0].toInt()
        endif
        if (hr=24) hr=0
        wakeupthumb.push( {text: hr.toStr()+":"+m.wakeuptime[1]+" "+m.wakeuptime[2]+",", textAttrs: {HAlign:"Left",Color: "#fe7902",font: m.app.h4}, targetRect:{x:1110,y:305,w:250,h:50}})
        wakeupthumb.push( {text: m.alarmchime[m.ac] + " for " +  m.wakeupvideoduration.toStr() + " minutes.", textAttrs: {HAlign:"Left",Color: "#fe7902",font: m.app.h4}, targetRect:{x:910,y:330,w:320,h:50}})
    else if (awakened="No")
        wakeupthumb.push({text: "You will not be awakened.", textAttrs: {HAlign:"Left",Color: "#FFFFFF",font: m.app.hnova}, targetRect:{x:935,y:230,w:300,h:50}})
    else if (awakened="NoSound")
        wakeupthumb.push({url: m.selectedWakeUpVideoIndex.thumbnail, targetRect: {x:920, y: 185, w:256, h:130}}) '176x98
        wakeupthumb.push( {text: "Wake up video plays at ", textAttrs: {HAlign:"Left",Color: "#FFFFFF",font: m.app.h4}, targetRect:{x:905,y:305,w:300,h:50}})
        if (m.wakeuptime[0].toInt()>11 AND m.wakeuptime[0].toInt()<24)
          daytime = "pm"
          hr = m.wakeuptime[0].toInt() - 12
          if (hr=0) hr = 12
        else
          daytime = "am"
          hr = m.wakeuptime[0].toInt()
        endif
        if (hr=24) hr=0
        wakeupthumb.push( {text: hr.toStr()+":"+m.wakeuptime[1]+" "+m.wakeuptime[2]+".", textAttrs: {HAlign:"Left",Color: "#fe7902",font: m.app.h4}, targetRect:{x:1110,y:305,w:250,h:50}})
        wakeupthumb.push( {text: "without a separate Alarm Sound.", textAttrs: {HAlign:"Left",Color: "#fe7902",font: m.app.h4}, targetRect:{x:910,y:330,w:320,h:50}})
    endif
    m.canvas.setLayer(54, wakeupthumb)
End Function

Function paint_wakeup_bg(active=false) as void
    m.wakeupBG = []
    wakeupSoundIcon = []
    xWakeUpBG = 0
    i = 0
    wakeupPlayButton = {url:"pkg:/images/playbutton.png", targetRect:{x:175 + xWakeUpBG, y: 525, w:32, h: 32}}
    for each thumb in m.wakeupData
        if (i=0)
        '    wakeupPlayButton = {url:"pkg:/images/playbutton.png", targetRect:{x:175 + xWakeUpBG, y: 525, w:32, h: 32}}
        endif
        if (i<m.sleepyLimit)
            wakeupSoundIcon.push({url:"pkg:/images/soundicon.png", targetRect:{x:255 + xWakeUpBG, y: 495, w:16, h: 16}})
            m.wakeupBG.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:100 + xWakeUpBG, y: 490, w:176, h: 98}})
            xWakeUpBG = xWakeUpBG + 191
        endif
        i = i + 1
    endfor
    if (NOT active)
        m.canvas.setlayer(401,m.WakeUpBG)
        if (wakeupSoundIcon.count()>0)
            m.canvas.setLayer(443,wakeupSoundIcon)
        endif
        'if (wakeupPlayButton.count()>0)
            m.canvas.setLayer(444,wakeupPlayButton)
        'endif
    else
        m.canvas.clearLayer(401)
        m.canvas.clearLayer(443)
        m.canvas.clearLayer(444)
    endif
End Function

Function paint_alarm_bg(active=false) as void
    m.wakeupBG = []
    xWakeUpBG = 0
    i = 0
    for each thumb in m.wakeupData
        if (i<m.sleepyLimit)
            m.wakeupBG.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:100 + xWakeUpBG, y: 535, w:177, h: 98}})
            xWakeUpBG = xWakeUpBG + 191
        endif
        i = i + 1
    endfor
    if (NOT active)
        m.canvas.setlayer(401,m.WakeUpBG)
    else
        m.canvas.clearLayer(401)
    endif
End Function

Function paint_wakeup_arrows(active="No") as void
    wakyarrows=[]
    if (active="Yes")
        wakyarrows.Push({text: "<", textAttrs: {Color:"#ffffff",font: m.app.h2}, targetRect:{x:45,y:580,w:40,h:40}})
        wakyarrows.Push({text: ">", textAttrs: {Color:"#ffffff",font: m.app.h2}, targetRect:{x:860,y:580,w:40,h:40}})
    else if (active="No")
        wakyarrows.Push({text: "<", textAttrs: {Color:"#666666",font: m.app.h2}, targetRect:{x:45,y:580,w:40,h:40}})
        wakyarrows.Push({text: ">", textAttrs: {Color:"#666666",font: m.app.h2}, targetRect:{x:860,y:580,w:40,h:40}})
    else
        wakyarrows.Push({text: "<", textAttrs: {Color:"#ffff55",font: m.app.h2}, targetRect:{x:45,y:580,w:40,h:40}})
        wakyarrows.Push({text: ">", textAttrs: {Color:"#ffff55",font: m.app.h2}, targetRect:{x:860,y:580,w:40,h:40}})
    endif
    m.canvas.setlayer(111, wakyarrows)
End Function

Function paint_bedtime_timer(active="Yes") as void

    if (active="Active")
        sleepText = {text: "Time before sleep: ", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:910,y:220,w:300,h:50}}
        sleepTextSelector = {text: "<   "+m.tbs.toStr()+"   > minutes", textAttrs: {Color:"#FFFF55",font: m.app.h4}, targetRect:{x:900,y:250,w:300,h:50}}
    else if (active="Yes")
        sleepText = {text: "Time before sleep: ", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:910,y:220,w:300,h:50}}
        sleepTextSelector = {text: "<   "+m.tbs.toStr()+"   > minutes", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:900,y:250,w:300,h:50}}
    else if (active="No")
        sleepText = {text: "Time before sleep: ", textAttrs: {Color: "#666666",font: m.app.h4}, targetRect:{x:910,y:220,w:300,h:50}}
        sleepTextSelector = {text: "<   "+m.tbs.toStr()+"   > minutes", textAttrs: {Color:"#666666",font: m.app.h4}, targetRect:{x:900,y:250,w:300,h:50}}
    endif
    m.canvas.setlayer(53,sleepText)
    m.canvas.setlayer(54,sleepTextSelector)

End Function


Function paint_bedtime_sound(active="Yes") as void

    'sleepSoundTextTitle = {url:"pkg:/images/rect.png",targetRect:{w:350,h:30,x:40,y:330}}
    if (active="No")
        sleepSound = {text: "Choose sound for sleeping while the TV screen is dark.", textAttrs: {HAlign:"Center",Color: "#666666",font: m.app.hnova}, targetRect:{x:515,y:230,w:245,h:50}}
        'sleepSoundSelector = {text: "< "+m.sleepsound[m.sss]+" >", textAttrs: {Color: "#666666",font: m.app.h4}, targetRect:{x:60,y:360,w:200,h:50}}
    else if (active="Yes")
        sleepSound = {text: "Choose sound for sleeping while the TV screen is dark.", textAttrs: {HAlign:"Center",Color: "#FFFFFF",font: m.app.hnova}, targetRect:{x:515,y:230,w:245,h:50}}
        'sleepSoundSelector = {text: "< "+m.sleepsound[m.sss]+" >", textAttrs: {Color: "#FFFFFF",font: m.app.h4}, targetRect:{x:60,y:360,w:200,h:50}}
    else if (active="Active")
        sleepSound = {text: "Choose sound for sleeping while the TV screen is dark.", textAttrs: {HAlign:"Center",Color: "#FFFF55",font: m.app.hnova}, targetRect:{x:515,y:230,w:245,h:50}}
        'sleepSoundSelector = {text: "< "+m.sleepsound[m.sss]+" >", textAttrs: {Color: "#FFFF55",font: m.app.h4}, targetRect:{x:60,y:360,w:200,h:50}}
    endif
    m.canvas.setlayer(53,sleepSound)
    'm.canvas.setlayer(56,sleepSoundSelector)
    'm.canvas.setlayer(131, sleepSoundTextTitle)

End Function

Function paint_bedtime_sound_thumb() as void
    sleepSoundT = []

    sleepSoundT.push({url: m.selectedAlarmSoundIndex.thumbnail, targetRect: {x:510, y: 185, w:256, h:130}}) '176x98
    'sleepSoundT.push({text: m.selectedAlarmSoundIndex.name, textAttrs: {HAlign:"Center",Color: "#fe7902",font: m.app.h4}, targetRect:{x:510,y:320,w:300,h:50}})
    if (m.audioTimerIndex<>2)
        sleepSoundT.push({text: "Sound plays over darkened screen", textAttrs: {HAlign:"Center",Color: "#FFFFFF",font: m.app.h4}, targetRect:{x:390,y:305,w:500,h:50}})
    endif
    if (m.audioTimerIndex=0)
        when = " All Night."
    else if (m.audioTimerIndex=2)
        when = "No Sound."
    else if (m.audioTimerIndex=1)
        when = "for the first "+m.sleepTimeDuration.toStr()+" minutes."
    endif
    sleepSoundT.push({text: when, textAttrs: {HAlign:"Center",Color: "#fe7902",font: m.app.h4}, targetRect:{x:480,y:330,w:300,h:50}})

    m.canvas.setlayer(53,sleepSoundT)
End Function


Function paint_bedtime_selector(level, active=false, thumbselector = false) as void
    url_rings=[]
    url_rings_active=[]
    pos_rings=[]
    url_rings.push("pkg:/images/ring_level_1_selected.png")
    url_rings.push("pkg:/images/ring_level_2.png")
    url_rings.push("pkg:/images/ring_level_2.png")
    url_rings.push("pkg:/images/ring_level_2.png")

    url_rings_active.push("pkg:/images/ring_level_1_active.png")
    url_rings_active.push("pkg:/images/ring_level_1_active.png")
    url_rings_active.push("pkg:/images/ring_level_1_active.png")
    url_rings_active.push("pkg:/images/ring_level_1_active.png")
    'pos_rings.push({x:40,y:115,w:280,h:160})
    'pos_rings.push({x:40,y:280,w:225,h:130})
    pos_rings.push({x:95,y:486,w:186,h:105})
    pos_rings.push({x:95,y:456,w:186,h:105})
    pos_rings.push({x:95,y:456,w:186,h:105})
    pos_rings.push({x:95,y:531,w:186,h:105})

    if (thumbselector=true)
        pos_rings=[]
        pos_rings.push({x:95,y:456,w:186,h:105})
        pos_rings.push({x:95,y:456,w:186,h:105})
        pos_rings.push({x:95,y:456,w:186,h:105})
    endif

    if (active)
        ring={
            url:url_rings_active[level],
            targetRect:pos_rings[level]
        }
    else
        ring={
            url:url_rings[level],
            targetRect:pos_rings[level]
        }
    endif

    m.canvas.setLayer(57,ring)
End Function


Function paint_wakeup_text(active="Yes") as void
    'wakeupTextTitle = {url:"pkg:/images/rect.png",targetRect:{w:470,h:30,x:40,y:415}}
    if (active="No")
        wakeupText = {text: "Choose if you want a video or alarm sound to wake up with.", textAttrs: {HAlign:"Center",Color:"#666666",font: m.app.hnova}, targetRect:{x:925,y:230,w:245,h:50}}
    else if (active="Yes")
        wakeupText = {text: "Choose if you want a video or alarm sound to wake up with.", textAttrs: {HAlign:"Center",Color:"#FFFFFF",font: m.app.hnova}, targetRect:{x:925,y:230,w:245,h:50}}
    else if (active="Active")
        wakeupText = {text: "Choose if you want a video or alarm sound to wake up with.", textAttrs: {HAlign:"Center",Color:"#FFFF55",font: m.app.hnova}, targetRect:{x:925,y:230,w:245,h:50}}
    endif
    m.canvas.setLayer(54, wakeupText)
    'm.canvas.setLayer(59, wakeupTextTitle)
end function


Function paint_wakeup_timer(active="No") as void
    if (active="No")
        wakeupText = {text: "Wake Up Time: ", textAttrs: {Color:"#666666",font: m.app.h4}, targetRect:{x:890,y:480,w:300,h:50}}
        wakeupTextSelector = {text: "< "+m.wakeuptime[0]+" : "+m.wakeuptime[1]+" "+m.wakeuptime[2]+" >", textAttrs: {Color:"#666666",font: m.app.h4}, targetRect:{x:890,y:510,w:300,h:50}}
    else if (active="Yes")
        wakeupText = {text: "Wake Up Time: ", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:890,y:480,w:300,h:50}}
        wakeupTextSelector = {text: "< "+m.wakeuptime[0]+" : "+m.wakeuptime[1]+" "+m.wakeuptime[2]+" >", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:890,y:510,w:300,h:50}}
    else if (active="Active")
        wakeupText = {text: "Wake Up Time: ", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:890,y:480,w:300,h:50}}
        wakeupTextSelector = {text: "< "+m.wakeuptime[0]+" : "+m.wakeuptime[1]+" "+m.wakeuptime[2]+" >", textAttrs: {Color:"#FFFF55",font: m.app.h4}, targetRect:{x:890,y:510,w:300,h:50}}
    endif
    m.canvas.setlayer(63, wakeupText)
    m.canvas.setlayer(64, wakeupTextSelector)

End Function


Function paint_wakeup_alarm(active="Yes") as void

    'wakeupTextTitle = {url:"pkg:/images/rect.png",targetRect:{w:280,h:30,x:40,y:580}}
    if (active="No")
        wakeupAlarm = {text: "Choose your wake-up video.", textAttrs: {HAlign:"Left",Color:"#666666",font: m.app.h3}, targetRect:{x:970,y:220,w:250,h:50}}
        'wakeupAlarmSelector = {text: "< "+m.alarmchime[m.ac]+" >", textAttrs: {Color:"#666666",font: m.app.h4}, targetRect:{x:60,y:615,w:200,h:50}}
        'wakeupAlarmSelectorWhen = {text: "< "+m.alarmchimewhen[m.acw]+" >", textAttrs: {Color:"#666666",font: m.app.h4}, targetRect:{x:200,y:615,w:300,h:50}}
    else if (active="Yes")
        wakeupAlarm = {text: "Choose your wake-up video.", textAttrs: {HAlign:"Left",Color:"#FFFFFF",font: m.app.h3}, targetRect:{x:970,y:220,w:250,h:50}}
        'wakeupAlarmSelector = {text: "< "+m.alarmchime[m.ac]+" >", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:60,y:615,w:200,h:50}}
        'wakeupAlarmSelectorWhen = {text: "< "+m.alarmchimewhen[m.acw]+" >", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:200,y:615,w:300,h:50}}
    else if (active="Active1")
        wakeupAlarm = {text: "Choose your wake-up video.", textAttrs: {HAlign:"Left",Color:"#FFFFFF",font: m.app.h3}, targetRect:{x:970,y:220,w:250,h:50}}
        'wakeupAlarmSelector = {text: "< "+m.alarmchime[m.ac]+" >", textAttrs: {Color:"#FFFF55",font: m.app.h4}, targetRect:{x:60,y:615,w:200,h:50}}
        'wakeupAlarmSelectorWhen = {text: "< "+m.alarmchimewhen[m.acw]+" >", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:200,y:615,w:300,h:50}}
    else if (active="Active2")
        wakeupAlarm = {text: "Choose your wake-up video.", textAttrs: {HAlign:"Left",Color:"#FFFFFF",font: m.app.h3}, targetRect:{x:970,y:220,w:250,h:50}}
       ' wakeupAlarmSelector = {text: "< "+m.alarmchime[m.ac]+" >", textAttrs: {Color:"#FFFFFF",font: m.app.h4}, targetRect:{x:60,y:615,w:200,h:50}}
       ' wakeupAlarmSelectorWhen = {text: "< "+m.alarmchimewhen[m.acw]+" >", textAttrs: {Color:"#FFFF55",font: m.app.h4}, targetRect:{x:200,y:615,w:300,h:50}}
    endif
    m.canvas.setlayer(55,wakeupAlarm)
    'm.canvas.setlayer(66,wakeupAlarmSelector)
    'm.canvas.setlayer(67,wakeupAlarmSelectorWhen)
    'm.canvas.setlayer(82,wakeupTextTitle)

End Function


Function paint_static2() as void
    staticStuff=[]
    if (IsHD())
        logo={
            url:"pkg:/images/logo.png",
            TargetRect:{x:40,y:20,w:283,h:85}
        }
        bgmenu = {url:"pkg:/images/bgmenunew.png", TargetRect:{x:0,y:0,w:1280,h:120}}
        shapebehindboxessleep =  {url:"pkg:/images/shapebehindboxessleep.png", TargetRect:{x:60,y:120,w:1148,h:265}}
        newShadow1 = {url:"pkg:/images/nextsmallarrow.png",targetRect:{w:36,h:36,x:420,y:230}}
        newShadow2 = {url:"pkg:/images/nextsmallarrow.png",targetRect:{w:36,h:36,x:830,y:230}}
        exploremenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        sleepmenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
        'normalmenu = {text: "Simple", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:420,y:100,w:200,h:50}}
        'advancedmenu = {text: "Advanced", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:620,y:100,w:200,h:50}}
    else
        logo={
            url:"pkg:/images/logo.png",
            TargetRect:{x:40,y:20,w:283,h:85}
        }
        bgmenu = {url:"pkg:/images/bgmenunew.png", TargetRect:{x:0,y:0,w:1280,h:120}}
        shapebehindboxessleep =  {url:"pkg:/images/shapebehindboxessleep.png", TargetRect:{x:60,y:120,w:1148,h:265}}
        newShadow1 = {url:"pkg:/images/nextsmallarrow.png",targetRect:{w:36,h:36,x:420,y:230}}
        newShadow2 = {url:"pkg:/images/nextsmallarrow.png",targetRect:{w:36,h:36,x:830,y:230}}
        exploremenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        sleepmenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
        'normalmenu = {text: "Simple", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:420,y:100,w:200,h:50}}
        'advancedmenu = {text: "Advanced", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:620,y:100,w:200,h:50}}
    endif
    '#9da2a6
    'm.canvas.clearlayer(201)
    m.canvas.setLayer(178, bgmenu)

    'staticStuff.push(logo)
    staticStuff.push(exploremenu)
    staticStuff.push(sleepmenu)
    staticStuff.push(setupmenu)
    'staticStuff.push(normalmenu)
    'staticStuff.push(advancedmenu)
    m.canvas.setLayer(179, staticStuff)
    m.canvas.setLayer(180, logo)
    m.canvas.setLayer(33, shapebehindboxessleep)
    m.canvas.setLayer(34, newshadow1)
    m.canvas.setLayer(35, newshadow2)
    m.paintTopMenuSelector(1)
End Function




''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' paints the selector for the top menu
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function paint_top_menu_selector2(topindex=0) as void

    pos_rings=[]
    staticStuff=[]
    pos_rings.push({x:425,y:90,w:180,h:2})
    pos_rings.push({x:625,y:90,w:180,h:2})
    pos_rings.push({x:825,y:90,w:180,h:2})

    if (m.inTopMenu)
        ring={
            url:"pkg:/images/ring_play_100.png",
            targetRect:pos_rings[topindex]
        }
    endif
    if (topindex=0)
        sleepmenu = {text: "Relax", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        exploremenu = {text: "Sleep", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
    else if (topindex=1)
        sleepmenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        exploremenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
    else if (topindex=2)
        exploremenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        setupmenu = {text: "Sleep", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
    endif

    if (m.inTopMenu) m.canvas.setLayer(181,ring)

    staticStuff.push(exploremenu)
    staticStuff.push(sleepmenu)
    staticStuff.push(setupmenu)

    m.canvas.setLayer(179, staticStuff)
End Function


Function paint_below_items_selector(topindex=0, active=false) as void

    pos_rings=[]
    staticStuff=[]
    pos_rings.push({x:985,y:512,w:150,h:2})
    pos_rings.push({x:960,y:545,w:200,h:2})
    pos_rings.push({x:985,y:630,w:150,h:2})
    pos_rings.push({x:445,y:410,w:80,h:2})
    pos_rings.push({x:510,y:460,w:150,h:2})
    pos_rings.push({x:990,y:410,w:220,h:2})
    pos_rings.push({x:1005,y:460,w:220,h:2})
    pos_rings.push({x:990,y:560,w:160,h:2})

    if (active)
        ring={
            url:"pkg:/images/ring_play_100.png",
            targetRect:pos_rings[topindex]
        }
    else
        ring={
            url:"pkg:/images/bgmenuitemhover.png",
            targetRect:pos_rings[topindex]
        }
    endif

    m.canvas.setLayer(90,ring)

End Function


Function paint_subtop_menu_selector2(topindex=0) as void

    pos_rings=[]
    staticStuff=[]
    'pos_rings.push({x:45,y:160,w:130,h:2})
    'pos_rings.push({x:250,y:160,w:138,h:2})
    pos_rings.push({x:455,y:140,w:130,h:2})
    pos_rings.push({x:655,y:140,w:130,h:2})
    'pos_rings.push({x:700,y:160,w:170,h:2})
    'pos_rings.push({x:940,y:160,w:70,h:2})
    'pos_rings.push({x:1080,y:160,w:160,h:2})

    if (m.inSubTopMenu)
        ring={
            url:"pkg:/images/ring_play_100.png",
            targetRect:pos_rings[topindex]
        }
        exploremenu = {text: "Sleep", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        sleepmenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
        normalmenu = {text: "Simple", textAttrs: {Color: "#666666", font: m.app.h3}, targetRect:{x:420,y:100,w:200,h:50}}
        advancedmenu = {text: "Advanced", textAttrs: {Color: "#666666", font: m.app.h3}, targetRect:{x:620,y:100,w:200,h:50}}
        if (topindex=0)
            normalmenu = {text: "Simple", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:420,y:100,w:200,h:50}}
        else if (topindex=1)
            advancedmenu = {text: "Advanced", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:620,y:100,w:200,h:50}}
        endif
    else
        ring={
            url:"pkg:/images/bgmenuitemhover.png",
            targetRect:pos_rings[topindex]
        }
     endif
        m.canvas.setLayer(42,ring)

        staticStuff.push(exploremenu)
        staticStuff.push(sleepmenu)
        staticStuff.push(setupmenu)
        staticStuff.push(normalmenu)
        staticStuff.push(advancedmenu)
        m.canvas.setLayer(131, staticStuff)


End Function

Function paint_question_1(active = "No") as void
    question1Text = []
    if (active  = "Yes")
        question1Text.push({text:"Do you want to be awakened?", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:75,y:380,w:400,h:40}})
        question1Text.push({text:"< "+m.alarmAnswer1+" >", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:385,y:380,w:200,h:40}})
    else if (active="No")
        question1Text.push({text:"Do you want to be awakened?", textAttrs: {Color: "#666666", font: m.app.h3}, targetRect: {x:75,y:380,w:400,h:40}})
        question1Text.push({text:"< "+m.alarmAnswer1+" >", textAttrs: {Color: "#fe7902", font: m.app.h3}, targetRect: {x:385,y:380,w:200,h:40}})
    else if (active="Active")
        question1Text.push({text:"Do you want to be awakened?", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:75,y:380,w:400,h:40}})
        question1Text.push({text:"< "+m.alarmAnswer1+" >", textAttrs: {Color: "#FFFF55", font: m.app.h3}, targetRect: {x:385,y:380,w:200,h:40}})
    endif

    m.canvas.setLayer(231, question1Text)

End function

Function paint_question_2(active="No") as void

    question2Text = []

    if (m.wakeuptime[0].toInt()>11 AND m.wakeuptime[0].toInt()<24)
      hr = m.wakeuptime[0].toInt() - 12
      if (hr=0) hr = 12
    else
      hr = m.wakeuptime[0].toInt()
    endif
    if (hr=24) hr = 0
    if (active  = "Yes")
        question2Text.push({text:"What time do you want to wake up?", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:105,y:430,w:400,h:40}})
        question2Text.push({text: "< "+hr.toStr()+" : "+m.wakeuptime[1]+" "+m.wakeuptime[2]+" >", textAttrs: {Color:"#FFFFFF",font: m.app.h3}, targetRect:{x:440,y:430,w:300,h:40}})
    else if (active="No")
        question2Text.push({text:"What time do you want to wake up?", textAttrs: {Color: "#666666", font: m.app.h3}, targetRect: {x:105,y:430,w:400,h:40}})
        question2Text.push({text: "< "+hr.toStr()+" : "+m.wakeuptime[1]+" "+m.wakeuptime[2]+" >", textAttrs: {Color:"#fe7902",font: m.app.h3}, targetRect:{x:440,y:430,w:300,h:40}})
    else if (active="Active")
        question2Text.push({text:"What time do you want to wake up?", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:105,y:430,w:400,h:40}})
        question2Text.push({text: "< "+hr.toStr()+" : "+m.wakeuptime[1]+" "+m.wakeuptime[2]+" >", textAttrs: {Color:"#FFFF55",font: m.app.h3}, targetRect:{x:440,y:430,w:300,h:40}})
    endif

    m.canvas.setLayer(232, question2Text)

End Function

Function paint_question_3(active="No") as void

    question3Text = []

    if (active="Yes")
        question3Text.push({text:"Do you want an alarm sound?", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:600,y:380,w:400,h:40}})
        question3Text.push({text:"< "+m.alarmchimewhen[m.acw]+" >", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:900,y:380,w:400,h:40}})
    else if (active="No")
        question3Text.push({text:"Do you want an alarm sound?", textAttrs: {Color: "#666666", font: m.app.h3}, targetRect: {x:600,y:380,w:400,h:40}})
        question3Text.push({text:"< "+m.alarmchimewhen[m.acw]+" >", textAttrs: {Color: "#fe7902", font: m.app.h3}, targetRect: {x:900,y:380,w:400,h:40}})
    else if (active="Active")
        question3Text.push({text:"Do you want an alarm sound?", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:600,y:380,w:400,h:40}})
        question3Text.push({text:"< "+m.alarmchimewhen[m.acw]+" >", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:900,y:380,w:400,h:40}})
    endif

    m.canvas.setLayer(233, question3Text)
End Function

Function paint_question_4(active="No") as void

    question4Text = []
    if (active="Yes")
        question4Text.push({text:"What sound do you want?", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:650,y:430,w:400,h:40}})
        question4Text.push({text:"< "+m.alarmchime[m.ac]+" >", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:915,y:430,w:400,h:40}})
    else if (active="No")
        question4Text.push({text:"What sound do you want?", textAttrs: {Color: "#666666", font: m.app.h3}, targetRect: {x:650,y:430,w:400,h:40}})
        question4Text.push({text:"< "+m.alarmchime[m.ac]+" >", textAttrs: {Color: "#fe7902", font: m.app.h3}, targetRect: {x:915,y:430,w:400,h:40}})
    else if (active="Active")
        question4Text.push({text:"What sound do you want?", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:650,y:430,w:400,h:40}})
        question4Text.push({text:"< "+m.alarmchime[m.ac]+" >", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect: {x:915,y:430,w:400,h:40}})
    endif

    m.canvas.setLayer(234, question4Text)
End Function

Function paint_stop_video_after(active="No") as void

    stoptext = []

    if (active="No")
        stoptext.push({text: "Stop video after:", textAttrs: {Color:"#666666",font: m.app.h3}, targetRect:{x:870,y:490,w:400,h:40}})
        stoptext.push({text: "< "+m.wakeupvideoduration.toStr()+" min >", textAttrs: {Color:"#FE7902",font: m.app.h3}, targetRect:{x:870,y:530,w:400,h:40}})
    else if (active="Yes")
        stoptext.push({text: "Stop video after:", textAttrs: {Color:"#FFFFFF",font: m.app.h3}, targetRect:{x:870,y:490,w:400,h:40}})
        stoptext.push({text: "< "+m.wakeupvideoduration.toStr()+" min >", textAttrs: {Color:"#FFFFFF",font: m.app.h3}, targetRect:{x:870,y:530,w:400,h:40}})
    else if (active="Active")
        stoptext.push({text: "Stop video after:", textAttrs: {Color:"#FFFFFF",font: m.app.h3}, targetRect:{x:870,y:490,w:400,h:40}})
        stoptext.push({text: "< "+m.wakeupvideoduration.toStr()+" min >", textAttrs: {Color:"#FFFF55",font: m.app.h3}, targetRect:{x:870,y:530,w:400,h:40}})
    endif

    m.canvas.setLayer(235, stoptext)

End Function


Function show_subsection_options() as void
    '#nopaintingonmovement
    m.clearSleepStartMessage()
    m.clearSleepMarketing()
    if (m.menuSelectorIndex=0)
        m.clearSubSectionOptions()
        m.paintsleeparrowdown(0)
        m.paintBedTimeThumby(false, false)
        m.paintSleepyBG()
        m.paintBedTimeSelector(0)
        m.paintSleepTimeDuration("No")
        m.paintSaveButton1("No")
    else if (m.menuSelectorIndex=1)
        m.clearSubSectionOptions()
        m.paintsleeparrowdown(1)
        'm.paintSleepyBG()
        m.paintWakeUpBG()
        m.paintDarkScreenSoundsThumby(false,false)
        m.paintAudioPlayTime("No")
        m.paintSaveButton2("No")
        m.paintBedTimeArrows("No")
        m.paintBedTimeSelector(0, false)
        m.inDarkScreenAudioSelect = false
        m.inAudioTimerChoice = false
    else if (m.menuSelectorIndex=2)
        m.clearSubSectionOptions()
        m.paintsleeparrowdown(2)
        m.paintQuestion1("No")
        if (m.alarmAnswer1="Yes")
            m.paintQuestion2("No")
            m.paintQuestion3("No")
            m.paintQuestion4("No")
            m.paintWakeUpThumby(false, "No")
            m.paintAlarmBG()
            'm.paintBedTimeSelector(0, false)
            m.paintStopVideoAfter("No")
            m.paintSaveButton3("No")
        endif
    endif

    if (m.menuSelectorIndex=0)
        m.inBedTimeSelector=true
        m.paintBedTimeThumby(true, true)
        m.paintBedTimeArrows("Active")
        m.clearSleepyBG()
        m.paintBedTimeSelector(0, true)
    else if (m.menuSelectorIndex=1)
        m.paintBedTimeArrows("Active")
        m.clearSleepyBG()
        m.paintDarkScreenSoundsThumby(false,true)
        m.paintBedTimeSelector(0, true)
        m.inDarkScreenAudioSelect = true
        m.inPreviewSound = false
        m.previewsoundtext(false)
    else if (m.menuSelectorIndex=2)
        m.paintQuestion1("Active")
        m.paintBelowItemsSelector(3, true)
        m.inAlarmQuestion1 = true
    endif

end function

function clear_subsection_options() as void

    if (m.menuSelectorIndex=0 OR m.menuSelectorIndex=2)
        m.canvas.clearlayer(110)
        m.canvas.clearlayer(222)
        m.canvas.clearlayer(120)
        m.canvas.clearlayer(131)
        m.canvas.clearlayer(122)
        m.canvas.clearlayer(111)
        m.canvas.clearlayer(400)
        m.canvas.clearlayer(401)
        m.canvas.clearlayer(190)
        m.canvas.clearlayer(85)
        m.canvas.clearlayer(86)
        m.canvas.clearlayer(57)
        m.canvas.clearLayer(281)
    else if (m.menuSelectorIndex=1)
        m.canvas.clearlayer(71)
        m.canvas.clearlayer(222)
        m.canvas.clearlayer(72)
        m.canvas.clearlayer(84)
        m.canvas.clearlayer(83)
        m.canvas.clearlayer(85)
        m.canvas.clearlayer(86)
        m.canvas.clearlayer(85)
        '
        m.canvas.clearlayer(231)
        m.canvas.clearlayer(232)
        m.canvas.clearlayer(233)
        m.canvas.clearlayer(234)
        m.canvas.clearlayer(235)
        m.canvas.clearlayer(247)
        m.canvas.clearlayer(60)
        m.canvas.clearlayer(85)
        m.canvas.clearlayer(86)
        m.canvas.clearlayer(90)
    endif

end function


Function b_move_left() as void
    if (m.sleepyData.count()>1)
        sleepyTemp = []
        j = 0
        lastElement = m.sleepyData[m.sleepyData.count()-1]
        for i=0 to (m.sleepyData.count()-1)
            j = i
            if (m.sleepyData[j-1]<>invalid) then
                sleepyTemp[i] = m.sleepyData[j-1]
            else
                sleepyTemp[i] = lastElement
            end if
        end for
        m.sleepyData = sleepyTemp
        m.selectedBedVideoIndex = m.sleepyData[0]
        m.app.bIndex = j
        m.paintBedTimeThumby(true, true)
        m.paintSleepTimeDuration("No", true)
    end if
End Function

Function b_move_right() as void
    if (m.sleepyData.count()>1)
        sleepyTemp = []
        j = 0
        firstElement = m.sleepyData[0]
        for i=0 to (m.sleepyData.count()-1)
            j=i
            if (m.sleepyData[j+1]<>invalid) then
                sleepyTemp[i] = m.sleepyData[j+1]
            else
                sleepyTemp[i] = firstElement
            end if
        end for
        m.sleepyData = sleepyTemp
        m.selectedBedVideoIndex = m.sleepyData[0]
        '
        m.app.bIndex = j
        m.paintBedTimeThumby(true, true)
        m.paintSleepTimeDuration("No", true)
    end if
End Function

Function w_move_left() as void
    if (m.wakeupData.count()>1)
        wakeupTemp = []
        j = 0
        lastElement = m.wakeupData[m.wakeupData.count()-1]
        for i=0 to (m.wakeupData.count()-1)
            j=i
            if (m.wakeupData[j-1]<>invalid) then
                wakeupTemp[i] = m.wakeupData[j-1]
            else
                wakeupTemp[i] = lastElement
            end if
        end for
        m.wakeupData = wakeupTemp
        m.selectedWakeUpVideoIndex = m.wakeupData[0]
        'print m.selectedWakeUpVideoIndex
        m.app.wIndex = j
        m.paintWakeUpThumby(true)
    end if
End Function

Function w_move_right() as void
    if (m.wakeupData.count()>1)
        wakeupTemp = []
        j = 0
        firstElement = m.wakeupData[0]
        for i=0 to (m.wakeupData.count()-1)
            j=i
            if (m.wakeupData[j+1]<>invalid) then
                wakeupTemp[i] = m.wakeupData[j+1]
            else
                wakeupTemp[i] = firstElement
            end if
        end for
        m.wakeupData = wakeupTemp
        m.selectedWakeUpVideoIndex = m.wakeupData[0]
        'print m.selectedWakeUpVideoIndex
        m.app.wIndex = j
        m.paintWakeUpThumby(true)
    end if
End Function

Function d_move_left() as void
    'm.darkScreenSoundData
    if (m.darkScreenSoundData.count()>1)
        wakeupTemp = []
        j = 0
        lastElement = m.darkScreenSoundData[m.darkScreenSoundData.count()-1]
        for i=0 to (m.darkScreenSoundData.count()-1)
            j=i
            if (m.darkScreenSoundData[j-1]<>invalid) then
                wakeupTemp[i] = m.darkScreenSoundData[j-1]
            else
                wakeupTemp[i] = lastElement
            end if
        end for
        m.darkScreenSoundData = wakeupTemp
        m.selectedAlarmSoundIndex = m.darkScreenSoundData[0]
        if (m.darkscreenselectedindex>0)
            m.darkscreenselectedindex = m.darkscreenselectedindex - 1
        else
            m.darkscreenselectedindex=m.darkScreenSoundData.count()
        endif
        m.app.sIndex = m.darkscreenselectedindex
        if (m.selectedAlarmSoundIndex.filename<>"No Sound")
            m.app.audio.stop()
            m.inPreviewSound = false
            m.previewsoundtext(false, true)
            'DownloadFile("http://ahhveo.com/_dev/sounds/previews/"+m.selectedAlarmSoundIndex.preview,"sleep.mp3")
            'play sound'm.app.audio.play("http://ahhveo.com/_dev/sounds/previews/"+m.selectedAlarmSoundIndex.preview,"sleep.mp3")
        endif
        m.paintDarkScreenSoundsThumby(true, true)
    end if
End Function

Function d_move_right() as void
    'm.darkScreenSoundData
    if (m.darkScreenSoundData.count()>1)
        wakeupTemp = []
        j = 0
        firstElement = m.darkScreenSoundData[0]
        for i=0 to (m.darkScreenSoundData.count()-1)
            j=i
            if (m.darkScreenSoundData[j+1]<>invalid) then
                wakeupTemp[i] = m.darkScreenSoundData[j+1]
            else
                wakeupTemp[i] = firstElement
            end if
        end for
        m.darkScreenSoundData = wakeupTemp
        m.selectedAlarmSoundIndex = m.darkScreenSoundData[0]
        if (m.darkscreenselectedindex<m.darkScreenSoundData.count())
            m.darkscreenselectedindex = m.darkscreenselectedindex + 1
        else
            m.darkscreenselectedindex=0
        endif
        m.app.sIndex = m.darkscreenselectedindex
        if (m.selectedAlarmSoundIndex.filename<>"No Sound")
            m.app.audio.stop()
            m.inPreviewSound=false
            m.previewsoundtext(false, true)
        endif
        m.paintDarkScreenSoundsThumby(true, true)
    end if
End Function

function sleep_remote_callback(index) as void
    if (m.app.sleeping)
        m.app.audio.stop()
         m.app.hideScreenSaver()
         m.app.sleeping=false
     endif
    if (index=2) then ' up
        if (m.inStartYourSleepButton OR m.inResetSleepButton)
            m.inTopMenu = true
            m.paintTopMenuSelector(1)
            m.startYourSleepButton(false)
            m.resetButton(false)
            m.inStartYourSleepButton = false
            m.sleepStartMessage()
            'm.clearSleepMarketing()
        else if (m.inMainSelector)
            if (m.updatedFlag AND m.inStep=3)
                m.inStartYourSleepButton = true
                m.startYourSleepButton(true)
            else
                m.inTopMenu = true
                m.paintTopMenuSelector(1)
                'm.startYourSleepButton(false)
                m.sleepStartMessage()
                'm.clearSleepMarketing()
            endif
            m.clearMainSelector()
            m.inMainSelector=false
            m.menuSelectorIndex = 0
        else if (m.inBedTimeSelector)
            'm.inMainSelector=true
            'm.inBedTimeSelector=false
            'm.paintTopMenuSelector(0)
            'if (m.isThumb1=true OR m.isThumb2=true OR m.isThumb3=true)
            '    m.mainSelector(0, true)
            'else
            '    m.mainSelector(0)
            'endif
            ''m.showSubSectionOptions()
            'm.paintBedTimeThumby(true, false)
            'm.paintBedTimeArrows("No")
            'm.paintSleepyBG()
            'm.paintBedTimeSelector(0)
            'm.clearSleepStartMessage()
         else if (m.inAudioTimerChoice)
            if (m.audioTimerIndex>0)
                m.audioTimerIndex = m.audioTimerIndex - 1
                m.paintBelowItemsSelector(m.audioTimerIndex, true)
            endif
        else if (m.inDarkScreenAudioSelect OR m.inWakeUpCarousel OR m.inAlarmQuestion1)
            '' anywhere else
            'm.inMainSelector=true
            'm.showSubSectionOptions()
            '' false others bleow
            'm.inWakeUpCarousel=false
            'm.inAlarmQuestion1=false
            'm.inDarkScreenAudioSelect=false
        endif
    else if (index=3) then 'down
        if (m.inTopMenu)
            m.inTopMenu = false
            'm.clearSleepMarketing()
            m.sleepStartMessage(true)
            if (m.updatedFlag)
                m.startYourSleepButton(true)
                m.inStartYourSleepButton = true
                m.paintTopMenuSelector(1)
            else
                m.inStep=1
                m.paintTopMenuSelector(1)
                if (m.isThumb1=true OR m.isThumb2=true OR m.isThumb3=true)
                    m.mainSelector(0, true)
                else
                    m.mainSelector(0)
                endif
                m.inStartYourSleepButton = false
                m.inResetSleepButton = false
                'm.startYourSleepButton(false)
                m.inMainSelector=true
                'm.clearSleepStartMessage()
            endif
            m.clearTop()
        else if (m.inStartYourSleepButton OR m.inResetSleepButton)
            'm.paintTopMenuSelector(1)
            if (m.isThumb1=true OR m.isThumb2=true OR m.isThumb3=true)
                m.mainSelector(0, true)
            else
                m.mainSelector(0)
            endif
            m.inStartYourSleepButton = false
            m.inResetSleepButton = false
            m.startYourSleepButton(false)
            m.resetButton(false)
            m.inMainSelector=true
            '#m.sleepStartMessage(true)
            '#nopaintingonmovement
            'm.paintBedTimeThumby(false, false)
            'm.paintSleepyBG()
            'm.paintSleepTimeDuration("No")
            'm.paintSaveButton1("No")
            '#m.clearSleepStartMessage()
        else if (m.inMainSelector)
            'm.inMainSelector=false

            ' depends on main selector index
            'if (m.menuSelectorIndex=0)
            '    m.inBedTimeSelector=true
            '    m.paintBedTimeThumby(true, true)
            '    m.paintBedTimeArrows("Active")
            '    m.clearSleepyBG()
            '    m.paintBedTimeSelector(0, true)
            'else if (m.menuSelectorIndex=1)
            '    m.paintBedTimeArrows("Active")
            '    m.clearSleepyBG()
            '    m.paintDarkScreenSoundsThumby(false,true)
            '    m.paintBedTimeSelector(0, true)
            '    m.inDarkScreenAudioSelect = true
            'else if (m.menuSelectorIndex=2)
            '    m.paintQuestion1("Active")
            '    m.paintBelowItemsSelector(3, true)
            '    m.inAlarmQuestion1 = true
            'endif
        else if (m.inAudioTimerChoice)
            if (m.audioTimerIndex<1)
                m.audioTimerIndex = m.audioTimerIndex + 1
                if (m.audioTimerIndex=1)
                    m.inAudioTimerSubChoice = true
                endif
            else
                m.inAudioTimerSubChoice = true
            endif
            m.paintBelowItemsSelector(m.audioTimerIndex, true)
        end if
    else if (index=4) then ' left
        if (m.inTopMenu)
            if (m.topMenuIndex>0)
                m.topMenuIndex = m.topMenuIndex - 1
            endif
            m.paintTopMenuSelector(m.topMenuIndex)
            if (m.topMenuIndex=0)
                m.clearAll()
                m.app.loggedflag = true
                sm=sectionManager(m.app)
                sm.show(places_section)
            endif
        else if (m.inMainSelector)
                if (m.menuSelectorIndex>0 AND ((m.inStep=2 AND m.updatedFlag=true) OR (m.inStep=3 AND m.updatedFlag=true) OR (m.inStep=1 AND m.updatedFlag=true)))
                    m.menuSelectorIndex = m.menuSelectorIndex - 1
                    m.mainSelector(m.menuSelectorIndex)
                    if (m.isThumb1=true OR m.isThumb2=true OR m.isThumb3=true)
                        m.mainSelector(m.menuSelectorIndex, true)
                    else
                        m.mainSelector(m.menuSelectorIndex)
                    endif
                    'm.showSubSectionOptions()
                endif
        else if (m.inResetSleepButton)
            m.inResetSleepButton = false
            m.inStartYourSleepButton = true
            'paint active inactive both
            m.startYourSleepButton(true)
            m.resetButton(false)
        else if (m.inBedTimeSelector)
            m.bMoveLeft()
            m.paintBedTimeArrows("Active")
        else if (m.inDarkScreenSelector)

            if (m.tbs>120)
                m.tbs = m.tbs - 60
            endif
            m.paintSleepTimeDuration("Active", true, true)

        else if (m.inDarkScreenAudioSelect OR m.inPreviewSound)
            m.dMoveLeft()
            m.inDarkScreenAudioSelect = true
        else if (m.inAudioTimerSubChoice)
            if (m.sleepTimeDuration>3)
                m.sleepTimeDuration = m.sleepTimeDuration - 1
              endif
              m.paintAudioPlayTime("Special")
        else if (m.inAlarmQuestion1)
            if (m.alarmAnswer1="No")
                m.alarmAnswer1 = "Yes"
            else
                m.alarmAnswer1 = "No"
            endif
            m.paintQuestion1("Active")
        else if (m.inAlarmQuestion2)
            h=m.wakeuptime[0].toInt()
            mi=m.wakeuptime[1].toInt()
            dt=m.wakeuptime[2]
            if (mi>=0)
                if (mi=0)
                    mi = 55
                    h = h - 1
                    if (h=11 OR h=0)
                        dt = "am"
                        if (h=0) h=24
                    else if (h=-1)
                        dt = "pm"
                         h = 23
                    else if (h=23)
                        dt = "pm"
                    endif
                else
                    mi = mi - 5
                endif
            endif
            m.wakeuptime[0] = h.toStr()
            if (mi<10 AND mi>=0)
                m.wakeuptime[1] = "0"+mi.toStr()
            else
               m.wakeuptime[1] = mi.toStr()
            endif
            m.wakeuptime[2] = dt
            m.paintQuestion2("Active")
        else if (m.inAlarmQuestion3)
            if (m.acw>0)
                m.acw = m.acw - 1
            else
                m.acw = 2
            endif
            m.paintQuestion3("Active")
            
        else if (m.inAlarmQuestion4)
            if (m.ac>0)
                m.ac = m.ac - 1
            else
                m.ac = 1
            endif
            m.paintQuestion4("Active")
                            DownloadFile(m.wakeupalarms[m.ac].url,"alarm.mp3")
                m.app.audio.play(m.wakeupalarms[m.ac].url,"alarm.mp3")
            
        else if (m.inWakeUpCarousel)
            m.wMoveLeft()
            m.paintWakeUpArrows("Active")
        else if (m.inStopVideoAfter)
            if (m.wakeupvideoduration>5)
                m.wakeupvideoduration = m.wakeupvideoduration - 1
            endif
            m.paintStopVideoAfter("Active")

        endif
    else if (index=5) then ' right
        if (m.inTopMenu)
            if (m.topMenuIndex<2)
                m.topMenuIndex = m.topMenuIndex + 1
            endif
            m.paintTopMenuSelector(m.topMenuIndex)
            if (m.topMenuIndex=2)
                m.clearAll()
                m.app.loggedflag = true
                sm=sectionManager(m.app)
                sm.show(setup_section)
            endif
        else if (m.inMainSelector)
                if (m.menuSelectorIndex<2 AND ((m.inStep=2 AND m.updatedFlag=true) OR (m.inStep=3 AND m.updatedFlag=true) OR (m.inStep=1 AND m.updatedFlag=true)))
                    m.menuSelectorIndex = m.menuSelectorIndex + 1
                    if (m.isThumb1=true OR m.isThumb2=true OR m.isThumb3=true)
                        m.mainSelector(m.menuSelectorIndex, true)
                    else
                        m.mainSelector(m.menuSelectorIndex)
                    endif
                    'm.showSubSectionOptions()
                endif
        else if (m.inStartYourSleepButton)
            m.inResetSleepButton = true
            m.inStartYourSleepButton = false
            ' paint active below reset text
            m.startYourSleepButton(false)
            m.resetButton(true)
        else if (m.inBedTimeSelector)
            m.bMoveRight()
            m.paintBedTimeArrows("Active")
        else if (m.inDarkScreenSelector)
            '
            if (m.tbs<7200)
                m.tbs = m.tbs + 60
            endif
            m.paintSleepTimeDuration("Active", true, true)
        else if (m.inDarkScreenAudioSelect OR m.inPreviewSound)
            m.dMoveRight()
            m.inDarkScreenAudioSelect = true
        else if (m.inAudioTimerSubChoice)
              if (m.sleepTimeDuration<60)
                m.sleepTimeDuration = m.sleepTimeDuration + 1
              endif
              m.paintAudioPlayTime("Special")
        else if (m.inAlarmQuestion1)
            if (m.alarmAnswer1="No")
                m.alarmAnswer1 = "Yes"
            else
                m.alarmAnswer1 = "No"
            endif
            m.paintQuestion1("Active")
        else if (m.inAlarmQuestion2)
            h=m.wakeuptime[0].toInt()
            hi=h
            mi=m.wakeuptime[1].toInt()
            dt=m.wakeuptime[2]
            if (mi<60)
                mi = mi + 5
                if (mi=60)
                    mi = 0
                    h = h + 1
                    if (h=12)
                        dt = "pm"
                    else if (h=24)
                        dt = "am"
                        h = 24
                    else if (h=25)
                        h = 1
                    endif
                endif
            endif
            m.wakeuptime[0] = h.toStr()
            if (mi<10 AND mi>=0)
                m.wakeuptime[1] = "0"+mi.toStr()
            else
                m.wakeuptime[1] = mi.toStr()
            endif
            m.wakeuptime[2] = dt
            m.paintQuestion2("Active")
        else if (m.inAlarmQuestion3)
            if (m.acw<m.alarmchimewhen.count()-1)
                m.acw = m.acw + 1
            else
                m.acw = 0
            endif
            m.paintQuestion3("Active")
        else if (m.inAlarmQuestion4)
            if (m.ac<m.alarmchime.count()-1)
                m.ac = m.ac + 1
            else
                m.ac = 0
            endif
            m.paintQuestion4("Active")
                            DownloadFile(m.wakeupalarms[m.ac].url,"alarm.mp3")
                m.app.audio.play(m.wakeupalarms[m.ac].url,"alarm.mp3")
            
        else if (m.inWakeUpCarousel)
            m.wMoveRight()
            m.paintWakeUpArrows("Active")
        else if (m.inStopVideoAfter)
            if (m.wakeupvideoduration<60)
                m.wakeupvideoduration = m.wakeupvideoduration + 1
            endif
            m.paintStopVideoAfter("Active")

        endif
    else if (index=6) then
        if (m.inTopMenu)

            if (m.topMenuIndex=1)
                m.clearAll()
                sm=sectionManager(m.app)
                sm.show(places_section)
                m.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
            else if (m.topMenuIndex=2)
                m.clearAll()
                sm=sectionManager(m.app)
                sm.show(setup_section)
                m.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
            endif
        else if (m.inMainSelector)
            if (m.updatedFlag OR m.menuSelectorIndex=0 OR (m.updatedFlag=false AND (m.inStep=1 OR m.inStep=2 OR m.inStep=3)))
                m.inMainSelector=false
                m.showSubSectionOptions()
            endif
        else if (m.inResetSleepButton)
            m.resetPreferences()
        else if (m.inBedTimeSelector)

            m.inBedTimeSelector = false
            m.inDarkScreenSelector = true
            m.paintSleepTimeDuration("Active")
            m.paintBedTimeThumby(true, false)
            m.paintBedTimeArrows("No")
            m.paintSleepyBG()
            m.paintBedTimeSelector(0)

        else if (m.inDarkScreenSelector)

            m.paintSleepTimeDuration("No", true, true)
            m.inDarkScreenSelector = false
            m.inSaveButton1 = true
            m.paintSaveButton1("Active")

        else if (m.inSaveButton1)

            'paint mkt
            'm.paintSleepMarketing()
            m.sleepStartMessage()

            ' saves info in database then moves to next main selector
            m.saveSettings()
            m.paintSaveButton1("No")
            m.inSaveButton1 = false
            m.inStep = 1
            'm.inMainSelector = false
            m.menuSelectorIndex = 1
            m.mainSelector(m.menuSelectorIndex)
            m.clearMainSelection(0)
            'm.paintDarkScreenSoundsThumby(false,true)

            'm.paintAudioPlayTime("No")
            'm.paintSaveButton2("No")
            'm.isThumb1=true

            'to activate zone
            'm.paintBedTimeArrows("Active")
            'm.clearSleepyBG()
            'm.paintBedTimeSelector(0, true)
            'm.inDarkScreenAudioSelect = true
            'm.inAudioTimerChoice = false
            m.inMainSelector=true

            m.paintBedTimeThumb()

            'appear the start sleep button

            'm.resetButton()

        else if (m.inDarkScreenAudioSelect)

            m.inDarkScreenAudioSelect = false
            m.inPreviewSound = true
            m.previewsoundtext(true)
            'play sound and show text of selection on next click
            DownloadFile("http://ahhveo.com/_dev/sounds/previews/"+m.selectedAlarmSoundIndex.preview,"sleep.mp3")
            m.app.audio.play("http://ahhveo.com/_dev/sounds/previews/"+m.selectedAlarmSoundIndex.preview,"sleep.mp3")
            m.previewsoundtext(false)
        else if (m.inPreviewSound)
            m.audioTimerIndex = 0
            m.clearSleepStartMessage()
            'm.inDarkScreenAudioSelect = false
            m.app.audio.stop()
            m.inPreviewSound = false
            m.inAudioTimerChoice = true

            m.paintAudioPlayTime("Active")
            m.paintBelowItemsSelector(0, true)

            ' to deactivate items before this
            m.paintDarkScreenSoundsThumby(true, false)
            m.paintBedTimeArrows("No")
            m.paintWakeUpBG()
            m.paintBedTimeSelector(0, false)

        else if (m.inAudioTimerChoice OR m.inAudioTimerSubChoice)

            m.inAudioTimerChoice = false
            m.inAudioTimerSubChoice = false
            m.inSaveButton2 = true
            m.paintSaveButton2("Active")

            ' to deactivate previous section
            m.paintAudioPlayTime("No")
            m.paintBelowItemsSelector(0, false)
            m.clearbelowitemsselector()


        else if (m.inSaveButton2)
            'paint mkt
            'm.paintSleepMarketing()
            m.sleepStartMessage()
            m.inSaveButton2 = false
            m.inStep = 2
            'clear section and paint first next one
            m.canvas.clearLayer(120)
            m.canvas.clearLayer(131)
            m.canvas.clearLayer(122)
            m.canvas.clearLayer(190)
            m.canvas.clearLayer(85)
            m.canvas.clearLayer(86)
            m.canvas.clearLayer(110)
            m.canvas.clearLayer(57)
            m.canvas.clearLayer(281)
            'm.clearSleepyBG()
            m.clearWakeUpBG()
            m.menuSelectorIndex = 2
            m.mainSelector(m.menuSelectorIndex)
            m.inMainSelector = true
            ' paint next one below

            'm.inAlarmQuestion1 = true
            m.saveSettings()
            'm.paintQuestion1("Active")
            'm.paintBelowItemsSelector(3, true)

            ''''''
            m.paintBedTimeSoundThumb()

            '

            'm.resetButton()
        else if (m.inAlarmQuestion1)
            m.inAlarmQuestion1 = false
            m.clearSleepStartMessage()
            if (m.alarmAnswer1="Yes")
                ' we paint next question
                m.inAlarmQuestion2 = true
                m.paintQuestion1("No")
                m.paintQuestion2("Yes")
                m.paintBelowItemsSelector(4, true)
                m.paintNowDate()
                m.isThumb2=true
            else

                'paint mkt
                m.sleepStartMessage()
                m.resetButton()

                ' return to main selection
                m.inStep=3
                m.inSaveButton3 = false
                m.inMainSelector= false
                m.saveSettings()
                'paint final
                m.menuSelectorIndex = 0
                m.clearAlarmBG()
                m.paintWakeUpThumb("No")
                m.startYourSleepButton(true)
                m.inStartYourSleepButton = true
                m.isThumb2=false
                
                'clear below
                m.canvas.clearLayer(84)
                m.canvas.clearLayer(88)
                m.canvas.clearLayer(90)
                m.canvas.clearLayer(97)
                m.canvas.clearLayer(231)
                m.canvas.clearLayer(232)
                m.canvas.clearLayer(233)
                m.canvas.clearLayer(234)
                m.canvas.clearLayer(235)
                m.canvas.clearLayer(60)
                m.canvas.clearLayer(247)
                m.canvas.clearLayer(111)
                m.canvas.clearLayer(85)
                m.canvas.clearLayer(86)
                m.canvas.clearLayer(57)
                m.canvas.clearLayer(102)
                m.canvas.clearLayer(300)
            endif

        else if (m.inAlarmQuestion2)
            m.inAlarmQuestion2=false
            if (m.alarmAnswer1="Yes")
                m.inAlarmQuestion3=true
                m.paintQuestion2("No")
                m.paintQuestion3("Yes")
                m.paintBelowItemsSelector(5, true)
            else
                ' return to main selection

            endif
        else if (m.inAlarmQuestion3)
            m.inAlarmQuestion3=false
            if (m.acw=0 OR m.acw=1)
                m.inAlarmQuestion4=true
                m.paintQuestion3("No")
                m.paintQuestion4("Yes")
                print m.wakeupalarmsound[0]
                DownloadFile(m.wakeupalarms[m.ac].url,"alarm.mp3")
                m.app.audio.play(m.wakeupalarms[m.ac].url,"alarm.mp3")
                m.paintBelowItemsSelector(6, true)
                m.isThumb3=true
            else
                m.clearAlarmBG()
                m.inWakeUpCarousel=true
                m.canvas.clearLayer(90)
                'm.paintQuestion4("No")
                m.paintWakeUpThumby(false, "Yes")
                m.paintWakeUpArrows("Active")
                m.paintBedTimeSelector(3, true)
                m.isThumb3=true
            endif
        else if (m.inAlarmQuestion4)
            m.inAlarmQuestion4=false
            m.clearAlarmBG()
            m.inWakeUpCarousel=true
            m.canvas.clearLayer(90)
            m.paintQuestion4("No")
            m.paintWakeUpThumby(false, "Yes")
            m.paintWakeUpArrows("Active")
            m.paintBedTimeSelector(3, true)
            m.app.audio.stop()
        else if (m.inWakeUpCarousel)
            m.app.audio.stop()
            m.inWakeUpCarousel = false
            m.inStopVideoAfter = true

            ' paint here text and option
            m.paintStopVideoAfter("Active")
            m.paintBelowItemsSelector(7, true)

            ' deactivate carousel
            m.paintWakeUpThumby(true, "No")
            m.paintWakeUpArrows("No")
            m.paintAlarmBG()
            m.paintBedTimeSelector(3, false)
            m.paintSaveButton3("No")

        else if (m.inStopVideoAfter)

            m.inStopVideoAfter=false
            m.inSaveButton3=true

            'paint next
            m.paintSaveButton3("Active")

            'deactive before
            m.paintStopVideoAfter("No")
            m.canvas.clearLayer(90)

        else if (m.inSaveButton3)

            'paint mkt
            m.sleepStartMessage()

            m.inSaveButton3 = false
            m.inMainSelector= false
            m.inStep=3
            m.menuSelectorIndex = 0
            m.saveSettings()
            m.clearAlarmBG()
            'paint final
            if (m.acw=2)
                m.paintWakeUpThumb("NoSound")
            else
                m.paintWakeUpThumb()
            endif
            m.startYourSleepButton(true)
            m.inStartYourSleepButton = true
            m.resetButton()
            'clear below
            m.canvas.clearLayer(84)
            m.canvas.clearLayer(88)
            m.canvas.clearLayer(97)
            m.canvas.clearLayer(231)
            m.canvas.clearLayer(232)
            m.canvas.clearLayer(233)
            m.canvas.clearLayer(234)
            m.canvas.clearLayer(235)
            m.canvas.clearLayer(60)
            m.canvas.clearLayer(247)
            m.canvas.clearLayer(111)
            m.canvas.clearLayer(85)
            m.canvas.clearLayer(86)
            m.canvas.clearLayer(57)
            m.canvas.clearLayer(102)
            m.canvas.clearLayer(300)
        else if (m.inStartYourSleepButton)

            'start player here
            if (type(m.selectedBedVideoIndex)<>"roInteger" AND type(m.selectedAlarmSoundIndex)<>"roInteger")
                if (m.audiotimerindex=0)
                    m.sleeptimeduration = 12*60
                endif

                a = SleepPlayer(m, m.app, m.selectedBedvideoIndex, m.tbs, m.selectedAlarmSoundIndex.filename, m.selectedAlarmSoundIndex.id, m.selectedAlarmSoundIndex.screensaverimage, m.sleeptimeduration, m.wakeuptime, m.selectedWakeUpVideoIndex, m.wakeupvideoduration, m.alarmAnswer1, m.acw, m.alarmchime[m.ac], m.wakeupalarmsound[0])
            else
                ' we load the data here with webservices
                data1 = m.app.http.getWs("getSleepSound.php?user_id="+m.app.userid)
                data2 = m.app.http.getWs("getSleepy.php")
                m.wakeupData=m.app.http.getWs("getWakeUp.php")
                m.selectedWakeUpVideoIndex = m.wakeupData[m.app.wIndex]
                m.selectedAlarmSoundIndex = data1[0]
                m.selectedBedVideoIndex = data2[0]
                if (m.audiotimerindex=0)
                    m.sleeptimeduration = 12*60
                endif
                default_url = "videos/roku/r062_MED_Ahhveo10_30_14v13/r062_MED_Ahhveo10_30_14v13.m3u8"

                a = SleepPlayer(m, m.app, m.selectedBedVideoIndex, m.tbs, m.selectedAlarmSoundIndex.filename, m.selectedAlarmSoundIndex.id, m.selectedAlarmSoundIndex.screensaverimage, m.sleeptimeduration, m.wakeuptime, m.selectedWakeUpVideoIndex, m.wakeupvideoduration, m.alarmAnswer1, m.acw, m.alarmchime[m.ac], m.wakeupalarmsound[0])
            endif
            a.setup()
            a.paint()
            a.eventloop()

        endif

    else if (index=7) then


       'm.app.setBackground()
       'm.clearSleepSection()
       'm.app.isPlaces=true
       'm.app.section.show(places_section)
       'm.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")

    else if (index=10)

        m.resetPreferences()

        'query to reset in db

    end if
end Function

function reset_preferences() as void

    m.inStep=1
    'paint dialog before resetting
    resp = m.app.dialog.confirm2("Are you sure that you want to reset your sleep settings?")

    if (resp)

        if (m.inResetSleepButton)
            m.inTopMenu = true
        endif

        dataResponse = m.app.http.getWs("resetSleepSettings.php?user_id="+m.app.userid)

        m.sleepPaint()

    endif
    'datastring = "?user_id="+m.app.userid+"&bedtime_video_id="+m.bedtime_video_id.toStr()+"&bedtime_before_sleep="+m.tbs.toStr()+"&bedtime_sound="+m.sss.toStr()+"&wakeup_video_id="+m.wakeup_video_id.toStr()+"&wakeup_time="+wutime+"&wakeup_sound="+m.ac.toStr()+"&wakeup_sound_when="+m.acw.toStr()+"&bedtime_sound_duration="+m.sleeptimeduration.toStr()+"&wakeup_video_duration="+m.wakeupvideoduration.toStr()+""
    'dataResponse = m.app.http.getWs("setSleepSettings.php"+datastring)

end function

function clear_sleep() as void
    m.canvas.clearLayer(222)
    m.canvas.clearLayer(50)
    m.canvas.clearLayer(51)
    m.canvas.clearLayer(52)
    m.canvas.clearLayer(53)
    m.canvas.clearLayer(54)
    m.canvas.clearLayer(55)
    m.canvas.clearLayer(56)
    m.canvas.clearLayer(57)
    m.canvas.clearLayer(58)
    m.canvas.clearLayer(59)
    m.canvas.clearLayer(60)
    m.canvas.clearLayer(63)
    m.canvas.clearLayer(64)
    m.canvas.clearLayer(65)
    m.canvas.clearLayer(66)
    m.canvas.clearLayer(67)
    m.canvas.clearLayer(131)
    m.canvas.clearLayer(84)
    m.canvas.clearLayer(110)
    m.canvas.clearLayer(111)
    m.canvas.clearLayer(300)
    m.canvas.clearLayer(400)
    m.canvas.clearLayer(401)
    m.canvas.clearLayer(40)
    m.canvas.clearLayer(41)
    m.canvas.clearLayer(42)
end function

function clear_sleep_advanced() as void
    m.canvas.clearLayer(70)
    m.canvas.clearLayer(71)
    m.canvas.clearLayer(72)
    m.canvas.clearLayer(73)
    m.canvas.clearLayer(74)
    m.canvas.clearLayer(75)
    m.canvas.clearLayer(76)
    m.canvas.clearLayer(77)

end function

function clear_top() as void
    m.canvas.clearLayer(42)
end function

function clear_subtop() as void
    m.canvas.clearLayer(42)
end function

function clear_wu_selector() as void
end function

function clear_bt_selector() as void
    m.canvas.clearLayer(57)
end function

function clear_below_items_selector() as void
    m.canvas.clearLayer(90)
end function


function clear_all2() as void
    m.clearsleep()
    m.clearsleepadvanced()
    m.clearsubtop()
    m.clearbtselector()
    m.clearbelowitemsselector()
    m.clearMainSelector()
    m.canvas.clearLayer(181)
    m.canvas.clearLayer(33)
end function

function clear_sleepy_bg() as void
    m.canvas.clearLayer(400)
end function

function clear_wakeup_bg() as void
    m.canvas.clearLayer(401)
    m.canvas.clearLayer(443)
    m.canvas.clearLayer(444)
end function

function clear_alarm_bg() as void
    m.canvas.clearLayer(401)
end function

function clear_main_selector() as void
    m.canvas.clearlayer(102)
end function

function clear_sleep_start_message() as void
    'm.canvas.clearlayer(101)
    m.canvas.clearlayer(69)
end function

function clear_main_selection(index=0) as void

    if (index=0)
        m.canvas.clearLayer(57)
        m.canvas.clearLayer(71)
        m.canvas.clearLayer(72)
        m.canvas.clearLayer(84)
        m.canvas.clearLayer(83)
        m.canvas.clearLayer(85)
        m.canvas.clearLayer(86)
        m.canvas.clearLayer(110)
        m.canvas.clearLayer(400)
    else if (index=1)

    else if (index=2)

    endif

end function

Function paint_marketing2() as void

    print "marketing"

    if m.app.trial
        json=m.app.http.getWs("getNews.php?trial=0")
    else
        json=m.app.http.getWs("getNews.php?trial=1")
    endif
    m.app.json=json

    items = []

    bottombg = {url:"pkg:/images/bottombg.png",TargetRect:{x:0,y:515,w:1280,h:200}}

    'items.push({Color: "#343434", TargetRect:{x:0,y:530,w:1280,h:200}})

    items.push({text:json.title,
            textAttrs:{HAlign:"left",font:m.app.carouseltitlefont},
           targetRect:{x:100,y:555,w:840,h:50}})

    items.push({text:json.content,
                textAttrs:{HAlign:"left",font:m.app.h35},
               targetRect:{x:100,y:610,w:620,h:50}})

    items.push({url:json.thumb2,
           targetRect:{x:790,y:575,w:182,h:101}})

    items.push({url:json.thumb1,
           targetRect:{x:1000,y:575,w:182,h:101}})

    copyright = {text:"Patent Pending, Copyright 2015 Ahhveo Inc.", textAttrs:{HAlign:"Center",Color:"#CCCCCC",font: m.app.h4}, targetRect:{x:480,y:500,w:1150,h:50}}

    items.push(copyright)

    m.canvas.setLayer(17, bottombg)
    m.canvas.setLayer(70, items)

End Function



Function clear_marketing2() as void
    m.canvas.clearLayer(17)
    m.canvas.clearLayer(70)

End Function

function clear_sleep_section() as void
    m.canvas.clearLayer(10)
    m.canvas.clearLayer(11)
    m.canvas.clearLayer(34)
    m.canvas.clearLayer(35)
    m.canvas.clearLayer(50)
    m.canvas.clearLayer(51)
    m.canvas.clearLayer(55)
    m.canvas.clearLayer(102)
    'm.canvas.clearLayer(101)
    m.canvas.clearLayer(300)
    m.canvas.clearLayer(70)
    m.canvas.clearLayer(71)
    m.canvas.clearLayer(84)
    m.canvas.clearLayer(83)
    m.canvas.clearLayer(85)
    m.canvas.clearLayer(86)
    m.canvas.clearLayer(74)
    m.canvas.clearLayer(75)
    m.canvas.clearLayer(76)
    m.canvas.clearLayer(77)
    m.canvas.clearLayer(52)
    m.canvas.clearLayer(72)
    m.canvas.clearLayer(120)
    m.canvas.clearLayer(131)
    m.canvas.clearLayer(122)
    m.canvas.clearLayer(190)
    m.canvas.clearLayer(400)
    m.canvas.clearLayer(110)
    m.canvas.clearLayer(60)
    m.canvas.clearLayer(247)
    m.canvas.clearLayer(54)
    m.canvas.clearLayer(401)
    m.canvas.clearLayer(111)
    m.canvas.clearLayer(53)
    m.canvas.clearLayer(63)
    m.canvas.clearLayer(64)
    m.canvas.clearLayer(131)
    m.canvas.clearLayer(42)
    m.canvas.clearLayer(23)
    m.canvas.clearLayer(231)
    m.canvas.clearLayer(232)
    m.canvas.clearLayer(233)
    m.canvas.clearLayer(234)
    m.canvas.clearLayer(235)
    m.canvas.clearLayer(40)
    m.canvas.clearLayer(41)
    m.canvas.clearLayer(42)
end function
