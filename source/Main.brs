Library "v30/bslCore.brs"
Function Main(args as Dynamic) as void
    
End Function

Sub Tickle_the_player()
   eol = Chr(13)+Chr(10)
   adrs = createobject( "roSocketAddress" )
   adrs.setAddress( "http://localhost:8060" )
   tcp = CreateObject( "roStreamSocket" )
   tcp.setSendToAddress( adrs )
   tcp.connect()
   obuf = createobject( "roByteArray" )
   obuf.FromAsciiString( "POST /keypress/Lit_X HTTP/1.1"+eol+eol )
   z = obuf.Count()
   obuf[z] = 0
   tcp.send( obuf, 0, z )
End Sub

Sub Tickle_small()
    req = createObject("roUrlTransfer")
    req.setUrl("http://localhost:8060/keypress/Lit_+")
    req.postFromString("")
end Sub

Sub RunUserInterface(args as Dynamic)

InitTheme()
app=CreateApp()
selectedIndex=0
if (args.contentID <> invalid)
    print args.contentID
endif
app.init()

'''''''''''''''''''''''''''''''''''''''''''''


    'Main Remote Listener
    'This Listener handles all menuManager and sectionManager Remote Actions
    while true

        if(app.set_exit<>Invalid)
            exit while
        endif
        event = wait(320, app.port)
        if (event<> invalid)
            
                
        
                if type(event) = "roAudioPlayerEvent"
                        if event.isStatusMessage() then
                            if event.getmessage() = "end of playlist"
                            
                            else  if event.getmessage() = "end of stream" then
                                print "ended audio"
                                'if app.sleeping
                                '    app.audio.play(app.settings.sleep_sound,"sleep.wma")
                                'else
                                '    app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
                                'endif
                            end if
                         endif 
                endif                                  
        
        
                if type(event) = "roChannelStoreEvent" then
                
                        if event.IsRequestSucceeded() then
                            response= event.GetResponse()
                            for each res in response
                                ' if subscription exists all ok, if not we need to check if still on our database and delete it;'                                
                                if (res.code="ahhveo12hrs" OR res.code="S12HOURS") then
                                    print "ahhveo12hrs"
                                    subcheck=app.http.getWs("checkSubscription.php?device_id="+app.deviceid+"&user_id="+app.cuserid+"&type=s12hr")
                                else if (res.code="ahhveo25hrs" OR res.code="S25HR") then
                                    print "ahhveo25hrs"
                                    subcheck=app.http.getWs("checkSubscription.php?device_id="+app.deviceid+"&user_id="+app.cuserid+"&type=s25hr")
                                else if (res.code="ahhveo50hrs" OR res.code="S50HR") then
                                    print "ahhveo50hrs"
                                    subcheck=app.http.getWs("checkSubscription.php?device_id="+app.deviceid+"&user_id="+app.cuserid+"&type=s50hr")
                                'else if res.code="AT7HR" then
                                '    print "at7hr"
                                'else if res.code="101" then
                                '    print "101"
                                'else if res.code="81" then
                                '    print "81"
                                'else if res.code="82" then
                                '    print "82"
                                'else if res.code="PACK6" then
                                '    print "PACK6"
                               'else if res.code="88" then
                               '    print "88"
                                else
                                    app.wsc="cancelSubscription.php?device_id="+app.deviceid+"&user_id="+app.cuserid
                                    usercancel=app.http.getWs(app.wsc)
                                    if usercancel.done="1" then
                                        app.reloadAllData()
                                    endif
                                endif 
                            end for
                        else if event.IsRequestFailed() then
                            print "channel store req failed: ";event.GetStatusMessage()
                        end if    
          
                         
               else if (event.isRemoteKeyPressed())
                    if(app.deviceinfo.getLinkStatus()=false) app.dialog.alert2("Your connection to the server was lost. Try checking your network settings. Thank you.")
                    index = event.GetIndex()
                    if(index=6 or index=5)app.audio.player.stop()   
                    
                    if (index<>32 and app.sleeping)
                         app.setBackground()
                         app.player.set_sleep=false
                         app.canvas.clearLayer(502)
                         app.canvas.clearLayer(503)
                         app.screensaverFlag=false
                         app.lastsleeptime=0
                         'app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma") ''except when it comes from the player screensaver
                         if (app.isplaces) app.audio.player.stop()
                    endif
                         
                     'Disable all remote events, for example when
                     'Start the Player or Showing Dialog
                          'Handles RemoteListener
                                                                              
                         if (app.sleeping=false)
                             app.remoteIndex=index
                             if(type(app.remoteListener)="roAssociativeArray")
                                    app.remoteListener.remoteCallback(app.remoteIndex)
                             endif
                        
                              'Handles Main Menu
                              if(app.menu.inMain)
                                app.menu.handleMenuAction(app.remoteIndex)
                              end if   
                               
                          else if (app.sleeping and index<>32)
                                app.setBackground()
                                app.sleeping=false
                                app.hideScreensaver()
                          endif   
                
                    'Global Sleep Timer
                    'app.restartGlobalSleepTimer()
                
                
                endif
                
        endif
        
        
       'In News
       if(app.inNews)
           if(type(app.chronListener)="roAssociativeArray")
                            app.chronListener.remoteCallback(app.remoteIndex)
           endif
       endif
       
       if(app.timeout<>0)
           
            if(app.timer.totalMilliseconds()>app.timeout)
                if(type(app.timeoutCallback)="roFunction")
                    app.timeoutCallback()
                    app.timeoutCallback=false
                endif                
            endif
       endif
       
       
       if(app.sleeping)
            if(app.lastsleeptime<app.timer.TotalMilliseconds())
                app.lastsleeptime=app.lastsleeptime+1
                
                if (app.lastsleeptime MOD 25=0)
                       dr = app.http.getWs("logState.php?userID="+app.getRegistry()+"&leftAt=screensaver")
                       app.randomizeScreensaver(app.darkscreensaver)
                       print app.lastsleeptime
                       print ">"
                       print app.sleeptimeduration
                else if (app.lastsleeptime MOD 100=0)
                        app.ticklesmall()
                else if (app.lastsleeptime>app.sleeptimeduration)
                    if (app.stopsoundflag=false)
                        print "stopped sound"
                        app.audio.player.stop()
                        app.stopsoundflag=true
                     endif  
                endif
                
                'if app.globalscreensavertimer<app.timer.totalMilliseconds() ' should be 12 hours
                '    app.sleeping=false
                '    app.hideScreenSaver()
                '    app.setBackground()
                '    app.restartGlobalScreenSavertimer()
                'endif
            
            endif
       endif
       
       'if(app.lastglobalsleeptimer<>0)
       '               
       '         if(app.sleeping=false and (app.lastglobalsleeptimer<app.timer.totalMilliseconds()))
       '             app.sleeping=true
       '             app.audio.play(app.settings.sleep_sound,"sleep.wma")
       '         endif      
       'endif
    end while


'stop


End Sub


Function CreateApp() As Object

    this = {
            port:      CreateObject("roMessagePort")
            fonts:     CreateObject("roFontRegistry") 'global font registry
            canvas:    CreateObject("roImageCanvas") 'user interface
            timer:CreateObject("roTimespan")
            myuser:CreateObject("roAssociativeArray")
            appInfo:CreateObject("roAppInfo")
            deviceinfo:CreateObject("roDeviceInfo")
            wsString:""
            store:     CreateObject("roChannelStore")
            base_ws:"http://ahhveo.com/_dev/test/roku/ws2/"
            base_sounds:"http://ahhveo.com/_dev/sounds/"
            base_pp_ws:"http://ahhveo.com/_dev/final/paypal/"
            'callalert:call_an_alert
            support_email:"support@ahhveo.com"
            remoteListener:false
            init:main_init
            setLogo:main_set_logo
            setBackground:main_set_background
            drawTip:main_draw_tip
            drawTitle:main_draw_title
            drawRelaxNowTitle:main_draw_relaxnow_title
            click:CreateObject("roAudioResource","pkg:/sounds/select.wav")
            move:CreateObject("roAudioResource","pkg:/sounds/move.wav")
            switchSound:main_swtich_sound
            soundFx:main_sound_fx
            forceSection:main_force_section
            exitApp:main_exit_app
            onTimeOver:main_on_time_over
            showPreloader:main_show_preloader
            hidePreloader:main_hide_preloader
            timeout:0
            timeoutinterval:4000
            setTimeout:main_set_timeout
            notTos:main_not_tos
            tosAgree:main_tos_agree
            subscribe:main_do_subscription
            exploreAhhveo:main_explore_ahhveo
            goHome:main_go_home
            startScreensaver:main_start_screensaver
            startSleepTimer:main_start_sleep_timer
            showScreensaver:saver_show_screensaver
            hideScreensaver:saver_hide_screensaver
            randomizeScreensaver:saver_randomize_screensaver
            sleeping:false
            sleeptime:5000
            lastsleeptime:0
            screensaverFlag:false
            lastglobalsleeptimer:0
            globalsleeptime:300000 ' 5 Min ' 300000
            globaltrialtime:300000 ' 5 min
            previewtime:35000
            ispreview:false
            globalscreensavertimer:43200000'TODO 10 mins now , change to 12 hours
            staticscreensavertimer:43200000
            restartGlobalSleepTimer:main_restart_global_sleep_timer
            restartGlobalScreenSavertimer:main_restart_global_screensaver_timer
            isTrial:main_is_trial
            isTrial2:main_is_trial2
            sleepSound:0           
            tos:false
            reloadData:main_reload_data
            reloadAllData:main_reload_all_data
            trial:true
            cuserid:"0"
            deviceid:"0"
            wsc:""
            seeterms:false
            seepolicy:false
            st:1
            tickle:Tickle_the_player
            ticklesmall:Tickle_small
            nscreensaver:invalid
            setRegistry:setAuthData
            getRegistry:getAuthData
            delRegistry:deleteAuthData
            loadonchange:false
            isPlaces:false
            hdmode:true
            userLogin:userLogin
            userSignIn:userSignIn
            items:[]
            facade:invalid
            inSettings:false
            inSettingsInSection:false
            globalvideotimer:2400000
            globalalarm:0
            darkscreensaver:invalid
            sleeptimeduration:60000
            stopsoundflag:false
            loggedflag:false
            bIndex:0
            sIndex:0
            wIndex:0
            timeover:false
           }
        
    this.header_h=50
    this.margin_top=50
    this.canvas.SetMessagePort(this.port)    
    this.store.setMessagePort(this.port)
    
    devicesize=this.deviceinfo.GetDisplaySize()
    this.size=devicesize
   
    'this.store.getCatalog()
    'this.store.FakeServer(false)
        
    'for the SD
    'for the HD
    if(ISHD())
        this.safe_h=646
        this.safe_w=1150
        this.edge_top=35
        this.edge_left=64
        this.hd=true
        this.hdmode=true
        this.screen=CreateObject("roScreen", true, 1280, 720)  'try this to see zoom 840, 500 '
        this.sidebar_width=280
    else
        this.safe_h=432
        this.safe_w=648
        this.edge_top=24
        this.edge_left=36
        this.hd=false
        this.hdmode=false
        this.screen=CreateObject("roScreen", true, 720, 480) ' add, 1280, 720 ?
        this.sidebar_width=158
    end if
   

    


    this.size.free_width=(this.safe_w-(this.sidebar_width+this.edge_left))
    this.size.center_x=this.sidebar_width+Fix((this.safe_w-this.sidebar_width)/2)
    this.size.center_x_full=Fix((this.safe_w+this.edge_left)/2)
    this.size.center_y=Fix(this.safe_h/2)

   ' Register available fonts:
    this.fonts.Register("pkg:/fonts/HelveticaNeueLTStd-Md.otf")
    this.fonts.Register("pkg:/fonts/HelveticaNeueLTStd-Lt.otf")
    this.fonts.Register("pkg:/fonts/ProximaNova.otf")
    
    if (IsHD())
        this.menufont=this.fonts.get("HelveticaNeueLT Std Med",26,false,false)
        this.carouseltitlefont=this.fonts.get("HelveticaNeueLT Std Lt",32,false,false)
        this.carouseldescriptionfont=this.fonts.get("HelveticaNeueLT Std Lt",25,false,false)
        this.tooltipfont=this.fonts.get("HelveticaNeueLT Std Lt",15,false,false)
        this.h1=this.fonts.get("HelveticaNeueLT Std Lt",35,false,false)
        this.h2=this.fonts.get("HelveticaNeueLT Std Lt",30,false,false)
        this.h35=this.fonts.get("HelveticaNeueLT Std Lt",22,false,false)
        this.h3=this.fonts.get("HelveticaNeueLT Std Lt",25,false,false)
        this.h4=this.fonts.get("HelveticaNeueLT Std Lt",20,false,false)
        this.h45=this.fonts.get("HelveticaNeueLT Std Lt",18,false,false)
        this.h5=this.fonts.get("HelveticaNeueLT Std Lt",16,false,false)
        this.h55=this.fonts.get("HelveticaNeueLT Std Lt",14,false,false)
        this.h6=this.fonts.get("HelveticaNeueLT Std Lt",11,false,false)
        this.hnova=this.fonts.get("ProximaNova",25,false,false)
    else
        this.menufont=this.fonts.get("HelveticaNeueLT Std Med",15,false,false)
        this.carouseltitlefont=this.fonts.get("HelveticaNeueLT Std Lt",18,false,false)
        this.carouseldescriptionfont=this.fonts.get("HelveticaNeueLT Std Lt",14,false,false)
        this.tooltipfont=this.fonts.get("HelveticaNeueLT Std Lt",8,false,false)
        this.h1=this.fonts.get("HelveticaNeueLT Std Lt",20,false,false)
        this.h2=this.fonts.get("HelveticaNeueLT Std Lt",17,false,false)
        this.h35=this.fonts.get("HelveticaNeueLT Std Lt",22,false,false)
        this.h3=this.fonts.get("HelveticaNeueLT Std Lt",14,false,false)
        this.h4=this.fonts.get("HelveticaNeueLT Std Lt",11,false,false)
        this.h45=this.fonts.get("HelveticaNeueLT Std Lt",10,false,false)
        this.h5=this.fonts.get("HelveticaNeueLT Std Lt",9,false,false)
        this.h55=this.fonts.get("HelveticaNeueLT Std Lt",7,false,false)
        this.h6=this.fonts.get("HelveticaNeueLT Std Lt",6,false,false)
        this.hnova=this.fonts.get("ProximaNova",25,false,false)
    endif
 
    
  '  this.textcolor = "#406040"

    'Resolution-specific settings:
    mode = CreateObject("roDeviceInfo").GetDisplayMode()
    
    if mode = "720p"
        this.layout = {
          '  full:   this.canvas.GetCanvasRect()
            top:    { x:   0, y:   0, w:1280, h: 130 }
            left:   { x: 249, y: 177, w: 391, h: 291 }
            right:  { x: 700, y: 177, w: 350, h: 291 }
            bottom: { x: 249, y: 500, w: 780, h: 300 }
        }
  '      this.background = "pkg:/images/back-hd.jpg"
   '     this.headerfont = this.fonts.get("lmroman10 caps", 50, 50, false)
    else
        this.layout = {
          '  full:   this.canvas.GetCanvasRect()
            top:    { x:   0, y:   0, w: 720, h:  87 }
            left:   { x: 140, y: 118, w: 220, h: 194 } '280,210
            right:  { x: 394, y: 118, w: 197, h: 194 }
            bottom: { x: 140, y: 333, w: 539, h: 200 }
    }
   '     this.background = "pkg:/images/back-sd.jpg"
  '      this.headerfont = this.fonts.get("lmroman10 caps", 30, 50, false)
    end if

  
    


    return this


End Function






function main_init() as void
        m.facade = CreateObject("roParagraphScreen")
        m.facade.AddParagraph(" ")
        m.facade.Show()
        
        'm.store.FakeServer(true) ' TODO delete
        
        device=CreateObject("roDeviceInfo")
        deviceid=device.GetDeviceUniqueId()
        m.deviceid=deviceid
       
        m.showPreloader()
        'sleep(3000)
        'm.setLogo()
        m.setBackground()

        'Creating the main menu
        menu=CreateMenu(m)
        
       'items=[]
       'm.items.push({action:relaxnow_section,label:"Relax"})
       m.items.push({action:sleep_section,label:"Sleep"})
       m.items.push({action:places_section,label:"Relax"})
       m.items.push({action:customize_section,label:"Set Up"})
       'm.items.push({action:information_section,label:"Information"})
       'm.items.push({action:shop_section,label:"Shop Ahhveo"})
       'm.items.push({action:settings_section,label:"Settings"})
       
       menu.setOptions(m.items)
        
       sm=sectionManager(m)
       dlg=CreateDialog(m)
       m.menu=menu
       m.section=sm
       m.dialog=dlg
       m.inNews=true
       'menu.render(0)
       'menu.drawLineReference()
       'sm.show(home_section) 
       audio=NewAudio(m)
       m.audio=audio
       player=NewPlayer(m)
       m.player=player
       m.http=NewHttp(m)
       m.userFlag=false
         
         
        global_ws="getGlobalTrialTimer.php"
        gtt=m.http.getWs(global_ws)
        
        preview_ws="getPreviewTimer.php"
        pt=m.http.getWs(preview_ws)
           
        m.globaltrialtime=gtt.globaltrialtimer
        m.previewtime=pt.previewtime
        
        ' m.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
        
       'sm.show(home_section) 
        
        m.menu.executeAction()
        'm.userLogin()   
end function



function main_swtich_sound(index) as void
    if(index=2 or index=3 or index=4 or index=5)
        if(index=4 or index=5)
            if(m.menu.inMain)
                m.soundFx("click")
                return
            else
                m.soundFx()
            endif
        endif
        m.soundFx()
    else if(index=0 or index=6 or index=7)
        m.soundFx("click")
    endif
    
end function



function main_sound_fx(fx="move") as void

  '  return
    
    if(fx="click")
        m.click.trigger(60)
    else
        m.move.trigger(60)
    endif
    
end function






function main_exit_app() as void
    m.set_exit=true
    m.canvas.close()
    m.facade.close()
end function

function main_on_time_over() as void
dr = m.http.getWs("logState.php?userID="+m.getRegistry()+"&leftAt=purchasing_something")
ws="getPopup.php?id=10"
popup=m.http.getWs(ws)

options=[popup[0].option_1, popup[0].option_2]
message=popup[0].content
                        
ws="getPopup.php?id=11"
popup=m.http.getWs(ws)

options2=[popup[0].option_1, popup[0].option_2]
message2=popup[0].content

                                 if(m.trial)
                                 
                                            resp=m.dialog.confirmbuy2(message,options)
                                            
                                            if resp then 
                                                m.istrial()
                                                  'ws="getPopup.php?id=1"
                                                  'popup=m.http.getWs(ws)
                                                  'r2=m.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
                                                  '  options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                                                  'if r2=2
                                                  '  m.subscribe(3)
                                                  'else if r2=1
                                                  '  m.subscribe(2)
                                                  'else if r2=0
                                                  '  m.subscribe(1)
                                                  'endif   
                                            endif
                                               'm.app.subscribe()
                                            
                                 else
                                    
                                    resp=m.dialog.confirmbuy2(message,options)
                                            
                                    if resp then
                                         
                                         resp2=m.dialog.confirmbuy(message2,options2)
                                         if resp2 then         
                                                
                                                userid=m.userid
                                                ws="buyAdditionalTime.php?user_id="+userid
                                                m.store.clearorder()
                                                order=[{code:"ahhveoadditionaltime",qty:1}]
                                                currentOrder = m.store.SetOrder(order)  ' id del producto en la tienda a comprar
                                               
                                                m.dialog.process("Please wait...")
                                                purchase = m.store.DoOrder()
                                                m.dialog.stopProcess()
                                                
                                                
                                                if purchase
                                                            
                                                            m.dialog.process("Please wait...")
                                                            addt=m.http.getWs(ws)
                                        '                    ws="paytime.php?user_id="+userid
                                        '                    addt=m.app.http.getPPWs(ws)
                                                            
                                                            m.dialog.stopProcess()
                                                            
                                                           if(type(addt)<>"roInvalid")
                                                                if(addt.done="1")
                                                                
                                                                     m.dialog.alert("Purchase completed for 12 additional hours of streaming time. Thank You!")     
                                                                     'addtxt=m.toTime(addt.time_available.toStr())
                                                                     m.consumed=false
                                                                     'time_remain={text:"Time remaining: "+addtxt+" hours",textAttrs:{HAlign:"Left",font:m.app.h3},targetRect:m.positions[3]}
                                                                     'm.canvas.setLayer(53,time_remain)
                                                                     'm.goHome()
                                                                      m.timeover = false
                                                                endif
                                                            endif
                                                else
                                                     m.dialog.alert("Something failed with your purchase of additional time. Please try again.")
                                                     'm.goHome()
                                                endif 'end if Purchase
                                         else
                                           ' m.goHome()      
                                         endif
                                    else
                                       ' m.goHome()
                                    endif
                                    
                                            
                                            
                                 endif

end function

function main_not_tos() as void
        print "not tos function"
        dr = m.http.getWs("logState.php?userID="+m.getRegistry()+"&leftAt=trial_popup")
         ws="getPopup.php?id=5"
         popup=m.http.getWs(ws)
         r3=m.dialog.optional({text:popup[0].content,
                                 options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]})
                print "user clicked on not tos"
                print r3
                if(r3=2) ' clicked back
                    m.isTrial()
                else if(r3=1)   ' clicked view terms
                      m.inNews=false
                      m.seepolicy=false
                      m.seepolicy=false
                      print "going to move"
                      m.dialog.removeDialog()
                      '#todo
                      m.section.show(setup_section)
                    
                else if r3=0
                    m.tosAgree() ' clicked i agree
                else 
                    m.isTrial()
                endif
end function


function main_is_trial2() as void
m.istrial()
           '          ws="getPopup.php?id=1"
           '          popup=m.http.getWs(ws)
           '          r2=m.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
           '                  options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
           '           if r2=2
           '             m.subscribe(3)
            '          else if r2=1
            ''            m.subscribe(2)
            '          else if r2=0
            '            m.subscribe(1)
            '          else 
                        'r3=m.dialog.optional({text:"In order to subscribe to Ahhveo we ask you to agree our Terms of Use and Privacy Policy. Feel free to explore them, thank you!",
                        '     options:["I Agree","Full Terms of Use","Privacy Policy"]})
        
                        'if(r3=2)
                        '    m.inNews=false
                        '    m.seepolicy=true
                        '    m.section.show(settings_section)
                        'else if(r3=1)
                        '    m.inNews=false
                        '    m.seeterms=true
                        '    m.section.show(settings_section)
                        'else if r3=0
                        '    m.isTrial2()
                        'else
             '               m.goHome()
                        'endif
             '         endif   

end function


function main_is_trial() as void
                 r2 = m.dialog.subpop()
                
                 'm.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
                 'ws="getPopup.php?id=1"
                 'popup=m.http.getWs(ws)
                 'r2=m.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
                  '       options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                  print "returned"
                  print r2
                  
                  if r2=0
                    m.subscribe(2)
                  else if r2=-1
                    dr = m.http.getWs("logState.php?userID="+m.getRegistry()+"&leftAt=subscription_popup_2")
                    ws="getPopup.php?id=4"
                    popup=m.http.getWs(ws)
                    r=m.dialog.optional3({text1:popup[0].content, text2:popup[0].content_2,
                     options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                     print "user clicked on is trial"
                     print r    
                    if(r=2)
                        m.exitApp()
                    else if(r=0)      
                        print m.tos
                        if m.tos=false then
                            m.notTos()
                            print "notTos"
                        else
                            m.goHome()
                            print "goHome"
                        endif
                    else if r=1                
                        m.isTrial()
                    else 
                       m.isTrial()
                    endif
                    print "out of is trial if"
                  endif
                  'if r2=2
                  '  m.subscribe(3)
                  'else if r2=1
                  '  m.subscribe(2)
                  'else if r2=0
                  ''  m.subscribe(1)
                  'else if r2=3
                    ' nothing
                  'else 
                  '  dr = m.http.getWs("logState.php?userID="+m.getRegistry()+"&leftAt=subscription_popup_2")
                  '  ws="getPopup.php?id=4"
                  '  popup=m.http.getWs(ws)
                  '  r=m.dialog.optional3({text1:popup[0].content, text2:popup[0].content_2,
                  '   options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                  '   print "user clicked on is trial"
                  '   print r    
                  '  if(r=2)
                  '      m.exitApp()
                  '  else if(r=0)      
                  '      print m.tos
                  '      if m.tos=false then
                  '          m.notTos()
                  '          print "notTos"
                  '      else
                  '          m.goHome()
                  '          print "goHome"
                  '      endif
                  '  else if r=1                
                  '      m.isTrial()
                  '  else 
                  '     m.isTrial()
                  '  endif
                  'endif

end function

function main_explore_ahhveo() as void

                        ws="getPopup.php?id=4"
                        popup=m.http.getWs(ws)
                        
                        r=m.dialog.optional3({text1:popup[0].content, text2:popup[0].content_2,
                         options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)    
                        if(r=2)
                            m.exitApp()
                        else if(r=0)      
                            if m.tos=false then
                                m.notTos()
                            endif
                        else if r=1                
                         'ws="getPopup.php?id=1"
                         'popup=m.http.getWs(ws)
                         'r2=m.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
                         'options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                         ' if r2=2
                         '   m.subscribe(3)
                         ' else if r2=1
                         '   m.subscribe(2)
                         ' else if r2=0
                         '   m.subscribe(1)
                         ' else 
                         '   m.isTrial()
                         ' endif
                         m.istrial()
                        else 
                           m.isTrial()
                        endif
end function





function main_tos_agree(toscustom=true as boolean) as boolean

'm.reloadalldata()
            print "toscustom is"
            print toscustom
            if toscustom then
                print "m.trial"
                print m.trial
                m.ispreview=true
                if not m.ispreview then
                    print "m trial false"
                    print "m.userid"
                    print m.userid
                    ws="setTOS.php?user_id="+m.userid
                    'm.dialog.process("Please wait while saving...") 
                    ' TODO here we add the request for roku account information and we update the user account
                    r=m.http.getWs(ws)
                    m.dialog.stopProcess()
                    print "r.done"
                    print r.done
                    if(r.done=1)
                        m.tos=true
                        m.goHome()
                    else
                        m.dialog.alert("An error occurred")
                    endif
                else
                    print "m preview is true"
                    m.tos=true
                    m.dialog.stopProcess()
                    userid=m.userid
                    print "userid is"
                    print m.userid
                    print "goin home"
                    'm.remoteListener=false
                    'm.myuser=m.store.GetPartialUserData("email, firstname")
                    'here we added a lock for the user
                    'ws_update="updateUser.php?user_id="+m.userid+"&email="+m.myuser.email+"&firstname="+m.myuser.firstname+"&device_id="+m.getRegistry()
                    'ws_update_response = m.http.getWs(ws_update)
                    'if (type(ws_update_response)<>"roInvalid") then           
                        'm.goHome()
                    'else 
                    '    m.dialog.alert("An error occurred")
                    '    m.goHome()
                    '    if(m.trial)m.isTrial()
                    'endif
                    'm.reloaddata()
                endif
            else    
                print "toscustom false"
                m.tos=false
                m.goHome()
                if(m.trial)m.isTrial()
            end if

end function






function main_do_subscription(st) as boolean
     m.st = st
     dr = m.http.getWs("logState.php?userID="+m.getRegistry()+"&leftAt=trial_popup")
     ws="getPopup.php?id=2"
     popup=m.http.getWs(ws)
     r3=m.dialog.optional15({text:popup[0].content,
                 options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]})
         if r3=0
            userid=m.userid.trim()
           
            'm.store.ClearOrder()
            'm.GetUserData()
            
            if st=1
                order=[{code:"ahhveo12hrs",qty:1}]
            else if st=2
                order=[{code:"ahhveo25hrs",qty:1}]
            else if st=3
                order=[{code:"ahhveo50hrs",qty:1}]
            endif
            
            currentOrder = m.store.SetOrder(order)  ' id del producto en la tienda a comprar

            m.myuser=m.store.GetPartialUserData("email, firstname")
            ' here we are gonna add a new condition, if user is found subscribed then logins, if not continue with the subscription
            if m.myuser<>invalid
                ws_check_user = "searchEmail.php?email="+m.myuser.email
                ws_check_user_q = m.http.getWs(ws_check_user)
                print ws_check_user_q.id
                if (ws_check_user_q.id<>invalid) then 'user exists 
                    ' login user
                    m.dialog.alert2("You are already subscribed with this Roku account.")
                    'm.isTrial()
                    ' need to update user to add the new token to his account
                else
                
                    ' continue with subscription process here                
                    m.dialog.process("Please wait...")
                    purchase = m.store.DoOrder()
                     
                   
                        if purchase
                            
                            ws_update="updateUser.php?user_id="+userid+"&email="+m.myuser.email+"&firstname="+m.myuser.firstname+"&device_id="+m.getRegistry()
                            ws_update_response = m.http.getWs(ws_update)
                            
                            if (type(ws_update_response)<>"roInvalid") then            
                                ws="setSubscription.php?user_id="+userid+"&subscription_time="+st.tostr()                 
                                subs=m.http.getWs(ws)                                                          
                                m.dialog.stopProcess()
                                if(type(subs)<>"roInvalid")
                                           if(subs.done="1")
                                                ws="getPopup.php?id=3"
                                                popup=m.http.getWs(ws)
                                                m.dialog.alert(popup[0].content)
                                                m.trial=false
                                                m.tos=true
                                                m.timeover=false
                                                m.reloadAllData() 
                                                'm.goHome()
                                                print "reload view"
                                           else
                                                m.dialog.alert("An error occured while trying to subscribe.")
                                           endif
                                else        
                                    m.isTrial()    
                                endif
                            else
                                ws="getPopup.php?id=9"
                                popup=m.http.getWs(ws)
                                m.dialog.alert(popup[0].content)
                                m.isTrial()
                            endif
                        else    
                            m.dialog.alert("An error occured while trying to subscribe.")
                        endif
                    
                    
                endif
            else
                m.isTrial()
            endif
         else if r3=1
            m.inNews=false
            m.seepolicy=false
            m.seeterms=true
            m.isTrial()
            'm.section.show(settings_section)
            'm.menu.executeaction()
         else if r3=2
            m.inNews=false
            m.seeterms=false
            m.seepolicy=true
            m.isTrial()
            'm.section.show(settings_section)
            'm.menu.executeaction()
         else
            m.isTrial()
         endif       
end function







function main_set_timeout(cb) as void
    m.timeoutCallback=cb
    m.timeout=m.timer.TotalMilliseconds()+m.timeoutinterval
end function






function DownloadFile(url,name) as void

   http = NewHttp2(url, "text/xml")
   http.GetToFileWithTimeout("tmp:/"+name, 220)
end function





function main_show_preloader() as void
    m.http=NewHttp(m)
    splashimage = []
    did=m.getRegistry()
    
    thisDate = CreateObject("roDateTime")
    yearbefore = thisDate.getYear() - 1
    yearnow = thisDate.getYear()
    randomselection = m.http.getWs("getRandomNumber.php").rn
    splashimage.Push("http://www.ahhveo.com/_dev/splash/Splash_Jul8.jpg") '_A _B _C
    splashimage.Push("http://www.ahhveo.com/_dev/splash/Splash_Jul8.jpg")
    splashimage.Push("http://www.ahhveo.com/_dev/splash/Splash_Jul8.jpg")
    print "show preloader"
    print randomselection
    print type(splashimage[randomselection])
    print splashimage[randomselection]
    if IsHD()
        'm.canvas.setLayer(701, {text:yearbefore.tostr()+" - "+yearnow.tostr(),textAttrs:{Color:"#ffffff",font:m.carouseldescriptionfont,HAlign:"Left"},targetRect:{x:435,y:643,w:200,h:30}})
        m.canvas.setLayer(700,{url:splashimage[randomselection],targetRect:{w:m.size.w,h:m.size.h,x:0,y:0}})
    else
        'm.canvas.setLayer(701, {text:yearbefore.tostr()+" - "+yearnow.tostr(),textAttrs:{Color:"#ffffff",font:m.carouseldescriptionfont,HAlign:"Left"},targetRect:{x:420,y:643,w:200,h:30}})
        m.canvas.setLayer(700,{url:splashimage[randomselection],targetRect:{w:m.size.w,h:m.size.h-10,x:0,y:0}})
    endif
    m.canvas.setLayer(600, { Color: "#000000", CompositionMode: "Source" })
    m.canvas.show()
    
    if (did<>Invalid)
        dr = m.http.getWs("logState.php?userID="+did+"&leftAt=splash_screen")
    endif
    
end function

function main_hide_preloader() as void
    m.canvas.clearLayer(700)
    m.canvas.clearLayer(600)
end function

function main_set_background() as void

    m.canvas.SetLayer(0, { Color: "#242424", CompositionMode: "Composite" })
   ' m.canvas.setlayer(0, {url: "pkg:/images/mainbackground.png", TargetRect:{x:0,y:0,w:1280,h:1024}})

end function

function main_set_Logo() as void

if (IsHD())
    logo={
        url:"pkg:/images/logo.png",
        TargetRect:{x:m.edge_left,y:20,w:260,h:83}
    }
else
    logo={
        url:"pkg:/images/logo.png",
        TargetRect:{x:m.edge_left,y:27,w:146,h:55}
    }
endif
    m.canvas.SetLayer(105, logo)

end function

function main_draw_tip() as void


    tips=[]
'    tips.push({url:"pkg:/images/goback.png",targetRect:{x:m.sidebar_width+75,y:m.edge_top,w:128,h:49}})
    if (IsHD())
        tips.Push({text:"Back",textAttrs:{Color:"#ffffff",font:m.carouseldescriptionfont,HAlign:"Left"},targetRect:{x:m.sidebar_width+78,y:m.edge_top,w:49,h:15}})
    else
        tips.Push({text:"Back",textAttrs:{Color:"#ffffff",font:m.carouseldescriptionfont,HAlign:"Left"},targetRect:{x:m.sidebar_width+44,y:m.edge_top,w:33,h:10}})
    endif
    m.canvas.setLayer(16,tips)
    
end function

function main_draw_title(t) as void
        if (IsHD())
            title={text:t,textAttrs:{Color:"#ffffff",font:m.carouseldescriptionfont,HAlign:"Left"},targetRect:{x:m.sidebar_width+78,y:m.edge_top,w:250,h:15}}
        else
            title={text:t,textAttrs:{Color:"#ffffff",font:m.carouseldescriptionfont,HAlign:"Left"},targetRect:{x:m.sidebar_width+44,y:m.edge_top,w:141,h:10}}
        endif
        m.canvas.setLayer(16,title)
end function


function main_draw_relaxnow_title() as void
        titledimage=[]
        if (IsHD())
            titledimage.push({url:"pkg:/images/relaxnow_small_star.png",targetRect:{x:m.sidebar_width+540,y:m.edge_top+8,w:15,h:13}})
            titledimage.Push({text:"Relax Now plays your favorite titles (",textAttrs:{Color:"#ffffff",font:m.carouseldescriptionfont,HAlign:"Left"},targetRect:{x:m.sidebar_width+155,y:m.edge_top+5,w:400,h:25}})
            titledimage.Push({text:"), randomly.",textAttrs:{Color:"#ffffff",font:m.carouseldescriptionfont,HAlign:"Left"},targetRect:{x:m.sidebar_width+555,y:m.edge_top+5,w:450,h:25}})
        else
            titledimage.push({url:"pkg:/images/relaxnow_small_star.png",targetRect:{x:m.sidebar_width+304,y:m.edge_top+5,w:8,h:9}})
            titledimage.Push({text:"Relax Now plays your favorite titles (",textAttrs:{Color:"#ffffff",font:m.carouseldescriptionfont,HAlign:"Left"},targetRect:{x:m.sidebar_width+87,y:m.edge_top+3,w:225,h:17}})
            titledimage.Push({text:"), randomly.",textAttrs:{Color:"#ffffff",font:m.carouseldescriptionfont,HAlign:"Left"},targetRect:{x:m.sidebar_width+313,y:m.edge_top+3,w:253,h:17}})
        endif
        m.canvas.setLayer(16,titledimage)
end function

function main_force_section(section=places_section) as void
       'same as pressing the back button
       'With this the callback menu action is not triggered in the Main While
       'at the RunUserInterface otherwise the action is executed two times
            m.remoteIndex=0
       
       'Force to set the cursor focus to Main menu  
            m.menu.inMain=true
       'Takes inNews mode
            m.inNews=true
        'Display the section
            m.section.show(section)
        'Draw the line Reference in Main menu
            m.menu.drawLineReference()
            '
            m.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
end function

function main_reload_all_data() as void
        print m.getRegistry()
         wss="getTrial.php?device_id="+m.getRegistry()
         trialuser=m.http.getWs(wss)
         
         print trialuser
         if trialuser.trial=0
            m.wsString="device_id="+m.getRegistry()+"&name="+trialuser.name+"&email="+trialuser.email
         else
            m.myuser=m.store.GetPartialUserData("email, firstname")
            m.wsString="device_id="+m.getRegistry()+"&name="+m.myuser.firstname+"&email="+m.myuser.email
         endif
         
         ws="getUser.php?"+m.wsString
        user=m.http.getWs(ws)
                                                               
        if(type(user)<>"roInvalid")
                        
                m.userid=user.uid
                m.cuserid=user.uid
                m.favorites=user.favorites
                m.trial=user.trial
                'm.tos=user.tos
                if type(user.tos)="String" then
                    if user.tos="0" then
                        m.tos=false
                    else
                        m.tos=true
                    endif    
                else
                    if m.trial
                        m.tos=false
                    else
                        m.tos=user.tos
                    endif
                endif
                settings={
                            sleep_sound:user.settings.sleep_sound
                            shutoff_timer:user.settings.shutoff_timer.toint()
                            sleep_timer:user.settings.sleep_timer.toint()
                         }
               m.settings=settings
                         
               s_time=user.streaming_time
               s_time=s_time.toInt()
               if(s_time>0)m.timeover=false else m.timeover=true
                
        
        endif
        print "about to call goHome"
        m.goHome()
        
end function



function main_reload_data() as void
        ws="getUser.php?"+m.wsString
        user=m.http.getWs(ws)
                                                               
        if(type(user)<>"roInvalid")
                
                m.userid=user.uid
                m.cuserid=user.uid
                m.favorites=user.favorites
                m.trial=user.trial
                'm.tos=user.tos
                if type(user.tos)="String" then
                    if user.tos="0" then
                        m.tos=false
                    else
                        m.tos=true
                    endif    
                else
                    if m.trial
                        m.tos=false
                    else
                        m.tos=user.tos
                    endif
                endif
                settings={
                            sleep_sound:user.settings.sleep_sound
                            shutoff_timer:user.settings.shutoff_timer.toint()
                            sleep_timer:user.settings.sleep_timer.toint()
                         }
               m.settings=settings
                         
               s_time=user.streaming_time
               s_time=s_time.toInt()
               if(s_time>0)m.timeover=false else m.timeover=true
                
        
        endif
        m.goHome()
end function





function main_go_home() as void

       'items=[]
       'm.items=[]
       ''m.items.push({action:relaxnow_section,label:"Relax"})
       'm.items.push({action:customize_section,label:"Sleep"})
       'm.items.push({action:places_section,label:"Relax"})
       'm.items.push({action:customize_section,label:"Customize"})
       'm.items.push({action:information_section,label:"Information"})
       
      print m.trial
       'if m.trial then 
       '     m.items.push({action:subscribenow_section,label:"Subscribe Now"})
       '     print "pushed subscribe now button in"
       '     if m.tos=false
       '         print "inside here"
       '         m.isTrial()
       '     endif
        
      'endif            '
            
       m.remoteIndex=0
       'm.menu.inMain=true
       'm.inNews=false
       'Display the section
       'm.section.show(section)
       
       'm.menu.setOptions(m.items)
       'm.menu.position=0
       'm.menu.render(0)
       'm.menu.drawLineReference()
        
       'sm = sectionManager(m)
       'sm.show(sleep_section)
        
        m.section.show(sleep_section)
       
       'm.forceSection()
       
       'm.canvas.SetMessagePort(m.port)    
       'm.store.setMessagePort(m.port)
        
        'm.remoteListener=false
        m.canvas.clearLayer(107)
        m.canvas.clearLayer(108)
        m.canvas.clearLayer(109)
        m.canvas.clearLayer(110)
        m.canvas.clearLayer(111)
        m.canvas.clearLayer(112)
        m.canvas.clearLayer(113)
        print "end of goHome call"
        'm.audio.play("Ocean_Waves.wma","Ocean_Waves.wma") 
       'm.audio.play(m.settings.sleep_sound,"sleep.wma")
       'm.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
end function






function main_start_screensaver() as void

    m.sleeping=true
    m.startSleepTimer()

end function





function main_restart_global_sleep_timer() as void
    
    m.lastglobalsleeptimer=m.timer.TotalMilliseconds()+m.globalsleeptime

end function


function main_restart_global_screensaver_timer() as void
    
    m.globalscreensavertimer=m.timer.TotalMilliseconds()+m.staticscreensavertimer

end function


function main_start_sleep_timer() as void
    
    m.lastsleeptime=m.timer.GetMilliseconds()+m.sleeptime
    
    
end function







Function InitTheme() as void


app=createObject("roAppManager")

    listItemHighlight           = "#000000"
    listItemText                = "#ebebeb"
    brandingGray               = "#5E5F66"
    backgroundColor             = "#000000"
    lightgray="#333333"
    
    theme = {
        BackgroundColor: backgroundColor
        OverhangSliceHD: "pkg:/images/overhang.png"
        OverhangSliceSD: "pkg:/images/overhang.png"
        OverhangLogoHD: "pkg:/images/logo.png"
        OverhangLogoSD: "pkg:/images/logo.png"
        OverhangOffsetSD_X: "25"
        OverhangOffsetSD_Y: "15"
        OverhangOffsetHD_X: "25"
        OverhangOffsetHD_Y: "15"
        BreadcrumbTextLeft: brandingGray
        BreadcrumbTextRight: lightgray
        BreadcrumbDelimiter: brandingGray
        
        ListItemText: listItemText
        ListItemHighlightText: listItemHighlight
        ListScreenDescriptionText: listItemText
    '    ListItemHighlightHD: "pkg:/images/bgmenuitem.png"
    '    ListItemHighlightSD: "pkg:/images/bgmenuitem.png"
        CounterTextLeft: brandingGray
        CounterSeparator: brandingGray
        GridScreenBackgroundColor: backgroundColor
        GridScreenListNameColor: brandingGray
        GridScreenDescriptionTitleColor: brandingGray
        GridScreenLogoHD: "pkg:/images/logo.png"
        GridScreenLogoSD: "pkg:/images/logo.png"
        GridScreenOverhangHeightHD: "138"
        GridScreenOverhangHeightSD: "138"
        GridScreenOverhangSliceHD: "pkg:/images/hoverhang.png"
        GridScreenOverhangSliceSD: "pkg:/images/hoverhang.png"
        GridScreenLogoOffsetHD_X: "25"
        GridScreenLogoOffsetHD_Y: "15"
        GridScreenLogoOffsetSD_X: "25"
        GridScreenLogoOffsetSD_Y: "15"
    }


app.setTheme(theme)


End Function




function GetSecuence(start,total) as Object
    secuence=[]
    cont=0
    item=start
    last=total-1
        while(cont<total)
            secuence[cont]=item
            item=item+1
                if(item>last)
                item=0
                end if
        cont=cont+1
        end while
return secuence
End function


Function IsHD() As Boolean
    di = CreateObject("roDeviceInfo")
    if di.GetDisplayType() = "HDTV" then 
    return true
    End if
    return false
End Function






function fixVideoUrl(video_url) as string

        theurl=CreateObject("roString")
        regex=CreateObject("roRegex","\|+COMPONENT=HLS.m3u8","i")
        video_url=regex.replaceAll(video_url,"")
        regex=CreateObject("roRegex","\|+COMPONENT=HLS","i")
        video_url=regex.replaceAll(video_url,"")
        theurl.setString(video_url)   

        return theurl
end function


Function strReplace(basestr As String, oldsub As String, newsub As String) As String
    newstr = ""

    i = 1
    while i <= Len(basestr)
        x = Instr(i, basestr, oldsub)
        if x = 0 then
            newstr = newstr + Mid(basestr, i)
            exit while
        endif

        if x > i then
            newstr = newstr + Mid(basestr, i, x-i)
            i = x
        endif

        newstr = newstr + newsub
        i = i + Len(oldsub)
    end while

    return newstr
End Function



Function arraySearch(value,array) as integer


    total=array.count()
    counter=total-1
    
    index=-1
    for i=0 to counter
        if(array[i]=value)
                index=i
            exit for
        endif
    end for

return index
end function

'''''' function for user sign in if clicked the button already have an account '''''''
Function userSignIn(uid As integer) As Void
    print "id to sign in"
    print uid
    print "Sign In"
    token = m.getRegistry()
    if token<>invalid then
        print "Token: "+token
        user = m.http.getWs("searchUser.php?token="+token)
        if (user.id<>invalid and user.email<>invalid)
            print "user"
            print "id: "+user.id
            print "email: "+user.email
            wss="getTrial.php?device_id="+m.getRegistry()
            trialuser=m.http.getWs(wss)
            print "trialuser"
            print trialuser.name
            print trialuser.email
        else
            m.dialog.alert2("Error retrieving your user information, try restarting Ahhveo again. Thank you.")
            m.set_exit=true
        endif   
    endif
End Function


''''' function for user login '''''''''''''''''''''

Function userLogin() As Void
    'm.delRegistry()
    m.set_exit=invalid
    token = m.getRegistry()
    print "token before invalid check"
    print token
    if token<>invalid then
        print "Token: "+token
        user = m.http.getWs("searchUser.php?token="+token)
        print "user"
        print user
        print "user.id"
        print user.id
        print "user.email"
        print user.email
        if (user.id<>invalid and user.email<>invalid)
            print "id: "+user.id
            print "email: "+user.email
            wss="getTrial.php?device_id="+m.getRegistry()
            trialuser=m.http.getWs(wss)
            
            m.wsString="device_id="+m.getRegistry()+"&name="+trialuser.name+"&email="+trialuser.email
            
            if trialuser.trial=0 ' exists on db, is not trial
                m.trial=false
            else
                m.trial=true
            endif
            print "m.trial"
            print m.trial
        else
            m.dialog.alert2("Error retrieving your user information, try restarting Ahhveo again. Thank you.")
            m.set_exit=true
        endif        
    else
        token = m.http.getWs("getToken.php")
        if (type(token)<>"roInvalid")
            if (token.registrationToken<>"0")
                token = token.registrationToken
                print "Created a new token: "+token
                user = m.http.getWs("createTrialUser.php?token="+token) 
                print "email:"+user.email
                print "id: "+user.id
                if (type(user)<>"roInvalid")
                    m.setRegistry(token)
                    setUserData(user.email)
                    setUserName(user.name)
                    m.trial=true
                    m.wsString="device_id="+m.getRegistry()+"&name="+user.name+"&email="+user.email
                else
                    m.dialog.alert2("Error on Token creation, try starting Ahhveo Channel again. Thank you.")
                endif
            else
                m.dialog.alert2("Error on Token creation, try starting Ahhveo Channel again. Thank you.")
            endif
       else
            m.dialog.alert2("Error on Token creation, try starting Ahhveo Channel again. Thank you.")
       endif
    endif
    
    if(m.set_exit=invalid)
        ws="getUser.php?"+m.wsString
        user=m.http.getWs(ws)                           
        
        if(type(user)<>"roInvalid")
                        
            m.userid=user.uid
            m.cuserid=user.uid
            m.favorites=user.favorites
            m.trial=user.trial
            
            if type(user.tos)="String" then
                if user.tos="0" then
                    m.tos=false
                else
                    m.tos=true
                endif    
            else
                if m.trial
                    m.tos=false
                else
                    m.tos=user.tos
                endif
            endif
            
            settings={
                        sleep_sound:user.settings.sleep_sound
                        shutoff_timer:user.settings.shutoff_timer.toint()
                        sleep_timer:user.settings.sleep_timer.toint()
                     }
                   
           settingss=m.http.getWs("getSettings.php?user_id="+m.userid)
          
           m.settings=settings
           
           if settingss.sleep_sound="Ocean Waves" then
            'ocean
                m.sleepSound=1
           else if settingss.sleep_sound="Peaceful Frogs" then
            'frogs
                m.sleepSound=2
           else if settingss.sleep_sound="Summer Rain" then
            'rain
                m.sleepSound=3
           else if settingss.sleep_sound="Relaxing Crickets" then
            'crickets
                m.sleepSound=5
           else if settingss.sleep_sound="Chorus Frogs" then
            'crickets
                m.sleepSound=4
           else if settingss.sleep_sound="Sleepy Thunder" then
            'crickets
                m.sleepSound=0
           endif
                   
           s_time=user.streaming_time
           s_time=s_time.toInt()
           if(s_time>0)m.timeover=false else m.timeover=true
            
        endif
        
        m.canvas.show()        
        
        print "istrial: "
        print m.trial
        if m.trial then
            m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
            m.audio.player.stop()
            'm.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
            a = VideoSetup(m)
            a.setup()
            a.paint()
            a.eventloop()
            'm.items.push({action:subscribenow_section,label:"Subscribe Now"})
            m.menu.setOptions(m.items)
            sm=sectionManager(m)
            dlg=CreateDialog(m)
            
            m.section=sm
            m.dialog=dlg
            'm.inNews=true
            'm.menu.render(0)
            'm.menu.drawLineReference()
            'sm.show(home_section)
            if (m.app.ispreview = false)
                m.isTrial()
            endif
        else
            'm.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
        endif
         'm.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
        m.store.GetPurchases()
        m.restartGlobalSleepTimer()
        
    endif
End Function


'''''' functions for authentication ''''''

Function GetAuthData() As Dynamic
     sec = CreateObject("roRegistrySection", "Authentication")
     if sec.Exists("UserRegistrationToken") 
         return sec.Read("UserRegistrationToken")
     endif
     return invalid
End Function
  
Function SetAuthData(userToken As String) As Void
    sec = CreateObject("roRegistrySection", "Authentication")
    sec.Write("UserRegistrationToken", userToken)
    sec.Flush()
End Function

Function deleteAuthData() As Void
    sec = CreateObject("roRegistrySection", "Authentication")
     if sec.Exists("UserRegistrationToken") 
         sec.Delete("UserRegistrationToken")
     endif
End Function

''''''''' Functions for email '''''''''''''''

Function GetUserData() As Dynamic
     sec = CreateObject("roRegistrySection", "UserData")
     if sec.Exists("UserEmail") 
         return sec.Read("UserEmail")
     endif
     return invalid
End Function
  
Function SetUserData(userEmail As String) As Void
    sec = CreateObject("roRegistrySection", "UserData")
    sec.Write("UserEmail", userEmail)
    sec.Flush()
End Function

Function deleteUserData() As Void
    sec = CreateObject("roRegistrySection", "UserData")
     if sec.Exists("UserEmail") 
         sec.Delete("UserEmail")
     endif
End Function

Function GetUserName() As Dynamic
     sec = CreateObject("roRegistrySection", "UserName")
     if sec.Exists("UserFirstName") 
         return sec.Read("UserFirstName")
     endif
     return invalid
End Function
  
Function SetUserName(userName As String) As Void
    sec = CreateObject("roRegistrySection", "UserName")
    sec.Write("UserFirstName", userName)
    sec.Flush()
End Function

Function deleteUserName() As Void
    sec = CreateObject("roRegistrySection", "UserName")
     if sec.Exists("UserFirstName") 
         sec.Delete("UserFirstName")
     endif
End Function