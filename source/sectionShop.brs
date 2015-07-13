function shop_section(s) as void


      this={
            parent:s
            onCarouselLocked:shop_on_carousel_locked
            beforeLevelAction:shop_before_level_action
            onOverflowTop:shop_on_overflow_top
            onOverflowBottom:shop_on_overflow_bottom
            onLastLevel:shop_on_last_level
            onBlurLastLevel:shop_on_blur_last_level
            onEmpty:shop_on_empty
            onSelect:shop_on_select
            onScroll:shop_on_scroll
            onCategorySelect:shop_on_category_select
            lock_carousel:false
            inbottom:false
            position:1
            bottom_position:0
            setSelected:shop_set_selected
            drawRing:shop_draw_ring
            drawBottomRing:shop_draw_bottom_ring
            hideRing:shop_hide_ring
            hideBottomRing:shop_hide_bottom_ring
            app:s.app
            canvas:s.app.canvas
            creating:false
            loadIndividuals:shop_load_individuals
            loadPackages:shop_load_packages
            resetCarousel:shop_reset_carousel
            ispackage:false
            purchase:shop_purchase
            showMessage:carousel_show_message
            hideMessage:carousel_hide_message
           }
    
    'Instantiate a Pseudo Class roCarousel
    if IsHD()
        carousel=NewCarousel({
            app:s.app,
            canvas:s.canvas,
            itemstyle:{w:288,h:170,margin:15,padding:15}
            section:this
            levels:0
            })
    else
        carousel=NewCarousel({
            app:s.app,
            canvas:s.canvas,
            itemstyle:{w:162,h:113,margin:10,padding:10}
            section:this
            levels:0
            })
    endif
    'Associate the handler for Main event propagation
    s.app.remoteListener=carousel
    s.app.player.playerListener=carousel
    'Sets the first Level Items
    
    this.roCarousel=carousel
    
    shop_menu=[]
    
    
    sb_w=s.app.sidebar_width
    screen_w=s.app.size.w-sb_w
    
    if IsHD()
        shopl_x=sb_w+Fix(screen_w/2)-225
    else
        shopl_x=sb_w+Fix(screen_w/2)-127
    endif
    
    if IsHD()
        play_y=30
        positions=[{x:this.app.sidebar_width+78,y:this.app.edge_top,w:39,h:32},
               {w:150,h:25,x:shopl_x,y:play_y},
               {w:150,h:25,x:shopl_x+250,y:play_y}
               ]
    else
        play_y=20
        positions=[{x:this.app.sidebar_width+44,y:this.app.edge_top,w:22,h:21},
               {w:84,h:17,x:shopl_x,y:play_y},
               {w:84,h:17,x:shopl_x+141,y:play_y}
               ]
    endif


    shop_menu.Push({url:"pkg:/images/back.png",textAttrs:{color:"#eea4a4a4",font:s.app.carouseldescriptionfont,HAlign:"Left"},targetRect:positions[0]})
    shop_menu.push({text:"Single Titles",textAttrs:{color:"#eea4a4a4",font:s.app.carouseldescriptionfont,HAlign:"center"},targetRect:positions[1]})
    shop_menu.push({text:"Packages",textAttrs:{font:s.app.carouseldescriptionfont,HAlign:"center"},targetRect:positions[2]})
    
    if IsHD()
        y_=this.app.size.h-this.app.edge_top-27
    else
        y_=this.app.size.h-this.app.edge_top-18
    endif
    x_=this.app.edge_left+this.app.sidebar_width
    if IsHD()
        btn_w=95
        btn_h=30
        txt_w=100
        bottom_positions=[
                {x:x_,y:y_,w:btn_w,h:btn_h},
                {x:x_+btn_w+10,y:y_,w:btn_w,h:btn_h},
                {x:x_+(btn_w*2)+20,y:y_,w:700,h:btn_h},   
               ]
    else
        btn_w=53
        btn_h=20
        txt_w=56
        bottom_positions=[
                {x:x_,y:y_,w:btn_w,h:btn_h},
                {x:x_+btn_w+6,y:y_,w:btn_w,h:btn_h},
                {x:x_+(btn_w*2)+11,y:y_,w:394,h:btn_h},   
               ]
    endif
    shop_bottom_menu=[]
    shop_bottom_menu.Push({url:"pkg:/images/preview.png",targetRect:bottom_positions[0]})
    shop_bottom_menu.Push({url:"pkg:/images/purchase.png",targetRect:bottom_positions[1]})
    


    this.shopmenu=shop_menu
    this.positions=positions
    this.bottom_menu=shop_bottom_menu
    this.bottom_positions=bottom_positions


    this.setSelected(1)


    this.loadIndividuals()

    s.canvas.setLayer(87,shop_menu)
    s.canvas.setLayer(89,shop_bottom_menu)
    dr = s.app.http.getWs("logState.php?userID="+s.app.getRegistry()+"&leftAt=shop")
end function



function shop_reset_carousel() as void
        m.app.canvas.clearLayer(2)
        m.app.canvas.clearLayer(8)
        m.app.canvas.clearLayer(18)
        m.app.canvas.clearLayer(19)
        m.app.canvas.clearLayer(20)        
        m.app.canvas.clearLayer(13)
        m.roCarousel.items[0]=[]
        m.roCarousel.items[1]=[]
        m.roCarousel.level=0
        m.roCarousel.selected[0]=0
        m.roCarousel.selected[1]=0
        m.roCarousel.layer=2
        
end function



function shop_load_individuals() as void


                items=m.parent.http.getWs("getShopIndividuals.php")
                
                m.resetCarousel()
                m.roCarousel.levels=1
                m.roCarousel.setItems(0,items)
                m.roCarousel.updateLevelPositions(0)
                m.roCarousel.paint()
            '    m.roCarousel.setToolTip(0,"Press ok button to buy each video separately","md")
                m.ispackage=false
                m.setSelected(1)

end function




function shop_load_packages() as void
       
                
                ws_shop=m.parent.http.getWs("getShopPackages.php")
                items=[]
                i=0
                obj_videos=[]
                for each item in ws_shop
                
                    theid=item.id
                
                    items[i]={id:i,
                             package_id:theid
                             price:item.price
                             title:item.title,
                             thumbnail:item.thumbnail
                             description:item.description
                            }
                     videos=[]
                     for each video in item.videos
                           video.parent_id=theid
                           videos.push(video)
                     end for                  
                    obj_videos[i]=videos
                
                i=i+1
                end for
                
                m.videos=obj_videos
                
                
                m.resetCarousel()
                m.roCarousel.levels=2
                m.roCarousel.setItems(0,items)
                m.roCarousel.updateLevelPositions(0)                
                m.roCarousel.paint()
                m.ispackage=true
'                m.roCarousel.setToolTip(0,"Press ok to buy the complete package","md")
                m.setSelected(2)

end function




'Returns true if you wants to continue the carousel flow or false if you break it
function shop_on_select(o) as boolean


        
'        if(m.ispackage and m.app.trial=false)
 '               o.playermode="full"
  '          else
            
            
            'if (m.ispackage)
             o.isShop=true
                
                o.playermode="preview"
   '         endif
            return true  
        
        
        '####################### Delete the return above to back to the dialog Selector for Preview, Purchase and Cancel
        'If is package show the preview from the current video
        if(m.ispackage)
           o.isShop=true
           o.playermode="preview"
           return true
        endif
 
        selected=o.getPlaylistIndex()
        items=o.items[o.level]
        item=items[selected]      

        video_id=item.id
        
        ws="getPopup.php?id=8"
                popup=m.app.http.getWs(ws)
                r=m.app.dialog.optional({text:popup[0].content,options:[popup[0].option_1,popup[0].option_2,popup[0].option_3],default:2})
        
        
        'Purchase option selected
        if(r=1)
                m.app.dialog.process("Please wait...")
                
                    uid=m.app.userid
                    
                    
                                                      'ws="payvideo.php?user_id="+uid+"&vid="+video_id
                                                      'r=m.parent.http.getPPWs(ws)
                    
                    print "never here"
                    order=[{code:"101",qty:1}]
                    currentOrder = m.app.store.SetOrder(order)  ' id del producto en la tienda a comprar
                    purchase = m.app.store.DoOrder()
                                        
                    if purchase
                                                
                            m.app.store.clearOrder()
                            ws="setPurchase.php?user_id="+uid+"&video_id="+video_id
                            r=m.parent.http.getWs(ws)
                            
                            
                            if(type(r)<>"roInvalid")
                                   if(r.done="1")
                                       m.app.dialog.alert("Purchase completed and added to new 'My Collections' heading in Places. Thank You!")
                                   else
                                       m.app.dialog.alert("There is a problem with your purchase, please contact to "+m.app.support_email)
                                   endif
                            else
                                       m.app.dialog.alert("Could not send your purchase")
                                       
                            endif
                    else
                            m.app.dialog.alert("There is a problem with your purchase, please contact to "+m.app.support_email)
                    endif
           return false
           
        'Preview option selected
        else if(r=0)
            if (m.ispackage) o.isShop=true
            o.playermode="preview"
            return true                
        endif
        
             
        return false

end function






function shop_before_level_action(id,o,level) as boolean


                items=m.videos[id]
                if(type(items)<>invalid)
                    o.setItems(level,items)

                    return true
                else
                    return false
                endif

end function




function shop_purchase(o) as void

        
                    'Trial users not enables to purchase
                    if(m.app.trial)
                        m.app.dialog.alert("Please note that one time purchases only work for subscribed users.")
                        r=m.app.dialog.confirm2("Subscribe and enjoy more!",["Subscribe Now","Keep exploring"])
                        print r
                        if r then
                              'ws="getPopup.php?id=1"
                              'popup=m.app.http.getWs(ws)
                              'r2=m.app.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
                              '  options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                              'if r2=2
                              '  m.app.subscribe(3)
                              'else if r2=1
                              '  m.app.subscribe(2)
                              'lse if r2=0
                              '  m.app.subscribe(1)
                              'endif
                              m.app.istrial()    
                        else
                          m.app.forceSection()
                          return
                        endif
                    
                    return
                    endif
       
       
                                   
                    selected=o.getPlaylistIndex()
                    items=o.items[o.level]
                    item=items[selected]
            
                    uid=m.app.userid
                    print "shopping"
                    print m.ispackage
                    if(m.ispackage)
                        package_id=item.parent_id
                        ws="setPurchase.php?user_id="+uid+"&package_id="+package_id
                        'ispurchased="isPurchased.php?user_id="+uid+"&package_id="+package_id
                        undone="cancelPurchase.php?user_id="+uid+"&package_id="+package_id
                        code="PACK"+package_id
                    else
                        video_id=item.id
                        ws="setPurchase.php?user_id="+uid+"&video_id="+video_id
                        'ispurchased="isPurchased.php?user_id="+uid+"&video_id="+video_id
                        undone="cancelPurchase.php?user_id="+uid+"&video_id="+video_id
                        code=video_id
                    endif
                                           

                            print "code"
                            print code
                            order=[{code:code,qty:1}]
                            currentOrder = m.app.store.SetOrder(order)  ' id del producto en la tienda a comprar
                   
                            m.app.dialog.process("Please wait...")                                           
                            'm.app.store.clearOrder()
                            'r=m.parent.http.getWs(ispurchased)
                            
                            'if(type(r)<>"roInvalid")
                                           'if(r.purchased=false)
                                                           purchase = m.app.store.DoOrder()
                                                           if purchase
                                                                
                                                                    r=m.parent.http.getWs(ws)
                                                                    m.app.dialog.stopProcess()                      
                                                                    
                                                                    if(type(r)<>"roInvalid")
                        
                                                                            if(r.done="1")
                                                                                m.app.dialog.stopProcess()
                                                                                m.app.dialog.alert("Purchase completed and added to new 'My Collections' heading in Places. Thank You!")
                                                                            else
                                                                                m.app.dialog.stopProcess()                      
                                                                                m.app.dialog.alert("The video is already purchased")                                                    
                                                                            endif
                                                                            
                                                                    else
                                                                        m.app.dialog.alert("There is a problem with your purchase, please contact to "+m.app.support_email)
                                                                        m.app.http.getWs(undone)
                                                                    endif
                    
                                                           else
                                                                m.app.dialog.alert("The purchase could not be completed")
                                                                m.app.http.getWs(undone)
                                                           endif
                                               
                                               
                                               
                                           'else
                                           '    m.app.dialog.stopProcess()                      
                                           '    m.app.dialog.alert("The video is already purchased")
                                           'endif
                            'else
                            '           m.app.dialog.stopProcess()                      
                            '           m.app.dialog.alert("There is a problem with your purchase, please contact to "+m.app.support_email)
                                       
                           ' endif
       

            
           

end function








function shop_on_carousel_locked(index,o) as void

        'validate not inMain Menu
        if(m.app.menu.inMain) return
        
                
                
                'PURCHASE AND PREVIEW BUTTONS
                if(m.inbottom)
                    
                        if(index=2 or index=7)
                             m.app.soundFx("click")
                            m.lock_carousel=false
                            o.drawRing()
                            m.hideBottomRing()
                            m.inbottom=false
                        else if(index=4 or index=5)
                                m.app.soundFx()
                                if(index=4)
                                
                                    if(m.bottom_position>0) m.bottom_position=m.bottom_position-1
                                
                                else
                                
                                    if(m.bottom_position<1) m.bottom_position=m.bottom_position+1
                                
                                endif
                                
                                m.drawBottomRing(index)
                        
                        else if(index=6)
                                 m.app.soundFx("click")
                                                
                                if(m.bottom_position=1)
                                    m.purchase(o)
                                else
                                    
                                    o.onSelect(true) 
                                endif
                        
                        endif
                          
                    return                   
                endif
        
        
        
        
        
        
        
        

        'Validate empty playlist
                position=m.position
                if((index=3 and o.isEmpty()) or (index=6 and m.position<>2 and o.isEmpty())) return
                ' >>> 4 or 5 are the sideways controls m.position<>2 allows add new playlist


    'One level up more
    if(index=2 or index=7)
        'Exit section and go home
'        if(position=0)
            if (index<>2)
                m.app.forceSection()
            endif
            return
 '       endif


    'If Down continue 
 '   else if(index=3)
            
        
'        m.lock_carousel=false
'        o.level=0
'        m.hideRing()
'        o.drawRing()
'        if m.ispackage
'           o.setToolTip(0,"Press 'OK' to buy the complete package","md")
'        else
'           o.setToolTip(0,"Press 'OK' button to buy each video separately","md")
'        endif
   
   
   
   'Left or Right
   else if(index=4 or index=5)
        
        m.app.soundFx()
        
        
        position=m.position
        
        'By default the positions are 2 Individuals, Packages
        count=3       
        total=count-1
        
'        if(index=4)
'            position=position-1
'            if(position<0) position=total
            
 '       else
 '           position=position+1
 '           if(position>total) position=0
            
 '       endif
        
        
        if(index=4)
            position=position-1
            if(position<0)
                m.app.forceSection()
                return
           endif
        else
            if(position<total)position=position+1
        endif      
    
    
    m.position=position
    m.drawRing(index)
    
   
   
   else if(index=6 or index=3)
        
        m.app.soundFx("click")
        
        '####### restart
        '######  for index=3      
'        m.lock_carousel=false
'        o.level=0
'        m.hideRing()
'        o.drawRing()
'        if m.ispackage
'           o.setToolTip(0,"Press 'OK' to buy the complete package","md")
'        else
'           o.setToolTip(0,"Press 'OK' button to buy each video separately","md")
'        endif
        '###################
        '##################
        
        
        
        
        'Go Back
        if(m.position=0 and index=6)
            m.app.forceSection()
            return
        'Individuals
        else if(m.position=1)
            m.loadIndividuals()
             o.isShop = false
        'Packages
        else if(m.position=2)
           m.loadPackages()
            o.isShop = true
        endif
        
        m.hideRing()
        o.drawRing()
        m.lock_carousel=false

        return
   endif
    
    
   
    
end function


function shop_set_selected(n) as void

    menu=m.shopmenu
    
    for each mn in menu
        mn.textAttrs.color="#eea4a4a4"
    end for
    
    menu[n].textAttrs.color="#ffffffff"
    m.app.canvas.setLayer(87,menu)
end function


function shop_draw_ring(index) as void


    p=m.position    
    
    imgring="pkg:/images/ring_play_100.png"
    
    if IsHD()
        x_=m.positions[p].x
        y_=m.positions[p].y+25
        w_=150
        h_=0
    else
        x_=m.positions[p].x-5
        y_=m.positions[p].y+20
        w_=90
        h_=0
    endif
    
    if(p=0)
        'x_=x_-49
        imgring="pkg:/images/back_over.png"
        x_=m.positions[p].x
        y_=m.positions[p].y
        w_=m.positions[p].w
        h_=m.positions[p].h
        
    endif
       
    ring={url:imgring,
          targetRect:{w:w_,h:h_,x:x_,y:y_}
          }


    m.parent.canvas.setLayer(88,ring)

end function






function shop_hide_ring() as void

    m.parent.canvas.clearLayer(88)

end function



function shop_draw_bottom_ring(index) as void


    p=m.bottom_position
    imgring="pkg:/images/preview_hover.png"
    
    x_=m.bottom_positions[p].x
    y_=m.bottom_positions[p].y
    if IsHD()
        w_=96
        h_=30
    else
        w_=54
        h_=20
    endif
    
    if(p=1)
        imgring="pkg:/images/purchase_hover.png"
    endif
       
    ring={url:imgring,
          targetRect:{w:w_,h:h_,x:x_,y:y_}
          }


    m.parent.canvas.setLayer(90,ring)

end function



function shop_hide_bottom_ring() as void

    m.parent.canvas.clearLayer(90)

end function



function carousel_show_message(text,hide=false) as void

    target=m.bottom_positions[2]
    
    message={text:text,targetRect:target,textAttrs:{font:m.app.tooltipfont,HAlign:"Left"}}
    
    m.canvas.setLayer(91,message)
    
    if(hide)m.app.setTimeout(m.hideMessage)
    
end function


function carousel_hide_message() as void
    m.canvas.clearLayer(91)
end function




'This function is called when 
'the carousel level is lower than level 0
function shop_on_overflow_top(o) as void


    o.hideTooltip()
    o.hideRing()
    m.lock_carousel=true
    m.drawRing(0)

end function


function shop_on_overflow_bottom(o) as void
    
    o.hideTooltip()
    o.hideRing()
    m.lock_carousel=true
    m.inbottom=true
    m.drawBottomRing(0)

end function




function shop_on_scroll(o) as void
    
end function



function shop_on_last_level(o) as void

'    if(m.ispackage)o.setTooltip(1,"Push 'OK' to preview this video")

end function




function shop_on_blur_last_level(o) as void
                
                if(m.ispackage=false)
                        o.hideToolTip()
                else
 '                       o.setTooltip(0,"Press 'OK' to buy the complete package")
                endif
end function




function shop_on_empty(o) as void

    if(o.editable)
        m.parent.show(shop_section)
        return
    end if

    m.onOverflowTop(o)

end function





function shop_on_category_select(o) as boolean


                o.onLevelDown()
                if(m.ispackage)  
                    o.isShop = true
                else
                    o.isShop = false
                endif
                
                '    o.playermode="full"
                'else
                    o.playermode="preview"
                'endif
                return true
        
end function





