

function CreateDialog(app) as object


'With this pseudo-class, you can
'Shows a f, Optional, Alert and Process Dialogs

this={  
        confirm:show_confirm_dialog
        confirmbuy:show_buy_confirm_dialog
        confirmbuy2:show_buy_confirm_dialog2
        confirm2:show_confirm_dialog2
        removeDialog:remove_dialog
        alert:show_alert_dialog
        alert2:show_alert_dialog2
        subpop:show_new_subscription_popup
        app:app
        canvas:app.canvas
        port:app.port
        response:false
        optional:show_option_dialog
        optional2:show_option_dialog2
        optional3:show_option_dialog3
        optional15:show_option_dialog15
        process:show_process_dialog
        stopProcess:hide_process_dialog
        alertRequire:alert_require
        showsleepalarmdialog:show_sleep_alarm_dialog
        position:0
     }


return this

end function



function show_option_dialog(v) as integer

    
    msg=v.text
    options=v.options
    
    position=0
    default=2
    if(type(v.default)="roInteger")
        position=v.default
        default=v.default
    endif    
    ' Size of dialog is 566 x 327
    if (IsHD())
         w_=566
         h_=327
         'Option rect sizes
         option_w=188
         option_h=75
     else
         w_=318
         h_=218
         'Option rect sizes
         option_w=106
         option_h=50
     endif
     x_=Fix(m.app.size.w/2)-Fix(w_/2)
     y_=Fix(m.app.size.h/2)-Fix(h_/2)
    
    
     
     dialog={url:"pkg:/images/options.png",targetRect:{x:x_,y:y_,w:w_,h:h_}}
    
    if (IsHD())
        txt={text:msg,textAttrs:{font:m.app.h3,VAlign:"center"},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_+25}}
    else
        txt={text:msg,textAttrs:{font:m.app.h3,VAlign:"center"},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+17}}
    endif
    
    positions=[]
    textoptions=[]

    if (IsHD())
        f=m.app.fonts.GetDefaultFont(25,false,false)
    else    
        f=m.app.fonts.GetDefaultFont(17,false,false)
    endif
    
    txt_height=f.getOneLineHeight()

    
    cont=0
    for each i in options
    
        txt_width=f.getOneLineWidth(options[cont],10000)
        base_x=x_+(cont*option_w)
        
        txt_x=base_x+((Fix(option_w/2)-Fix(txt_width/2)))
        
        if (IsHD())
            rect={w:txt_width,h:txt_height,x:txt_x,y:(y_+h_)-55}
        else
            rect={w:txt_width,h:txt_height,x:txt_x,y:(y_+h_)-37}
        endif
        positions.push(rect)
        textoptions.push({text:options[cont],textAttrs:{HAlign:"center",font:m.app.h4},targetRect:rect})
    
        cont=cont+1
    endfor
    
    if (IsHD())
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:positions[position].w,h:2,x:positions[position].x,y:positions[position].y+28}}
    else
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:positions[position].w-20,h:2,x:positions[position].x+12,y:positions[position].y+19}}
    endif
    
    m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(109,txt)
    m.canvas.setLayer(111,textoptions)
    m.canvas.setLayer(112,ring)
    
     while true
        msg = wait(240, m.port)
        if msg <> invalid
                
            if msg.isRemoteKeyPressed()
                 index=msg.getIndex()
                    print "Dialog"
                    print index
                    print "------"
                'Move Left or right
                if(index=4 or index=5)


                    total=options.count()-1
                    if (index=4)
                        position=position-1
                        if(position<0)position=total
                    else if (index=5)
                       position=position+1
                       if(position>total)position=0      
                    endif
                                                          
                    if (IsHD())
                        newx = 0
                        neww = 0
                        'if position=0
                        '    newx = 15
                        '    neww = 20
                        'endif
                        'if position=1
                        '    newx = 20
                        '    neww = 15
                        'endif
                        'if position=2
                        '    newx = 10
                        '    neww = 5
                        'endif
                        ring.targetRect={w:positions[position].w-neww,h:2,x:positions[position].x+newx,y:positions[position].y+25}
                    else
                        newx = 0
                        neww = 0
                        if position=0
                            newx = 12
                            neww = 20
                        endif
                        if position=1
                            newx = 20
                            neww = 40
                        endif
                        if position=2
                            newx = 10
                            neww = 16
                        endif
                        ring.targetRect={w:positions[position].w-neww,h:2,x:positions[position].x+newx,y:positions[position].y+19}
                    endif
                   m.canvas.setLayer(112,ring)
                else if(index=6)
                    m.removeDialog()
                    exit while
                
                else if(index=0 or index=7 or index=10)                 
                    position=-1
                    m.removeDialog()
                    exit while
                                
                endif
                
                
        
            endif
        
        
        end if
     end while   
    
    
        
    return position

end function

function show_option_dialog15(v) as integer

    
    msg=v.text
    options=v.options
    
    position=0
    default=2
    if(type(v.default)="roInteger")
        position=v.default
        default=v.default
    endif    
    ' Size of dialog is 566 x 327
     if (IsHD())
         w_=566
         h_=327
         'Option rect sizes
         option_w=188
         option_h=75
     else
         w_=318
         h_=218
         'Option rect sizes
         option_w=106
         option_h=50
     endif
     x_=Fix(m.app.size.w/2)-Fix(w_/2)
     y_=Fix(m.app.size.h/2)-Fix(h_/2)
    
    
     
     dialog={url:"pkg:/images/options.png",targetRect:{x:x_,y:y_,w:w_,h:h_}}
    
    if (IsHD())
        txt={text:msg,textAttrs:{font:m.app.h3,VAlign:"center"},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_+25}}
    else
        txt={text:msg,textAttrs:{font:m.app.h3,VAlign:"center"},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+17}}
    endif
     
    positions=[]
    textoptions=[]
    
    if (IsHD())
        f=m.app.fonts.GetDefaultFont(25,false,false)
    else
        f=m.app.fonts.GetDefaultFont(17,false,false)
    endif
    
    txt_height=f.getOneLineHeight()

    
    cont=0
    for each i in options
    
        txt_width=f.getOneLineWidth(options[cont],10000)
        base_x=x_+(cont*option_w)
        
        txt_x=base_x+((Fix(option_w/2)-Fix(txt_width/2)))
        
        if (IsHD())
            rect={w:txt_width,h:txt_height,x:txt_x,y:(y_+h_)-55}
            rect15={w:txt_width,h:txt_height,x:txt_x,y:(y_+h_)-65}
        else
            rect={w:txt_width,h:txt_height,x:txt_x,y:(y_+h_)-31}
            rect15={w:txt_width,h:txt_height,x:txt_x,y:(y_+h_)-43}
        endif
        positions.push(rect)
        
        if cont=1 or cont=2 
            textoptions.push({text:"View",textAttrs:{HAlign:"center",font:m.app.h4},targetRect:rect15})
            if (IsHD())
                rect={w:txt_width,h:txt_height,x:txt_x,y:(y_+h_)-45}
            else
                rect={w:txt_width,h:txt_height,x:txt_x,y:(y_+h_)-30}
            endif 
        endif
        textoptions.push({text:options[cont],textAttrs:{HAlign:"center",font:m.app.h4},targetRect:rect})
    
        cont=cont+1
    endfor
    
    if (IsHD())
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:positions[position].w,h:2,x:positions[position].x,y:positions[position].y+28}}
    else
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:positions[position].w,h:2,x:positions[position].x,y:positions[position].y+19}}
    endif
    
    m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(109,txt)
    m.canvas.setLayer(111,textoptions)
    m.canvas.setLayer(112,ring)

     while true
        msg = wait(250, m.port)
        if msg <> invalid
                
            if msg.isRemoteKeyPressed()
                 index=msg.getIndex()
            
                'Move Left or right
                if(index=4 or index=5)


                    total=options.count()-1
                    if(index=4)
                        position=position-1
                        if(position<0)position=total
                    else                       
                       position=position+1
                       if(position>total)position=0                        
                    endif
                    neww=0
                   if position=1 or position=2
                    if (IsHD())
                        posi = 32
                        neww=10
                        newxpos=5
                    else
                        posi = 21
                        neww=50
                        newxpos=25
                    endif                    
                   else 
                    if (IsHD())
                        posi = 25
                        neww = 0
                        newxpos=0
                    else
                        posi = 17
                        neww = 8
                        newxpos=3
                    endif
                   endif
                   ring.targetRect={w:positions[position].w-neww,h:2,x:positions[position].x+newxpos,y:positions[position].y+posi}
                   m.canvas.setLayer(112,ring)
                                    
                else if(index=6)
                    m.removeDialog()
                    exit while
                
                else if(index=0 or index=7 or index=10)                 
                    position=-1
                    m.removeDialog()
                    exit while
                                
                endif
                
                
        
            endif
        
        
        end if
     end while   
    
    
        
    return position

end function

function show_option_dialog2(v, t="") as integer

    titl=t
    msg=v.text
    msg2=v.text2
    msg3=v.text3
    msg4=v.text4
    options=v.options
    isDown=0
    
    ws="getPopup.php?id=1"
    popup=m.app.http.getWs(ws)

    dr = m.app.http.getWs("logState.php?userID="+m.app.getRegistry()+"&leftAt=subscription_popup_1")
    
    isPreviewSelected=popup[0].event_1
    
    position=0
    default=2
    if(type(v.default)="roInteger")
        position=v.default
        default=v.default
    endif    
    ' Size of dialog is 566 x 327
    if (IsHD())
         w_=566
         h_=380
         'Option rect sizes
         option_w=188
         option_h=75
     else
         w_=318
         h_=253
         'Option rect sizes
         option_w=106
         option_h=50
     endif
     x_=Fix(m.app.size.w/2)-Fix(w_/2)
     y_=Fix(m.app.size.h/2)-Fix(h_/2)
    
    txtarray=[]
    imgarray=[]
    
     dialog={url:"pkg:/images/options2.png",targetRect:{x:x_,y:y_,w:w_,h:h_}}
    
    if (IsHD())
        ttxt={text:titl,textAttrs:{font:m.app.h2,VAlign:"center"},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_-30}}
        
        imgstar1={url:"pkg:/images/relaxnow_small_star.png",targetRect:{x:x_+27,y:y_+123,w:15,h:12}}
        imgstar2={url:"pkg:/images/relaxnow_small_star.png",targetRect:{x:x_+5,y:y_+280,w:15,h:12}}
        txt={text:msg,textAttrs:{font:m.app.h45},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_-87,y:y_+39}}
        txt2={text:msg2,textAttrs:{font:m.app.h45},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_,y:y_+75}}
        txt3={text:msg3,textAttrs:{font:m.app.h45},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_-20,y:y_+100}}
        txt45={text:msg4,textAttrs:{font:m.app.h45},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_-165,y:y_+142}}
        imgarrow={url:"pkg:/images/back_asterisk.png",targetRect:{x:x_+434,y:y_+228,w:18,h:15}}
        txt4={text:"Press     to preview.",textAttrs:{font:m.app.h45,VAlign:"center"},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+190,y:y_+142}}
        txt5={text:"Existing Ahhveo subscribers click here",textAttrs:{font:m.app.h45,color:"#CCCCCC"},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_,y:y_+260}}
    else
        ttxt={text:titl,textAttrs:{font:m.app.h2,VAlign:"center"},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+7,y:y_-20}}
        
        imgstar1={url:"pkg:/images/relaxnow_small_star.png",targetRect:{x:x_+15,y:y_+82,w:8,h:8}}
        imgstar2={url:"pkg:/images/relaxnow_small_star.png",targetRect:{x:x_+5,y:y_+190,w:8,h:8}}
        txt={text:msg,textAttrs:{font:m.app.h45},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_-49,y:y_+26}}
        txt2={text:msg2,textAttrs:{font:m.app.h45},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_,y:y_+53}}
        txt3={text:msg3,textAttrs:{font:m.app.h45},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_-11,y:y_+67}}
        txt45={text:msg4,textAttrs:{font:m.app.h45},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_-93,y:y_+93}}
        imgarrow={url:"pkg:/images/back_asterisk.png",targetRect:{x:x_+244,y:y_+152,w:10,h:10}}
        txt4={text:"Press     to preview.",textAttrs:{font:m.app.h45,VAlign:"center"},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+107,y:y_+93}}
        txt5={text:"Existing Ahhveo subscribers click here",textAttrs:{font:m.app.h45,color:"#CCCCCC"},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_,y:y_+173}}
    endif
    txtarray.Push(txt)
    txtarray.Push(txt2)
    txtarray.Push(txt3)
    if (isPreviewSelected="1")
        txtarray.Push(txt4)
        imgarray.Push(imgarrow)
    else
        'nothing
    endif
    imgarray.Push(imgstar1)
    imgarray.Push(imgstar2)
    txtarray.Push(txt45)
    txtarray.Push(ttxt)
    txtarray.Push(txt5)
    
    positions=[]
    textoptions=[]

    f=m.app.fonts.GetDefaultFont(25,false,false)
    
    txt_height=f.getOneLineHeight()

    
    cont=0
    for each i in options
    
        txt_width=f.getOneLineWidth(options[cont],10000)
        base_x=x_+(cont*option_w)
        
        txt_x=base_x+((Fix(option_w/2)-Fix(txt_width/2)))
        
        if (IsHD())
             rect={w:txt_width,h:txt_height,x:txt_x,y:(y_+h_)-105}
        else
             rect={w:txt_width,h:txt_height,x:txt_x,y:(y_+h_)-70}
            'if cont=0
            '    rect={w:txt_width,h:txt_height,x:txt_x+10,y:(y_+h_)-37}
            'else if (cont=1)
            '    rect={w:txt_width,h:txt_height,x:txt_x+20,y:(y_+h_)-37}
            'else
            '    rect={w:txt_width,h:txt_height,x:txt_x+30,y:(y_+h_)-37}
            'endif
        endif
        
        
        positions.push(rect)
        textoptions.push({text:options[cont],textAttrs:{HAlign:"center",font:m.app.h4},targetRect:rect})
    
        cont=cont+1
    endfor
    
    if (IsHD())
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:positions[position].w-6,h:2,x:positions[position].x+1,y:positions[position].y+28}}
    else
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:positions[position].w-130,h:2,x:positions[position].x+65,y:positions[position].y+18}}
    endif
    
    m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(109,txtarray)
    m.canvas.setLayer(113,imgarray)
    m.canvas.setLayer(111,textoptions)
    m.canvas.setLayer(112,ring)
    
     while true
        msg = wait(250, m.port)
        if msg <> invalid
                
            if msg.isRemoteKeyPressed()
                index=msg.getIndex()
                print index
                'Move Left or right
                if(index=4 or index=5)


                    total=options.count()-1
                    if(index=4)
                        position=position-1
                        if(position<0)position=total
                    else                       
                       position=position+1
                       if(position>total)position=0                        
                    endif
                    if (IsHD())
                        neww=1
                        newx=1
                        if position=2 newx=8
                        if position=2 neww=17
                        ring.targetRect={w:positions[position].w-neww,h:2,x:positions[position].x+newx,y:positions[position].y+25}
                    else
                        newx=65
                        if position=2 newx=63
                        ring.targetRect={w:positions[position].w-130,h:2,x:positions[position].x+newx,y:positions[position].y+18}
                    endif
                   m.canvas.setLayer(112,ring)
                
                else if(index=3)
                    isDown=1
                    position=3
                    if IsHD()
                        ring.targetRect={w:297,h:2,x:x_+125,y:y_+365}
                    else
                       ring.targetRect={w:162,h:2,x:x_+71,y:y_+243} 
                    endif
                    m.canvas.setLayer(112,ring)
                else if(index=2)
                    if isDown=1
                        isDown=0
                        position=0
                        if (IsHD())
                            neww=1
                            newx=1
                            if position=2 newx=8
                            if position=2 neww=17
                            ring.targetRect={w:positions[position].w-neww,h:2,x:positions[position].x+newx,y:positions[position].y+25}
                        else
                            newx=65
                            if position=2 newx=63
                            ring.targetRect={w:positions[position].w-130,h:2,x:positions[position].x+newx,y:positions[position].y+18}
                        endif
                        m.canvas.setLayer(112,ring)
                    endif
                else if(index=6)
                    if IsDown=1
                        'LOGIN
                        m.removeDialog()
                        m.alertRequire("Please select share on the next screen. We use your email to see if you already have an Ahhveo account. ")'Non Subscriber emails will not be shared or used for marketing purposes.
                        myuser=m.app.store.GetPartialUserData("email, firstname")
                        if myuser<>invalid
                            'TODO change this for serach user data, not update, we are login the user not creating his account
                            ws_update="searchEmail.php?email="+myuser.email
                            'searchUsers
                            ws_update_response = m.app.http.getWs(ws_update)
                            if (type(ws_update_response)<>"roInvalid") then
                                if ws_update_response.email=myuser.email
                                    print "user exists"
                                    userid=m.app.userid.trim()
                                    ws_update_link="updateTokenUser.php?user_id="+userid+"&email="+myuser.email+"&firstname="+myuser.firstname+"&device_id="+m.app.getRegistry()
                                    ws_update_link_response = m.app.http.getWs(ws_update_link)        
                                    if (type(ws_update_link_response)<>"roInvalid") then
                                        print ws_update_link_response
                                        'update view
                                        '#Change to new view (sleep or relax selectable from webservice)
                                        m.app.trial=false
                                        m.app.tos=true
                                        m.app.timeover=false
                                        ' need a way to reload data
                                        print "is this broken?"
                                        m.removeDialog()
                                        m.app.reloadAllData()
                                        
                                        exit while                                       
                                        'm.app.userLogin()
                                    else
                                        print "user does not exist yet"
                                        m.app.trial=false
                                        m.app.tos=true
                                        m.app.timeover=false
                                        m.app.userLogin()
                                    endif
                                    
                                else
                                    print "user does not exist"
                                    'm.app.trial=false
                                    'm.app.tos=true
                                    'm.app.timeover=false
                                    m.alertRequire("You do not have an Ahhveo account registered with this e-mail yet, please subscribe and enjoy.")
                                    'position=-1
                                    m.removeDialog()
                                    m.app.isTrial()
                                    exit while                                    
                                endif
                            else
                                print "Error on updating the user."
                                m.app.istrial()
                            endif 
                        else
                            m.app.istrial()
                        endif
                    else
                        m.removeDialog()
                        wsr="logCounterSubscribe.php?user_id="+m.app.userid+"&where_from=1"
                        sr=m.app.http.getWs(wsr)
                        exit while
                    endif
                else if(index=10)            'index=0 or index=7 or      
                    position=-1
                    m.removeDialog()
                    exit while
                                
                endif
                
                
        
            endif
        
        
        end if
     end while   
    
    
        
    return position

end function


function show_option_dialog3(v, t="") as integer

    titl=t
    msg1=v.text1
    msg2=v.text2
    options=v.options
    
    position=0
    default=2
    if(type(v.default)="roInteger")
        position=v.default
        default=v.default
    endif    
    ' Size of dialog is 566 x 327
     if (IsHD())
         w_=566
         h_=327
         'Option rect sizes
         option_w=188
         option_h=75
     else
         w_=318
         h_=218
         'Option rect sizes
         option_w=106
         option_h=50
     endif
     x_=Fix(m.app.size.w/2)-Fix(w_/2)
     y_=Fix(m.app.size.h/2)-Fix(h_/2)
    
    txtarray=[]
    ringarray=[]
     
     dialog={url:"pkg:/images/options.png",targetRect:{x:x_,y:y_,w:w_,h:h_}}
    
    if (IsHD())
        ring2={url:"pkg:/images/ringdialog2.png",targetRect:{w:100,h:2,x:x_+340,y:y_+145}}
        
        ttxt={text:titl,textAttrs:{font:m.app.h2,VAlign:"center"},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_-20}}
        txt1={text:msg1,textAttrs:{font:m.app.h4,VAlign:"center"},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_+40}}
        txt2={text:msg2,textAttrs:{font:m.app.h4,VAlign:"center"},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_+100}}
    else
        ring2={url:"pkg:/images/ringdialog2.png",targetRect:{w:56,h:2,x:x_+180,y:y_+97}}
        
        ttxt={text:titl,textAttrs:{font:m.app.h2,VAlign:"center"},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_-13}}
        txt1={text:msg1,textAttrs:{font:m.app.h4,VAlign:"center"},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+27}}
        txt2={text:msg2,textAttrs:{font:m.app.h4,VAlign:"center"},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+67}}
    endif
    txtarray.Push(ttxt)
    txtarray.Push(txt1)
    txtarray.Push(txt2)  
    txtarray.Push(ring2)  
    
    positions=[]
    textoptions=[]

    f=m.app.fonts.GetDefaultFont(25,false,false)
    
    txt_height=f.getOneLineHeight()

    
    cont=0
    for each i in options
    
        txt_width=f.getOneLineWidth(options[cont],10000)
        base_x=x_+(cont*option_w)
        
        txt_x=base_x+((Fix(option_w/2)-Fix(txt_width/2)))
        
        if (IsHD())
             rect={w:txt_width,h:txt_height,x:txt_x,y:(y_+h_)-55}
        else
             rect={w:txt_width,h:txt_height,x:txt_x,y:(y_+h_)-37}
        endif
        positions.push(rect)
        textoptions.push({text:options[cont],textAttrs:{HAlign:"center",font:m.app.h4},targetRect:rect})
    
        cont=cont+1
    endfor
    
    if (IsHD())
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:positions[position].w,h:2,x:positions[position].x,y:positions[position].y+28}}
    else
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:positions[position].w-60,h:2,x:positions[position].x+30,y:positions[position].y+21}}
    endif
    
    'ringarray.push(ring2)
    ringarray.push(ring)
    
    m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(109,txtarray)
    m.canvas.setLayer(111,textoptions)
    m.canvas.setLayer(112,ringarray)

     while true
        msg = wait(250, m.port)
        if msg <> invalid
                
            if msg.isRemoteKeyPressed()
                 index=msg.getIndex()
                
                'Move Left or right
                if(index=4 or index=5)


                    total=options.count()-1
                    if(index=4)
                        position=position-1
                        if(position<0)position=total
                    else                       
                       position=position+1
                       if(position>total)position=0                        
                    endif
                   
                    if (IsHD())
                        ring.targetRect={w:positions[position].w,h:2,x:positions[position].x,y:positions[position].y+25}
                    else
                        neww=60
                        newx=30
                        if position=2 then 
                            neww=10
                            newx=7
                        endif
                        ring.targetRect={w:positions[position].w-neww,h:2,x:positions[position].x+newx,y:positions[position].y+19}
                    endif
                   m.canvas.setLayer(112,ring)
                                    
                else if(index=6)
                    m.removeDialog()
                    exit while
                
                else if(index=0 or index=7 or index=10)                
                    position=-1
                    m.removeDialog()
                    exit while
                                
                endif
                
                
        
            endif
        
        
        end if
     end while   
    
    
        
    return position

end function

function show_buy_confirm_dialog(msg="Confirm your additional time purchase.",options=["Yes","Cancel"]) as boolean
   
   txt1 = msg
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
        txt={text:txt1,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_+10}}
    else
        txt={text:txt1,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+7}}
    endif
    
    positions=[]
    if (IsHD())
        positions[0]={w:30,h:25,x:(x_+100),y:(y_+h_)-55}
        positions[1]={w:30,h:25,x:(x_+w_)-120,y:(y_+h_)-55}
    else
        positions[0]={w:17,h:17,x:(x_+56),y:(y_+h_)-37}
        positions[1]={w:17,h:17,x:(x_+w_)-80,y:(y_+h_)-37}
    endif
    
    yes={text:options[0],textAttrs:{HAlign:"center",font:m.app.titlefont},targetRect:positions[0]}
    no={text:options[1],textAttrs:{HAlign:"center",font:m.app.titlefont},targetRect:positions[1]}
    if (IsHD())
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:52,h:2,x:positions[1].x-10,y:positions[1].y+28}}
    else
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:29,h:2,x:positions[1].x-6,y:positions[1].y+19}}
    endif
    
    m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(109,txt)
    m.canvas.setLayer(110,yes)
    m.canvas.setLayer(111,no)
    m.canvas.setLayer(112,ring)

     while true
        msg = wait(250, m.port)
        if msg <> invalid
                
            if msg.isRemoteKeyPressed()
                 index=msg.getIndex()
            
                'Move Left or right
                if(index=4 or index=5)
                       
                    response=m.response                    
                    if(response)
                        response=false
                        ringposition=1                       
                     else
                        response=true
                        ringposition=0
                    endif
                        
                  m.response=response                
                    if (IsHD())
                        ring.targetRect={x:positions[ringposition].x-10,y:positions[ringposition].y+28,w:52,h:2}
                   else
                        ring.targetRect={x:positions[ringposition].x-6,y:positions[ringposition].y+19,w:29,h:2}
                   endif
                   m.canvas.setLayer(112,ring)
                                    
                else if(index=6)                    
                    m.removeDialog()
                    exit while
                
                 else if(index=0 or index=7 or index=10)   
                    
                    m.response=false
                    m.removeDialog()
                    exit while
                                
                endif
                
                
        
            endif
        
        
        end if
     end while   
        
    return m.response

end function

function show_buy_confirm_dialog2(msg="You have used up all your hours of streaming included in this month's subscription. Please purchase more streaming time in Settings/Preferences to continue viewing.",options=["Purchase","Cancel"]) as boolean
   
   txt1 = msg
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
        txt={text:txt1,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_+10}}
    else
        txt={text:txt1,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+7}}
    endif
    
    positions=[]
    if (IsHD())
        positions[0]={w:30,h:25,x:(x_+100),y:(y_+h_)-53}
        positions[1]={w:30,h:25,x:(x_+w_)-120,y:(y_+h_)-53}
    else
        positions[0]={w:17,h:17,x:(x_+56),y:(y_+h_)-35}
        positions[1]={w:17,h:17,x:(x_+w_)-68,y:(y_+h_)-35}
    endif
    yes={text:options[0],textAttrs:{HAlign:"center",font:m.app.titlefont},targetRect:positions[0]}
    no={text:options[1],textAttrs:{HAlign:"center",font:m.app.titlefont},targetRect:positions[1]}
    
    if (IsHD())
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:52,h:2,x:positions[1].x-10,y:positions[1].y+28}}
    else
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:29,h:2,x:positions[1].x-6,y:positions[1].y+19}}
    endif
    m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(109,txt)
    m.canvas.setLayer(110,yes)
    m.canvas.setLayer(111,no)
    m.canvas.setLayer(112,ring)

     while true
        msg = wait(250, m.port)
        if msg <> invalid
                
            if msg.isRemoteKeyPressed()
                 index=msg.getIndex()
            
                'Move Left or right
                if(index=4 or index=5)
                       
                    response=m.response                    
                    if(response)
                        response=false
                        ringposition=1                       
                     else
                        response=true
                        ringposition=0
                    endif
                        
                  m.response=response                
                   
                   if (IsHD())                 
                        ring.targetRect={x:positions[ringposition].x-10,y:positions[ringposition].y+28,w:52,h:2}
                   else
                        ring.targetRect={x:positions[ringposition].x-6,y:positions[ringposition].y+19,w:29,h:2}
                   endif
                   
                   m.canvas.setLayer(112,ring)
                                    
                else if(index=6)                    
                    m.removeDialog()
                    exit while
                
                else if(index=0 or index=7 or index=10) 
                    
                    m.response=false
                    m.removeDialog()
                    exit while
                                
                endif
                
                
        
            endif
        
        
        end if
     end while   

    return m.response

end function



function show_confirm_dialog(msg,options=["Yes","Cancel"]) as boolean
   
   txt1 = msg
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
        txt={text:txt1,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_+10}}
    else
        txt={text:txt1,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+7}}
    endif
    
    positions=[]
    
    if (IsHD())
        positions[0]={w:30,h:25,x:(x_+100),y:(y_+h_)-55}
        positions[1]={w:30,h:25,x:(x_+w_)-120,y:(y_+h_)-55}
    else
        positions[0]={w:17,h:17,x:(x_+56)-10,y:(y_+h_)-37}
        positions[1]={w:17,h:17,x:(x_+w_)-75,y:(y_+h_)-37}
    endif
    
    yes={text:options[0],textAttrs:{HAlign:"center",font:m.app.titlefont},targetRect:positions[0]}
    no={text:options[1],textAttrs:{HAlign:"center",font:m.app.titlefont},targetRect:positions[1]}
    
    if (IsHD())
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:52,h:2,x:positions[1].x-10,y:positions[1].y+28}}
    else
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:60,h:2,x:positions[1].x-20,y:positions[1].y+19}}
    endif
    
    m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(109,txt)
    m.canvas.setLayer(110,yes)
    m.canvas.setLayer(111,no)
    m.canvas.setLayer(112,ring)

     while true
        msg = wait(250, m.port)
        if msg <> invalid
                
            if msg.isRemoteKeyPressed()
                 index=msg.getIndex()
            
                'Move Left or right
                if(index=4 or index=5)
                       
                    response=m.response                    
                    if(response)
                        response=false
                        ringposition=1                       
                     else
                        response=true
                        ringposition=0
                    endif
                        
                  m.response=response                
                                    
                    if (IsHD())
                        ring.targetRect={x:positions[ringposition].x-10,y:positions[ringposition].y+28,w:52,h:2}
                    else
                        ring.targetRect={x:positions[ringposition].x-20,y:positions[ringposition].y+19,w:60,h:2}
                    endif
                   
                   m.canvas.setLayer(112,ring)
                                    
                else if(index=6)                    
                    m.removeDialog()
                    exit while
                
                else if(index=0 or index=7 or index=10) 
                    
                    m.response=false
                    m.removeDialog()
                    exit while
                                
                endif
                
                
        
            endif
        
        
        end if
     end while   

    return m.response

end function

function show_sleep_alarm_dialog(msg,options=["Yes","Cancel"]) as boolean
   
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
    
    positions=[]
    
    if (IsHD())
        positions[0]={w:200,h:25,x:(x_+10),y:(y_+h_)-50}
        positions[1]={w:200,h:25,x:x_+230,y:(y_+h_)-50}
    else
        positions[0]={w:113,h:17,x:(x_+6),y:(y_+h_)-33}
        positions[1]={w:113,h:17,x:x_+129,y:(y_+h_)-33}
    endif
    
    yes={text:options[0],textAttrs:{HAlign:"center",font:m.app.menufont},targetRect:positions[0]}
    no={text:options[1],textAttrs:{HAlign:"center",font:m.app.menufont},targetRect:positions[1]}
    
    if (IsHD())
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:200,h:2,x:positions[1].x,y:positions[1].y+28}}
    else
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:113,h:2,x:positions[1].x,y:positions[1].y+19}}
    endif
    
    m.canvas.setLayer(990,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(991,dialog)
    m.canvas.setLayer(992,txt)
    m.canvas.setLayer(993,yes)
    m.canvas.setLayer(994,no)
    m.canvas.setLayer(995,ring)

     while true
        msg = wait(250, m.port)
        if msg <> invalid
                
            if msg.isRemoteKeyPressed()
                 index=msg.getIndex()
            
                'Move Left or right
                if(index=4 or index=5)
                       
                    response=m.response                    
                    if(response)
                        response=false
                        ringposition=1                       
                     else
                        response=true
                        ringposition=0
                    endif
                        
                  m.response=response                
                    
                    if (IsHD())
                        ring.targetRect={x:positions[ringposition].x,y:positions[ringposition].y+28,w:positions[ringposition].w,h:2}
                    else
                        ring.targetRect={x:positions[ringposition].x,y:positions[ringposition].y+19,w:positions[ringposition].w,h:2}
                    endif
                   
                   m.canvas.setLayer(995,ring)
                                    
                else if(index=6)                    
                    m.removeDialog()
                    exit while
                
                else if(index=0 or index=7 or index=10) 
                
                    m.response=false
                    m.removeDialog()
                    exit while
                                
                endif
                
                
        
            endif
        
        
        end if
     end while   
        
    return m.response

end function

function show_confirm_dialog2(msg,options=["Yes","Cancel"]) as boolean
   
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
        txt={text:msg,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_+40}}
    else
        txt={text:msg,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+22}}
    endif
    
    positions=[]
    
    if (IsHD())
        positions[0]={w:200,h:25,x:(x_+10),y:(y_+h_)-50}
        positions[1]={w:200,h:25,x:x_+230,y:(y_+h_)-50}
    else
        positions[0]={w:113,h:17,x:(x_+6),y:(y_+h_)-33}
        positions[1]={w:113,h:17,x:x_+129,y:(y_+h_)-33}
    endif
    
    yes={text:options[0],textAttrs:{HAlign:"center",font:m.app.menufont},targetRect:positions[0]}
    no={text:options[1],textAttrs:{HAlign:"center",font:m.app.menufont},targetRect:positions[1]}
    
    if (IsHD())
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:200,h:2,x:positions[1].x,y:positions[1].y+28}}
    else
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:113,h:2,x:positions[1].x,y:positions[1].y+19}}
    endif
    
    'm.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(109,txt)
    m.canvas.setLayer(110,yes)
    m.canvas.setLayer(111,no)
    m.canvas.setLayer(112,ring)

     while true
        msg = wait(250, m.port)
        if msg <> invalid
                
            if msg.isRemoteKeyPressed()
                 index=msg.getIndex()
            
                'Move Left or right
                if(index=4 or index=5)
                       
                    response=m.response                    
                    if(response)
                        response=false
                        ringposition=1                       
                     else
                        response=true
                        ringposition=0
                    endif
                        
                  m.response=response                
                    
                    if (IsHD())
                        ring.targetRect={x:positions[ringposition].x,y:positions[ringposition].y+28,w:positions[ringposition].w,h:2}
                    else
                        ring.targetRect={x:positions[ringposition].x,y:positions[ringposition].y+19,w:positions[ringposition].w,h:2}
                    endif
                   
                   m.canvas.setLayer(112,ring)
                                    
                else if(index=6)                    
                    m.removeDialog()
                    exit while
                
                else if(index=0 or index=7 or index=10) 
                
                    m.response=false
                    m.removeDialog()
                    exit while
                                
                endif
                
                
        
            endif
        
        
        end if
     end while   
        
    return m.response

end function

function show_new_subscription_popup() as integer
    
    ringposition = 0
    posreturn = 0
    isDown=0
    txt = []
    
    ws="getPopup.php?id=13"
    popup=m.app.http.getWs(ws)
    isPreviewSelected = popup[0].event_1
    
    if (IsHD())
         w_=600
         h_=300
         x_=Fix(m.app.size.w/2)-221
         y_=Fix(m.app.size.h/2)-123
    else
         w_=300
         h_=200
         x_=Fix(m.app.size.w/2)-124
         y_=Fix(m.app.size.h/2)-89
    endif
    
    dialog={url:"pkg:/images/alert2.png",targetRect:{x:x_,y:y_-20,w:w_,h:h_+40}}
    
    'msg = "Monthly subscription price is $3.99 for 25 hours streaming."
    msg = popup[0].content
    msg2 = popup[0].content_2
    'msg2 = "First month free, cancel anytime."
        
    if (IsHD())
        txt.push({text:msg,textAttrs:{font:m.app.h2},targetRect:{w:w_-120,h:h_-Fix(h_/2),x:x_+65,y:y_-15}})
        txt.push({text:msg2,textAttrs:{font:m.app.h45},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+15,y:y_+105}})
    else
        txt.push({text:msg,textAttrs:{font:m.app.h2},targetRect:{w:w_-40,h:h_-Fix(h_/2),x:x_+15,y:y_-15}})
        txt.push({text:msg2,textAttrs:{font:m.app.h5},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+55}})
    endif
    
    positions=[]
    
    if (IsHD())
        positions[0]={w:320,h:25,x:x_+145,y:(y_+h_)-170}
        positions[1]={w:460,h:25,x:x_+70,y:(y_+h_)-80}
    else
        positions[0]={w:180,h:17,x:x_+70,y:(y_+h_)-120}
        positions[1]={w:210,h:17,x:x_+35,y:(y_+h_)-60}
    endif
    
    if (IsHD())
        yesring = {url:"pkg:/images/ringdialog_B_inactive-1.png",targetRect:{w:positions[0].w-50,h:50,x:positions[0].x+30,y:positions[0].y-20}}
        noring = {url:"pkg:/images/ringdialog_B_inactive-1.png",targetRect:{w:positions[1].w,h:50,x:positions[1].x+5,y:positions[1].y-10}}
    else
        yesring = {url:"pkg:/images/ringdialog_B_inactive-1.png",targetRect:{w:positions[0].w-50,h:30,x:positions[0].x+15,y:positions[0].y-10}}
        noring = {url:"pkg:/images/ringdialog_B_inactive-1.png",targetRect:{w:positions[1].w+60,h:30,x:positions[1].x-20,y:positions[1].y-10}}
    endif
    
    if (IsHD())
        yes={text:popup[0].option_1,textAttrs:{HAlign:"center",font:m.app.carouseldescriptionfont},targetRect:{w:320,h:25,x:x_+150,y:(y_+h_)-175}}
        no={text:popup[0].option_2,textAttrs:{HAlign:"center",font:m.app.carouseldescriptionfont},targetRect:{w:460,h:25,x:x_+75,y:(y_+h_)-75}}
    else
        yes={text:popup[0].option_1,textAttrs:{HAlign:"center",font:m.app.carouseldescriptionfont},targetRect:{w:180,h:17,x:x_+60,y:(y_+h_)-120}}
        no={text:popup[0].option_2,textAttrs:{HAlign:"center",font:m.app.carouseldescriptionfont},targetRect:{w:245,h:17,x:x_+25,y:(y_+h_)-60}}
    endif
    
    if (IsHD())
        if (posreturn=0)
            ring={url:"pkg:/images/ringdialog_B_active-1.png",targetRect:{w:positions[ringposition].w-50,h:50,x:positions[ringposition].x+30,y:positions[ringposition].y-20}}
        else
            ring={url:"pkg:/images/ringdialog_B_active-1.png",targetRect:{w:positions[ringposition].w,h:50,x:positions[ringposition].x+5,y:positions[ringposition].y-10}}
        endif
    else
        if (posreturn=0)
           ring={url:"pkg:/images/ringdialog_B_active-1.png",targetRect:{w:positions[ringposition].w-50,h:30,x:positions[ringposition].x+15,y:positions[ringposition].y-10}}
        else
            ring={url:"pkg:/images/ringdialog_B_active-1.png",targetRect:{w:positions[ringposition].w+10,h:30,x:positions[ringposition].x-5,y:positions[ringposition].y-10}}
        endif
    endif
    
    if (isPreviewSelected="1")
        if (IsHD())
            imgarrow={url:"pkg:/images/back_asterisk.png",targetRect:{x:x_+481,y:y_+272,w:10,h:10}}
            txt4={text:"Press   to preview.",textAttrs:{font:m.app.h5,VAlign:"center"},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+210,y:y_+205}}
        else
            imgarrow={url:"pkg:/images/back_asterisk.png",targetRect:{x:x_+230,y:y_+h_-25,w:8,h:8}}
            txt4={text:"Press   to preview.",textAttrs:{font:m.app.h5,VAlign:"center"},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+100,y:y_+h_-70}}
        endif
        m.canvas.setLayer(119, imgarrow)
        m.canvas.setLayer(120, txt4)
    end if
    
    m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(116,txt)
    m.canvas.setLayer(117,yes)
    m.canvas.setLayer(118,no)
    m.canvas.setLayer(112,yesring)
    m.canvas.setLayer(114,noring)
    m.canvas.setLayer(115,ring)
    
     while true
        event = wait(250, m.port)
        if event <> invalid
            if event.isRemoteKeyPressed()
                index=event.getIndex()
                print index
                'Move up down
                if(index=2 or index=3)
                    if (isDown=1)
                        posreturn = 0
                        isDown=0
                        ringposition=0
                    else if (isDown=0)
                        posreturn = 1
                        isDown=1
                        ringposition=1
                    endif
                    
                    if (IsHD())
                        if (posreturn=0)
                            ring.targetRect={x:positions[ringposition].x+30,y:positions[ringposition].y-20,w:positions[ringposition].w-50,h:50}
                        else
                            ring.targetRect={x:positions[ringposition].x+5,y:positions[ringposition].y-10,w:positions[ringposition].w,h:50}
                        endif
                    else
                        if posreturn=0
                            ring.targetRect={x:positions[ringposition].x+15,y:positions[ringposition].y-10,w:positions[ringposition].w-50,h:30}
                        else
                            ring.targetRect={x:positions[ringposition].x-20,y:positions[ringposition].y-10,w:positions[ringposition].w+60,h:30}
                        endif
                    endif
                   
                   m.canvas.setLayer(115,ring)
                                    
                else if(index=6)   
                print isDown                 
                    if isDown=1
                        'LOGIN
                        m.removeDialog()
                        m.alertRequire("Please select share on the next screen. We use your email to see if you already have an Ahhveo account. ")'Non Subscriber emails will not be shared or used for marketing purposes.
                        myuser=m.app.store.GetPartialUserData("email, firstname")
                        if myuser<>invalid
                            'TODO change this for serach user data, not update, we are login the user not creating his account
                            ws_update="searchEmail.php?email="+myuser.email
                            'searchUsers
                            ws_update_response = m.app.http.getWs(ws_update)
                            if (type(ws_update_response)<>"roInvalid") then
                                if ws_update_response.email=myuser.email
                                    print "user exists"
                                    userid=m.app.userid.trim()
                                    ws_update_link="updateTokenUser.php?user_id="+userid+"&email="+myuser.email+"&firstname="+myuser.firstname+"&device_id="+m.app.getRegistry()
                                    ws_update_link_response = m.app.http.getWs(ws_update_link)        
                                    if (type(ws_update_link_response)<>"roInvalid") then
                                        print ws_update_link_response
                                        'update view
                                        '#Change to webservice to call sleep or relax as first sscreen view
                                        m.app.trial=false
                                        m.app.tos=true
                                        m.app.timeover=false
                                        ' need a way to reload data
                                        print "is this broken new sub?"
                                        m.removeDialog()
                                        m.app.reloadAllData()
                                        exit while           
                                        'm.app.userLogin()
                                    else
                                        print "user does not exist yet"
                                        m.app.trial=false
                                        m.app.tos=true
                                        m.app.timeover=false
                                        m.app.userLogin()
                                    endif
                                    
                                else
                                    print "user does not exist"
                                    'm.app.trial=false
                                    'm.app.tos=true
                                    'm.app.timeover=false
                                    m.alertRequire("You do not have an Ahhveo account registered with this e-mail yet, please subscribe and enjoy.")
                                    'position=-1
                                    m.removeDialog()
                                    m.app.isTrial()
                                    exit while                                    
                                endif
                            else
                                print "Error on updating the user."
                                m.app.istrial()
                            endif 
                        else
                            print "myuser is invalid"
                            m.app.istrial()
                        endif
                    else
                        print "out of isdown 1"
                        m.removeDialog()
                        wsr="logCounterSubscribe.php?user_id="+m.app.userid+"&where_from=1"
                        sr=m.app.http.getWs(wsr)
                        exit while
                    endif
                
                else if(index=10)            'index=0 or index=7 or      
                    position=-1
                    posreturn=-1
                    m.removeDialog()
                    exit while
                                
                endif
                
            end if                                
        endif
     end while   
        
    return posreturn
    
end function

function show_alert_dialog(msg) as void

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
    
     
     dialog={url:"pkg:/images/alert.png",targetRect:{x:x_,y:y_,w:w_,h:h_}}
    
    if (ISHD())
        txt={text:msg,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_+10}}
    else
        txt={text:msg,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+7}}
    endif
    
    positions=[]
    if (IsHD())
        positions[0]={w:30,h:25,x:(x_+221-15),y:(y_+h_)-55}
    else
        positions[0]={w:17,h:17,x:(x_+124-8),y:(y_+h_)-37}
    endif
    
    yes={text:"Ok",textAttrs:{HAlign:"center",font:m.app.titlefont},targetRect:positions[0]}
    
    if (IsHD())
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:52,h:2,x:positions[0].x-10,y:positions[0].y+28}}
    else
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:29,h:2,x:positions[0].x-6,y:positions[0].y+19}}
    endif
    
    m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(109,txt)
    m.canvas.setLayer(110,yes)
    m.canvas.setLayer(112,ring)

     while true
            event = wait(250, m.port)
            if event <> invalid
            
                     if type(event) = "roChannelStoreEvent" then
                
                        if event.IsRequestSucceeded() then
                            response= event.GetResponse()

                        else if event.IsRequestFailed() then
                            print "channel store req failed: ";event.GetStatusMessage()
                        end if 
            
            
                    else if event.isRemoteKeyPressed()
                        index=event.getIndex()
                        if(index=6)
                            m.removeDialog()
                            exit while
                        endif
                    endif
            endif
     end while
        
end function


function show_alert_dialog2(msg) as void

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
    
     
     dialog={url:"pkg:/images/alert.png",targetRect:{x:x_,y:y_,w:w_,h:h_}}
    
    if (IsHD())
        txt={text:msg,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_+10}}
    else
        txt={text:msg,textAttrs:{font:m.app.carouseldescriptionfont},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+7}}
    endif
    
    positions=[]
    if (IsHD())
        positions[0]={w:30,h:25,x:(x_+221-15),y:(y_+h_)-55}
    else
        positions[0]={w:17,h:17,x:(x_+124-8),y:(y_+h_)-37}
    endif
    
    yes={text:"Ok",textAttrs:{HAlign:"center",font:m.app.titlefont},targetRect:positions[0]}
    
    if (IsHD())
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:52,h:2,x:positions[0].x-10,y:positions[0].y+28}}
    else
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:32,h:2,x:positions[0].x-6,y:positions[0].y+19}}
    endif
    
    m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(109,txt)
    m.canvas.setLayer(110,yes)
    m.canvas.setLayer(112,ring)

     while true
            event = wait(250, m.port)
            if event <> invalid
            
                     if type(event) = "roChannelStoreEvent" then
                
                        if event.IsRequestSucceeded() then
                            response= event.GetResponse()

                        else if event.IsRequestFailed() then
                            print "channel store req failed: "+event.GetStatusMessage()
                        end if 
            
            
                    else if event.isRemoteKeyPressed()
                        index=event.getIndex()
                        if(index=6)
                            m.removeDialog()
                            m.app.isTrial()
                            exit while
                            return
                        endif
                    endif
            endif
     end while
        
end function

function alert_require(msg) as void

    ' Size of dialog is 442 x 269
   if (IsHD())
         w_=500
         h_=300
         x_=Fix(m.app.size.w/2)-221
         y_=Fix(m.app.size.h/2)-134
    else
         w_=249
         h_=179
         x_=Fix(m.app.size.w/2)-124
         y_=Fix(m.app.size.h/2)-89
    endif
    
     
     dialog={url:"pkg:/images/alert.png",targetRect:{x:x_,y:y_,w:w_,h:h_}}
    
    if (ISHD())
        txt={text:msg,textAttrs:{font:m.app.h2},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+10,y:y_+10}}
    else
        txt={text:msg,textAttrs:{font:m.app.h2},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+6,y:y_+7}}
    endif
    
    positions=[]
    if (IsHD())
        positions[0]={w:30,h:25,x:(x_+225),y:(y_+h_)-55}
    else
        positions[0]={w:17,h:17,x:(x_+124-8),y:(y_+h_)-37}
    endif
    
    yes={text:"Ok",textAttrs:{HAlign:"center",font:m.app.titlefont},targetRect:positions[0]}
    
    if (IsHD())
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:52,h:2,x:positions[0].x-10,y:positions[0].y+28}}
    else
        ring={url:"pkg:/images/ringdialog2.png",targetRect:{w:29,h:2,x:positions[0].x-6,y:positions[0].y+19}}
    endif
    
    m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(109,txt)
    m.canvas.setLayer(110,yes)
    m.canvas.setLayer(112,ring)

     while true
            event = wait(250, m.port)
            if event <> invalid
            
                     if type(event) = "roChannelStoreEvent" then
                
                        if event.IsRequestSucceeded() then
                            response= event.GetResponse()

                        else if event.IsRequestFailed() then
                            print "channel store req failed: ";event.GetStatusMessage()
                        end if 
            
            
                    else if event.isRemoteKeyPressed()
                        index=event.getIndex()
                        if(index=6)
                            m.removeDialog()
                            exit while
                        endif
                    endif
            endif
     end while
        
end function

function show_process_dialog(msg) as void

    ' Size of dialog is 442 x 269
    if (IsHD())
         w_=442
         h_=195
         x_=Fix(m.app.size.w/2)-180
         y_=Fix(m.app.size.h/2)-98
    else
         w_=249
         h_=130
         x_=Fix(m.app.size.w/2)-101
         y_=Fix(m.app.size.h/2)-65
    endif
     
     dialog={url:"pkg:/images/process.png",targetRect:{x:x_,y:y_,w:w_,h:h_}}
    
    if (IsHD())
        txt={text:msg,textAttrs:{HAlign:"left",font:m.app.carouseldescriptionfont},targetRect:{w:w_-20,h:h_-Fix(h_/2),x:x_+130,y:y_+50}}
    else
        txt={text:msg,textAttrs:{HAlign:"left",font:m.app.carouseldescriptionfont},targetRect:{w:w_-11,h:h_-Fix(h_/2),x:x_+73,y:y_+33}}
    endif
    
    positions=[]
    if (IsHD())
        positions[0]={w:30,h:25,x:(x_+100),y:(y_+h_)-55}
    else
        positions[0]={w:17,h:17,x:(x_+56),y:(y_+h_)-37}
    endif
        
    m.canvas.clearLayer(110)
    m.canvas.clearLayer(111)
    m.canvas.clearLayer(112)
    m.canvas.clearLayer(113)
    
    m.canvas.setLayer(107,{ Color: "#a0000000", CompositionMode: "Source_Over" })
    m.canvas.setLayer(108,dialog)
    m.canvas.setLayer(109,txt)


 
        
end function



function hide_process_dialog() as void

    m.canvas.clearLayer(107)
    m.canvas.clearLayer(108)
    m.canvas.clearLayer(109)
    m.canvas.clearLayer(113)

end function




function remove_dialog() as void

    m.position=0
    m.canvas.clearLayer(107)
    m.canvas.clearLayer(108)
    m.canvas.clearLayer(109)
    m.canvas.clearLayer(110)
    m.canvas.clearLayer(111)
    m.canvas.clearLayer(112)
    m.canvas.clearLayer(113)
    m.canvas.clearLayer(114)
    m.canvas.clearLayer(115)
    m.canvas.clearLayer(116)
    m.canvas.clearLayer(117)
    m.canvas.clearLayer(118)
    m.canvas.clearLayer(119)
    m.canvas.clearLayer(120)
    m.canvas.clearLayer(990)
    m.canvas.clearLayer(991)
    m.canvas.clearLayer(992)
    m.canvas.clearLayer(993)
    m.canvas.clearLayer(994)
    m.canvas.clearLayer(995)
    'm.app.goHome()
    
end function



