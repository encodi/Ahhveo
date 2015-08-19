function relaxnow_section(s) as void


    s.app.menu.drawLineReference()

      this={
            beforeLevelUp:relaxnow_before_level_up
            onMoveHorizontal:relaxnow_on_move_horizontal
            onRemoveFavorite:relaxnow_on_remove_favorite
            onOverflowTop:relaxnow_on_overflow_top
            onAddFavorite:relaxnow_on_add_favorite
            drawRing:relaxnow_draw_ring
            hideRing:relaxnow_hide_ring
            onCarouselLocked:relaxnow_on_carousel_locked
            onCategorySelect:relaxnow_on_category_select
            app:s.app
            parent:s
           }
           
    
    ws="getRelaxNow.php?user_id="+this.parent.app.userid
    wsrelaxnow=s.http.getWs(ws)
    if IsHD()
        carousel=NewCarousel({
            app:s.app,
            canvas:s.canvas,
            itemsize:{w:288,h:170,margin:15,padding:15}
            section:this
            levels:1
            })
    else
        carousel=NewCarousel({
            app:s.app,
            canvas:s.canvas,
            itemsize:{w:162,h:113,margin:10,padding:10}
            section:this
            levels:1
            })
    endif
    carousel.star=true
            
    'Associate the handler for Main event propagation
    s.app.remoteListener=carousel
    s.app.player.playerListener=carousel
    'Sets the first Level Items
    carousel.setItems(0,wsrelaxnow)
    
'    s.app.drawTitle("Relax Now")
        s.app.drawRelaxNowTitle()
        
        'Draw Tip (Back)
    tips=[]
    
    if IsHD()
        x_=this.app.sidebar_width+78
    else
        x_=this.app.sidebar_width+44
    endif
    y_=this.app.edge_top
    
'    tips.push({url:"pkg:/images/goback.png",targetRect:{x:m.sidebar_width+75,y:m.edge_top,w:128,h:49}})
    if IsHD()
        tips.Push({url:"pkg:/images/back.png",textAttrs:{Color:"#ffffff",
                                      font:this.app.carouseldescriptionfont,
                                      HAlign:"Left"},
                                      targetRect:{x:x_,y:y_,w:39,h:32}})
    else
        tips.Push({url:"pkg:/images/back.png",textAttrs:{Color:"#ffffff",
                                      font:this.app.carouseldescriptionfont,
                                      HAlign:"Left"},
                                      targetRect:{x:x_,y:y_,w:22,h:21}})
    endif
    this.app.canvas.setLayer(52,tips)
    this.tip_x=x_
    this.tip_y=y_
        dr = this.parent.app.http.getWs("logState.php?userID="+this.parent.app.getRegistry()+"&leftAt=relax_now")
         'Render a random video instead of default carousel first time
         'print s.app.menu.continue
         if(s.app.menu.continue=false)
            
            s.app.canvas.clearLayer(50)
            s.section=0
'            s.show(relaxnow_section)
            total=s.app.player.playerListener.items[0]
            total=total.count()-1
            rand=Fix(Rnd(total))
            
            's.app.menu.continue=true
            carousel.paint()
            carousel.selected[0]=0 ' instead of random, we will random in the php and only play the first element in the array
            s.app.canvas.clearLayer(82)
            s.app.canvas.clearLayer(83)
            'm.app.audio.player.stop()
            carousel.onSelect()
            
            return
        
        endif
 
    carousel.paint()  
    
    
end function



function relaxnow_before_level_up(id,o,level) as boolean
     items=m.videos[id]
                if(type(items)<>invalid)
                    o.setItems(level,items)

                    return true
                else
                    return false
                endif
end function

function relaxnow_on_move_horizontal(id,o,level) as boolean
    return false
end function






function relaxnow_on_add_favorite(item,o) as void
    
    items=o.items[0]
    items.push(item)
    o.setItems(0,items)
    total=items.count()
    last=total-1
    o.selected[0]=last
    o.paint()
       
end function




function relaxnow_on_remove_favorite(id,o) as void
    
    items=o.items[0]
    array=[]
    index=0
    for each item in items
          array.push(item.id)
    endfor
    
    index=arraySearch(id,array)
    items.delete(index)
    
    
    if(items.count()>0)
        o.setItems(0,items)
        o.selected[0]=0
        o.paint()
    else
        o.clearAll()
    endif
    
end function

function relaxnow_draw_ring(index) as void

    
    p=m.position
    
    imgring="pkg:/images/ring_play_100.png"
    
    
    x_=m.tip_x
    y_=m.tip_y
    
    if IsHD()
        w_=39
    else
        w_=22
    endif
    ring={url:imgring,
          targetRect:{w:w_,h:2,x:x_,y:y_}
          }

    tips=[]
    if IsHD()
        tips.Push({url:"pkg:/images/back_over.png",
                                      targetRect:{x:x_,y:y_,w:39,h:32}})
    else
        tips.Push({url:"pkg:/images/back_over.png",
                                      targetRect:{x:x_,y:y_,w:22,h:21}})
    endif
    m.app.canvas.setLayer(53,tips)

end function

function relaxnow_on_carousel_locked(index,o) as void
    '    
        if(index=2 or index=7 or index=6 or index=4)
        'Exit section and go home
     '   if(position=0)
           if (index<>2)
                m.app.forceSection()
            endif
                return
         else if(index=3)
             m.hideRing()
             o.drawRing()
             m.lock_carousel=false
             return
        endif
       
        
       m.drawRing(index)
       
        
end function

function relaxnow_hide_ring() as void

    m.app.canvas.clearLayer(53)

end function

function relaxnow_on_overflow_top(o)
       'Force to show section with main app forceSection function
        o.hideRing()
        
        m.lock_carousel=true
        m.drawRing(0)
        'm.app.forceSection()
end function

function relaxnow_on_category_select(o) as boolean
    o.onLevelDown()
    return true
end function

