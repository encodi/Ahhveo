function moods_section(s) as void

      this={
            app:s.app
            parent:s
            beforeLevelAction:moods_before_level_action
            onOverflowTop:moods_on_overflow_top
            onCategorySelect:moods_on_category_select
            drawRing:moods_draw_ring
            hideRing:moods_hide_ring
            onCarouselLocked:moods_on_carousel_locked
           }
           
    wsmoods=s.http.getWs("getMoods.php")
    i=0
    items=[]
    obj_videos=[]
    for each mood in wsmoods
        'print mood.mid
        items[i]={id:i,
                 title:mood.title,
                 thumbnail:mood.thumbnail,
                 ambiances:mood.ambiances
                }
         videos=[]      
         for each video in mood.videos
               videos.push(video)    
         end for                  
        obj_videos[i]=videos   
    i=i+1
    end for
    
    this.videos=obj_videos
    
    
    'Instantiate a Pseudo Class roCarousel
    if (IsHD())
        carousel=NewCarousel({
                app:s.app,
                canvas:s.canvas,
                itemstyle:{w:288,h:170,margin:15,padding:15}
                section:this
                levels:2
                })
     else
        carousel=NewCarousel({
                app:s.app,
                canvas:s.canvas,
                itemstyle:{w:162,h:113,margin:10,padding:10}
                section:this
                levels:2
                })
     endif
    'Associate the handler for Main event propagation
    s.app.remoteListener=carousel
    s.app.player.playerListener=carousel
    'Sets the first Level Items
    carousel.setItems(0,items)
    carousel.paint()


  'Draw Tip (Back)
    tips=[]
    
    x_=this.app.sidebar_width+78
    y_=this.app.edge_top
    
'    tips.push({url:"pkg:/images/goback.png",targetRect:{x:m.sidebar_width+75,y:m.edge_top,w:128,h:49}})
    if (IsHD())
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
    
    dr = this.app.http.getWs("logState.php?userID="+this.app.getRegistry()+"&leftAt=themes")
    
end function


function moods_before_level_action(id,o,level) as boolean


                items=m.videos[id]
                if(type(items)<>invalid)
                    o.setItems(level,items)

                    return true
                else
                    return false
                endif

end function



function moods_on_carousel_locked(index,o) as void
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
             o.firstitem[o.level]=1 ' this select the level
             o.drawRing()
             m.lock_carousel=false
             return
        endif
       
        
       m.drawRing(index)
       
        
end function





function moods_draw_ring(index) as void

    
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
        tips.Push({url:"pkg:/images/back_over.png", targetRect:{x:x_,y:y_,w:39,h:32}})
    else
        tips.Push({url:"pkg:/images/back_over.png", targetRect:{x:x_,y:y_,w:22,h:21}})
    endif
    m.app.canvas.setLayer(53,tips)

'    m.parent.canvas.setLayer(53,ring)

end function




function moods_hide_ring() as void

    m.parent.canvas.clearLayer(53)

end function



function moods_on_overflow_top(o)
    'Force to show section with main app forceSection function
    'Hide any tooltip displayed to avoid mix these
    o.hideTooltip()
    o.hideRing()
    m.lock_carousel=true
    m.drawRing(0)
end function



function moods_on_category_select(o) as boolean
    o.onLevelDown()
    return true
end function


