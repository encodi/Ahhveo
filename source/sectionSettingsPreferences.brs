function settings_preferences(s) as object

    this={
          section:s
          remoteCallBack:settings_preferences_remote_callback
          init:settings_preferences_init
          canvas:s.canvas
          app:s.app
          remaining:60
          position:-1
          drawRing:settings_preferences_draw_ring
          changePicker:settings_preferences_change_picker
          setGlobalTime:settings_preferences_set_global_time
          toTime:settings_preferences_to_time
          enabled:false
          onReturn:settings_preferences_on_return
          section:false
          goBack:settings_preferences_go_back
          parent:false
          positions:[]
         }
         
        
return this    
end function



function settings_preferences_init(parent=false) as void

    m.parent=parent
    
    size=m.app.size
    sb_w=m.app.sidebar_width
    edge_top=m.app.edge_top
    center_x=sb_w+Fix((size.w-sb_w)/2)
    
    if (IsHD())
        margin_right=50
    else
        margin_right=28
    endif
    w_=(size.w-sb_w)-(margin_right*2)
    x_=sb_w+margin_right
    if (IsHD())
        y_=50+edge_top
    else
        y_=33+edge_top
    endif
    w_m=fix((size.w-sb_w)/2)
    
    items=[]
    
    positions=[]
    
    if (IsHD())
        header1_rect={x:x_,y:y_,w:w_,h:50}
        y_=y_+70
        positions.push({x:center_x-170,y:y_,w:w_m,h:50})
        positions.push({x:(sb_w+w_)-120,y:y_,w:120,h:50})
        
       
        buy_rect={w:300,h:50,x:center_x-150,y:y_}
        time_rect={y:y_,w:300,x:center_x+100,h:50}
        y_=y_+110
        text1_rect={y:y_-40,w:w_,x:x_,h:100}
        y_=y_+150
        header2_rect={x:x_,y:y_,w:w_,h:60}
        header2_rect2={x:x_,y:y_-90,w:w_,h:60}
        y_=y_+80
        picker_rect={x:sb_w+(Fix((size.w-sb_w)/2)-148),y:y_,w:300,h:50}
        picker_rect2={x:sb_w+(Fix((size.w-sb_w)/2)-148),y:y_-130,w:300,h:50}
        
        positions.push({x:center_x-92,y:y_+2,w:100,h:50})
        
        y_=y_+20
        text2_rect={y:y_,w:w_,x:x_,h:100}
        y_=y_+100
        remain_rect={y:y_,x:x_,w:w_,h:50}
    
        w_m=fix((size.w-sb_w)/2)
        timeremain_rect={y:y_,x:x_+20,w:w_m,h:50}
        positions.push(timeremain_rect)
        device_rect={y:y_,x:(center_x-m.app.edge_left),w:w_m,h:50}
        header0_rect={x:x_,y:y_+55,w:w_,h:50}
        positions.push({x:(sb_w+w_)-490,y:y_-248,w:120,h:50})
    else
        header1_rect={x:x_,y:y_,w:w_,h:33}
        y_=y_+47
        positions.push({x:center_x-96,y:y_,w:w_m,h:33})
        positions.push({x:(sb_w+w_)-34,y:y_,w:34,h:33})
        
       
        buy_rect={w:169,h:33,x:center_x-78,y:y_}
        time_rect={y:y_,w:169,x:center_x+56,h:33}
        y_=y_+73
        text1_rect={y:y_-20,w:w_,x:x_,h:67}
        y_=y_+100
        header2_rect={x:x_,y:y_,w:w_,h:40}
        header2_rect2={x:x_,y:y_,w:w_,h:40}
        y_=y_+53
        picker_rect={x:sb_w+(Fix((size.w-sb_w)/2)-83),y:y_,w:169,h:33}
        picker_rect2={x:sb_w+(Fix((size.w-sb_w)/2)-83),y:y_,w:169,h:33}
        positions.push({x:center_x-43,y:y_+11,w:40,h:15}) ' < time > text position
        
        y_=y_+13
        text2_rect={y:y_,w:w_,x:x_,h:67}
        y_=y_+67
        remain_rect={y:y_,x:x_,w:w_,h:33}
    
        w_m=fix((size.w-sb_w)/2)
        timeremain_rect={y:y_,x:x_+11,w:w_m,h:33}
        positions.push(timeremain_rect)
        device_rect={y:y_,x:(center_x-m.app.edge_left),w:w_m,h:33}
        header0_rect={x:x_,y:y_+30,w:w_,h:33}
        positions.push({x:(sb_w+w_)-400,y:y_-250,w:120,h:50})
    endif
    
    if m.app.trial then
        items.push({text:"Welcome to Ahhveo!",textAttrs:{font:m.app.h3},targetRect:header1_rect})
    else
        items.push({text:"Thank you for subscribing to Ahhveo!",textAttrs:{font:m.app.h3},targetRect:header1_rect})
    endif
    items.push({url:"pkg:/images/rect.png",targetRect:header1_rect})
    items.push({text:"Buy additional time",textAttrs:{font:m.app.h3},targetRect:buy_rect})
 '   items.push({text:"Subscribe",textAttrs:{font:m.app.h3,HAlign:"right"},targetRect:time_rect})
    items.push({text:"You may purchase additional streaming time at the rate of $1.99 USD for 12 hours. Purchased time will be added to any remaining streaming time available this period as displayed in the lower left corner of this page.  Unused streaming time included with your subscription and unused purchased streaming time must be used in the current subscription period or the following subscription period.",
                textAttrs:{font:m.app.h4,HAlign:"left"},
                targetRect:text1_rect})
      
    items.push({text:"Set a timer to turn off Ahhveo streaming automatically",textAttrs:{font:m.app.h3},targetRect:header2_rect})
    items.push({url:"pkg:/images/rect.png",targetRect:header2_rect})
    items.push({text:"<        > hours",textAttrs:{font:m.app.h2},targetRect:picker_rect})
    
    items.push({text:"THIS SETTING GOVERNS ALL DEVICES ON ACCOUNT",
                textAttrs:{font:m.app.h4},
               targetRect:text2_rect})
    
    'GLOBAL TIMER
    items.Push({text:"Chose the amount of time you want each video to play.", textAttrs:{font:m.app.h3},targetRect:header2_rect2})
    items.push({text:"<        > mins",textAttrs:{font:m.app.h2},targetRect:picker_rect2})
    
    items.push({url:"pkg:/images/rect.png",targetRect:remain_rect})
    items.push({text:"Token:"+m.app.getRegistry(),textAttrs:{HAlign:"Right",font:m.app.h3},targetRect:device_rect})
    items.push({text:"Build version: "+m.app.appInfo.GetVersion(),textAttrs:{font:m.app.h4},targetRect:header0_rect})
    settings=m.app.http.getWs("getSettings.php?user_id="+m.app.userid)
    
    
    if(type(settings)<>"roInvalid")
        m.shutoff_timer=settings.shutoff_timer
        m.start_shutoff_timer=m.shutoff_timer
        m.automatic_charge=settings.automatic_charge
        m.start_automatic_charge=m.automatic_charge
        m.available_time=settings.available_time
        m.app.globalvideotimer = settings.global_timer
    endif
    
   

'    txtautocharge="Disabled"
 '   if(m.automatic_charge="1")txtautocharge="Enabled"    
 '   autocharge={text:txtautocharge,targetRect:positions[1]}
    
    
    shutoff_timer=settings.shutoff_timer
    shutoff_timer=shutoff_timer.toInt()
    
    integer_hours=shutoff_timer/3600000
    integer_hours=Str(integer_hours)
    
    minutes=m.app.globalvideotimer.toInt()/60000
    

    timer={text:integer_hours,textAttrs:{font:m.app.h2},targetRect:positions[2]}
    globaltimer = {text:Str(minutes),textAttrs:{font:m.app.h2},targetRect:positions[4]}
   
    available_hours=m.toTime(settings.available_time)
    
    if m.app.trial
        available_hours = m.toTime(m.app.globaltrialtime.tostr())
    endif
    
    time_remain={text:"Time remaining: "+available_hours+" hours",textAttrs:{HAlign:"Left",font:m.app.h3},targetRect:timeremain_rect}
    
    m.positions=positions
    
    m.canvas.setLayer(1,items)
  '  m.canvas.setLayer(51,autocharge)
    m.canvas.setLayer(52,timer)
    m.canvas.setLayer(55, globaltimer)
    m.canvas.setLayer(53,time_remain)
    
    if(m.app.menu.inMain=false)m.drawring()
    
    dr = m.app.http.getWs("logState.php?userID="+m.app.getRegistry()+"&leftAt=settings")
    
    m.positions = positions
end function



function settings_preferences_to_time(t) as string

    available_time=t.toInt() 
    'Convert the available time to hours
    'And Fix for take only the ours
    integer_hours=Fix(available_time/3600000)
    available_hours=integer_hours.toStr()

    'Getting the minutes
    minutes=available_time/3600000
    minutes=minutes-integer_hours
    minutes=Fix(minutes*60)
    if minutes<10 
        zeroleft="0"    
    else 
        zeroleft=""
    endif
    minutes=Stri(minutes).trim()
    
    str_hour=available_hours+":"+zeroleft+""+minutes
    
    return str_hour

end function




function settings_preferences_draw_ring() as void
    'print "position"
    'print m.position
    'First time not enabled
    if(m.position=-1) 
        m.position=0
        m.drawRing()
        return
    endif
    t=m.positions[m.position]
    h_=2
    if IsHD()
        y_=t.y+41
    else
        y_=t.y+25
    endif
    x_=t.x
    ring_color="#ffFFCC00"
    if IsHD()
        if(m.position=0)
            w_=250
            x_=t.x+41
            ring_color="#ffFFCC00"
        else if m.position=1
            w_=190
            x_=t.x-370
            y_=y_+210
        else if m.position=2
            w_=190
            x_=t.x
        endif
    else
        if(m.position=0)
            w_=141
            x_=t.x+29
            ring_color="#ffFFCC00"
        else if m.position=1
            w_=68
        else if m.position=2
            w_=120
            x_=t.x-14
            y_=t.y+16
        endif
    endif
    
    trgt={x:x_,y:y_,w:w_,h:h_}
    m.canvas.setLayer(54,{color:ring_color,targetRect:trgt})

end function


function settings_preferences_hide_ring() as void
    
    m.canvas.clearLayer(54)
    m.canvas.clearLayer(55)

end function

Function settings_preferences_set_global_time(index) as void
    gtimer = m.app.globalvideotimer.toInt()
    gtimer = gtimer/60000
    
    if (index=4)
        if (gtimer>1) 
            gtimer = gtimer-1
        endif
    else if (index=5)
        if (gtimer<50)
            gtimer = gtimer+1
        endif
    end if
    
    globaltimer = {text:Str(gtimer),textAttrs:{font:m.app.h2},targetRect:m.positions[4]}
    m.canvas.setLayer(55, globaltimer)
    
    gtimer = gtimer*60000
    m.app.globalvideotimer = Str(gtimer)
End Function


function settings_preferences_change_picker(index) as void
                
        timer=m.shutoff_timer.toInt()        
        
        
        mintimer=900000
        interval=1800000
        minutes=1800000
        maxtimer=50400000

        'Left Remote
        if(index=4)
            if(timer=(mintimer*2) or timer=mintimer)minutes=mintimer
            if(timer>mintimer)timer=timer-minutes
        'Right Remote
        else if index=5
            if(timer=mintimer)minutes=mintimer
            if(timer<maxtimer)timer=timer+minutes
            if(timer=(mintimer*2))minutes=interval
        end if

        integer_hours=timer/3600000
        f=Str(integer_hours)
        
        m.shutoff_timer=timer.toStr()
        integer_hours=Str(integer_hours)
    

        timer={text:integer_hours,textAttrs:{font:m.app.h2},targetRect:m.positions[2]}
        'timer={text:f,targetRect:m.positions[2]}
        m.canvas.setLayer(52,timer)
end function




function settings_preferences_remote_callback(index) as void


    'Do anything when in main
    if m.app.menu.inMain return
        
    'Handle right left buttons
    if(index=4 or index=5)

    
            'Handle picker
            if(m.position=2)
                 m.changePicker(index)
                 return
            endif
            
            if (m.position=1)
                m.setGlobalTime(index)
                return
            end if

            if(index=4)
                if(m.position=0)
                    m.goBack()
                    return
                endif
            endif

          'Handle Up and Down Buttons
     else if(index=2 or index=3)
    
            
            if(index=2)
                
                    if(m.position=0)
                        m.goBack()
                        return
                    else
                        if (m.position=2) 
                            m.position=1
                        else if (m.position=1) 
                            m.position=0
                        endif
                    endif
                    
           else if(index=3)
                if (m.position=0) then
                    m.position=1
                else if (m.position=1) then
                    m.position=2
                endif
                
           endif
           
          
    else if(index=6)

         'Subscription Function
        if(m.position=1)

             return

        
        '    charge={text:txt,targetRect:m.positions[1]}
        '    m.canvas.setLayer(51,charge)
        
        
        'Handle additional time purchase
        else if m.position=0

            'Trial users not enables to purchase
            if(m.app.trial)
                ws="getPopup.php?id=12"
                        popup=m.app.http.getWs(ws)
                
                        r=m.app.dialog.confirm2(popup[0].content,[popup[0].option_1,popup[0].option_2])
                if r then
                      'ws="getPopup.php?id=1"
                      'popup=m.app.http.getWs(ws)
                      'r2=m.app.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
                      '  options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                      'if r2=2
                      '  m.app.subscribe(3)
                     ' else if r2=1
                      '  m.app.subscribe(2)
                      'else
                      '  m.app.subscribe(1)
                      'endif
                      m.app.istrial()   
                    'm.app.store.ClearOrder()
                    'order=[{code:"S12HR",qty:1}]
                    'currentOrder = m.app.store.SetOrder(order)  ' id del producto en la tienda a comprar
                    'purchase = m.app.store.DoOrder()
                
                endif
            
                return
            else 
                    
                    
        
             if(m.app.dialog.confirm("You may purchase additional streaming time at the rate of $1.99 for 7 hours. Confirm your additional time purchase"))            
                    
                    userid=m.app.userid.trim()
                    ws="buyAdditionalTime.php?user_id="+userid
                    
                    order=[{code:"ahhveoadditionaltime",qty:1}]
                    currentOrder = m.app.store.SetOrder(order)  ' id del producto en la tienda a comprar
                   
                    m.app.dialog.process("Please wait...")
                    purchase = m.app.store.DoOrder()
                    m.app.dialog.stopProcess()
                    
                    if purchase
                                m.app.dialog.process("Please wait...")
                                addt=m.app.http.getWs(ws)
            '                    ws="paytime.php?user_id="+userid
            '                    addt=m.app.http.getPPWs(ws)
                                
                                m.app.dialog.stopProcess()
                                
                                if(type(addt)<>"roInvalid")
                                    if(addt.done="1")
                                    
                                         m.app.dialog.alert("Purchase completed for 7 additional hours of streaming time. Thank You!")     
                                         addtxt=m.toTime(addt.time_available.toStr())
                                         m.app.consumed=false
                                         time_remain={text:"Time remaining: "+addtxt+" hours",textAttrs:{HAlign:"Left",font:m.app.h3},targetRect:m.positions[3]}
                                         m.canvas.setLayer(53,time_remain)                                         
                                         m.app.timeover = false
                                         
                                    endif
                                endif
                    else
                      
                    endif 'end if Purchase
                    
             endif
                            
            endif
        
        
        
        end if


    end if


m.drawRing()

end function



function settings_preferences_on_return(index) as boolean

        m.canvas.clearLayer(54)
        m.canvas.clearLayer(55)
        'Do not anything when in main
         if m.app.menu.inMain return true
            'Getting start and final values from settings
            shutoff_st=m.start_shutoff_timer
            shutoff=m.shutoff_timer
            charge_st=m.start_automatic_charge
            charge=m.automatic_charge
            
        if (m.app.trial and (charge<>charge_st or shutoff<>shutoff_st)) then
                            ws="getPopup.php?id=12"
                        popup=m.app.http.getWs(ws)
                
                        r=m.app.dialog.confirm2(popup[0].content,[popup[0].option_1,popup[0].option_2])
            'r=m.app.dialog.confirm2("Subscribe and enjoy more!",["Subscribe Now","Keep exploring"])
                
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
                        m.shutoff_timer=m.start_shutoff_timer
                        m.automatic_charge=m.start_automatic_charge
                        
                            
                            integer_hours=m.shutoff_timer.toInt()/3600000
                            f=Str(integer_hours)
                            integer_hours=Str(integer_hours)
    

                            timer={text:integer_hours,textAttrs:{font:m.app.h2},targetRect:m.positions[2]}
                            'timer={text:f,targetRect:m.positions[2]}                        
                       '     txtcharge="Disabled"
                        '    if(m.automatic_charge="1")txtcharge="Enabled"
                      '      charge={text:txtcharge,targetRect:m.positions[1]}
                        m.canvas.setLayer(52,timer)
                        m.canvas.setLayer(51,charge)  
                endif
            
                return true
                
        else
            
        
            'Determine if there are changes to save or no
           
            
            if(charge<>charge_st or shutoff<>shutoff_st)
                
                  confirm=m.app.dialog.confirm("Save changes?",["Yes","No"])
                  if(confirm)
                        userid=m.app.userid
                        
                        ws="setSettings.php?user_id="+userid+"&settings%5Bshutoff_timer%5D="+shutoff+"&settings%5Bautomatic_charge%5D="+charge
                        r=m.app.http.getWs(ws)
                        
                        if(type(r)<>"roInvalid")
                            if(r.done=1) 
                                m.app.settings.shutoff_timer=shutoff.toInt()
                                return true
                            else 
                                return false
                            endif
                        
                        endif
                  else
                  
                        'Reset to the original values
                        m.shutoff_timer=m.start_shutoff_timer
                        m.automatic_charge=m.start_automatic_charge
                        
                            
                            integer_hours=m.shutoff_timer.toInt()/3600000
                            f=Str(integer_hours)
                            integer_hours=Str(integer_hours)
    

                            timer={text:integer_hours,textAttrs:{font:m.app.h2},targetRect:m.positions[2]}
                            'timer={text:f,targetRect:m.positions[2]}                        
                       '     txtcharge="Disabled"
                        '    if(m.automatic_charge="1")txtcharge="Enabled"
                      '      charge={text:txtcharge,targetRect:m.positions[1]}
                        m.canvas.setLayer(52,timer)
                        m.canvas.setLayer(51,charge)
                  
                  endif
                  
                  return true
                            
            endif
           
        endif
    st=m.start_shuttime_off

    return true
end function



function settings_preferences_go_back() as void

        m.app.remoteIndex=0
        m.parent.remoteCallback(7)
        m.canvas.clearLayer(54)
        
end function



