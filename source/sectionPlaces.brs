function places_section(s) as void



    this={
            parent:s
            beforeLevelAction:places_before_level_action
            beforePaint:places_before_paint
            onOverflowTop:places_on_overflow_top
            onCategorySelect:places_on_category_select
            onCarouselLocked:places_on_carousel_locked
            app:s.app
            drawRing:places_draw_ring
            hideRing:places_hide_ring
         }    
         
     this.app.hidePreloader()
     wsplaces=s.http.getWs("getPlaces.php?user_id=997")
     items=[]  
     i=0
     j=0
     obj_videos=[]
     for each place in wsplaces
        
        items[i]={id:i,
                 title:place.title,
                 thumbnail:place.thumbnail
                 ambiances:place.ambiances
                }




        subplaces=[]
        
        for each subplace in place.subplaces
        
             subplaces.push({id:j,
                             title:subplace.title,
                             thumbnail:subplace.thumbnail
                             ambiances:subplace.ambiances
                          })


             videos=[]   
             'k=0   
             for each video in subplace.videos
                   
                   videos.push(video)    
                   
             end for                  
             obj_videos[j]=videos
                
             j=j+1
        endfor         

        items[i].subplaces=subplaces
        
        
        i=i+1
    end for
    
    this.videos=obj_videos

     'Instantiate a Pseudo Class roCarousel
    if IsHD()
        carousel=Thumby2({
                app:s.app,
                canvas:s.canvas,
                'style:{w:288,h:170,margin:15,padding:15}
                'section:this
                'levels:3
    '            toplevels:1
                })
    else
        carousel=Thumby2({
                app:s.app,
                canvas:s.canvas,
                'style:{w:162,h:113,margin:10,padding:10}
                'section:this
                'levels:3
    '            toplevels:1
                })
    endif   
    'Associate the handler for Main event propagation
    s.app.remoteListener=carousel
    s.app.player.playerListener=carousel
    'Sets the first Level Items
    'carousel.setItems(0,items) ' no need to call this one here
    carousel.paint()
    
    
    'Draw Tip (Back)
    tips=[]
    
    x_=this.app.sidebar_width+78
    x_=100 ' new 2.0
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
    'this.app.canvas.setLayer(52,tips)
    this.tip_x=x_
    this.tip_y=y_
    
    this.app.isPlaces=true
    
    'dr = this.app.http.getWs("logState.php?userID="+this.app.getRegistry()+"&leftAt=places")
    
end function



function places_before_level_action(id,o,level) as boolean

if level=1
         items=o.items[0]
         subplaces=items[id].subplaces
        
    if(type(subplaces)<>invalid)               
            if(type(subplaces)="roArray")
                if(subplaces.Count()>0)
                    o.setItems(level,subplaces)
                    return true
                else
                    return false
                endif
            else
                    return false
            endif
    
    endif

else if level=2
   
    items=m.videos[id]
    
    o.setItems(level,items)
    return true

endif

return false

end function




function places_before_paint(o) as void

    o.isplaces=true
    'Trick to getting new carousel positions
    level=o.level
    
    items0=o.items[0]
    items1=o.items[1]
    items2=o.items[2]
    
    o.level=0


    if(type(items0)="roArray")o.positions[0]=o.GetPositions(items0)
    if(type(items1)="roArray")o.positions[1]=o.GetPositions(items1)

    o.level=1
    if(type(items2)="roArray")o.positions[2]=o.GetPositions(items2)

    o.level=level

end function



function places_on_carousel_locked(index,o) as void
    '    
        if(index=2 or index=7 or index=6 or index=4)
        'Exit section and go home
     '   if(position=0)
            'm.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
           ' m.app.audio.play(m.settings.sleep_sound,"sleep.wma")
            
            'if position=0
            
            'print o.level
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



function places_draw_ring(index) as void

    
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


'    m.parent.canvas.setLayer(53,ring)

end function


function places_hide_ring() as void

    m.parent.canvas.clearLayer(53)

end function



function places_on_overflow_top(o)
    'Force to show section with main app forceSection function
    'Hide any tooltip displayed to avoid mix these
    o.hideTooltip()
    o.hideRing()
    m.lock_carousel=true
    m.drawRing(0)
end function



function places_on_category_select(o) as boolean
    o.onLevelDown()
    if(o.level=1)return false
    return true
end function