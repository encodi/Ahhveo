

function NewCarousel(options) as object


    this={
         app:options.app,
         canvas:options.canvas,
         carousel:[],
         overtitles:[],
         setDescription:set_description,
         createPaginator:create_paginator,
         setPage:set_page,
         paint:paint_carousel,
         style:{w:270,h:160,margin:15,padding:15},
         getPositions:get_carousel_positions
         level:0,
         margin:options.margin,
         items:[],
         remoteCallback:handle_carousel_remote
         setItems:set_carousel_items
         onLevelUp:carousel_on_levelup
         onLevelDown:carousel_on_leveldown
         section:options.section
         paintTopLevels:carousel_paint_top_levels
         positions:[]
         selected:[]
         selected_title:""
         playerCallBack:player_callback
         scrollHorizontal:carousel_scroll_horizontal
         firstitem:[] 'When total items is 1,2 or 3 is 0 else 1, by default is 1
         levels:options.levels
         drawRing:carousel_draw_ring
         paintChildrens:carousel_paint_childrens
         getSelected:carousel_get_selected
         onSelect:carousel_on_select
         getPlaylistIndex:carousel_get_playlist_index
         layer:2  ' 1 when first line 8 when second line
         updateLevelPositions:carousel_update_level_positions
         hideRing:carousel_hide_ring
         editable:false
         ordering:false
         fixed:false
         dragg:false
         fixedselection:false
         setToolTip:carousel_set_tool_tip
         hideToolTip:carousel_hide_tool_tip
         isEmpty:carousel_is_empty
         renderThumbs:carousel_render_thumbs
         renderTitles:carousel_render_titles
         renderOvers:carousel_render_overs
         clearAll:carousel_clear_all
         clearLoading:carousel_clear_loading
         limit_thumbs:6
         options:options
         drawBack:carousel_draw_back
         hideBack:carousel_hide_back
         clearTitles:carousel_clear_titles
         playermode:"full"
         isShop:false
	     star:false
	     stars:[]
	     isplaces:false
	     isplaylists:false
	     selectedItem:0
         }

    for l=0 to this.levels     
            this.selected[l]=0
            this.firstitem[l]=1
    end for
    
    
    if (IsHD())
        this.style={w:270,h:160,margin:15,padding:15}
    else
        this.style={w:152,h:107,margin:10,padding:10}
    endif
    
 
    this.style.center_y=fix((this.app.size.h/2)-(this.style.h/2))
    this.style.center_x=fix((this.app.size.w/2)-(this.style.w/2))+Fix(this.app.sidebar_width/2)
    
    
    return this
end function





function paint_carousel() as void

    m.clearTitles()


    if(type(m.section.beforePaint)="roFunction") m.section.beforePaint(m)


    m.paintTopLevels()
    items=m.items[m.level]
    totalitems=items.count()
        
        'Validate empty list
        if(totalitems=0)
                   if(type(m.section.onEmpty)="roFunction") m.section.onEmpty(m)
            return
        endif
    
    total=totalitems-1
    carousel=[]
    overtitles=[]
    overs=[]
    positions=m.positions[m.level]
    current=m.selected[m.level]
    
          
    secuence=GetSecuence(current,totalitems)
        
       
        for i=0 to total
            item=items[i]
            itemposition=positions[secuence[i]]

                thumbnail=item.thumbnail
                
                carousel.push({
                              url:thumbnail,
                              targetRect:itemposition
                               })
                  
               if (IsHD())                  
                    y_=233
                    titletarget={x:itemposition.x,y:y_+3,w:itemposition.w,h:Fix(itemposition.h/4.5)}
                    titletargets1={x:itemposition.x,y:y_,w:itemposition.w,h:Fix(itemposition.h/5)}
               else
                    y_=155
                    titletarget={x:itemposition.x,y:y_,w:itemposition.w,h:Fix(itemposition.h/4.5)}
                    titletargets1={x:itemposition.x,y:y_,w:itemposition.w,h:Fix(itemposition.h/4.5)}
               endif
               
               overs.push({
                                Color:"#a0000000"
                                compositionMode:"Source_Over"
                                targetRect:titletargets1
                                })
                                
               overtitles.push({
                                text:item.title
                                textAttrs:{font:m.app.h2}
                                targetRect:titletarget                                
                                })
              
         '   if(i=m.firstitem[m.level]) firstitem=item
        end for

    m.carousel[m.level]=carousel
    m.overtitles[m.level]=overtitles


if IsHD()
center=(m.app.size.h/2)+(m.style.h/2)+10

paginator={text:total,
           targetRect:{x:m.app.size.w-10,}
          }
else
center=(m.app.size.h/2)+(m.style.h/2)+6

paginator={text:total,
           targetRect:{x:m.app.size.w-6,}
          }
endif


m.createPaginator(1,totalitems)
m.renderThumbs(m.layer,carousel)
m.renderTitles(overs,overtitles)
m.setDescription()

m.drawRing()
'm.drawBack()
m.setPage()
m.paintChildrens()


        
end function



function carousel_draw_back() as void
    if IsHD()
        back={text:"Back",textAttrs:{font:m.app.h2,HAlign:"Left"},targetRect:{x:m.app.sidebar_width+75,y:m.app.edge_top,w:80,h:25}}
    else
        back={text:"Back",textAttrs:{font:m.app.h2,HAlign:"Left"},targetRect:{x:m.app.sidebar_width+42,y:m.app.edge_top,w:45,h:17}}
    endif
    m.canvas.setLayer(16,back)
end function


function carousel_hide_back() as void
    m.canvas.clearLayer(16)
end function





function carousel_draw_ring(level=false) as void
    
    if(level=false) level=m.level
    positions=m.positions[level]
    
    url_rings=[]
    url_rings.push("pkg:/images/ring.png")
    url_rings.push("pkg:/images/ring_level_1.png")
    url_rings.push("pkg:/images/ring_level_2.png")
    
    ring={
    
           
            url:url_rings[m.level],
            targetRect:{
                          x:positions[m.firstitem[m.level]].x-7,
                          y:positions[m.firstitem[m.level]].y-7,
                          w:positions[m.firstitem[m.level]].w+14,
                          h:positions[m.firstitem[m.level]].h+14
                       }
          }
    m.canvas.setLayer(9,ring)
    
end function




function carousel_hide_ring() as void
    m.canvas.clearLayer(9)
end function




function carousel_render_thumbs(layer,items,loading=true,current=false) as void

    m.clearLoading()
    
    preloader=[]
   ' stars=[]
    if(loading)
        'Strange, assign p=item takes the later properties form left side
        'Mandatory create a new object for loading thumbnail and copies the
        'Target Rect from item
        for each item in items
            target=item.targetRect
            p={url:"pkg:/images/loading.png",targetRect:{w:target.w,h:target.h,x:target.x,y:target.y}}
            preloader.push(p)
            m.stars.push({x:target.x,y:target.y,w:target.w})
            
        end for
        
           if(m.star)
             for each star in m.stars
                if IsHD()        
                    items.push({url:"pkg:/images/relaxnow_small_star_corner.png",targetRect:{x:star.x+(star.w-75),y:star.y,w:75,h:82}})
                else
                    items.push({url:"pkg:/images/relaxnow_small_star_corner.png",targetRect:{x:star.x+(star.w-42),y:star.y,w:42,h:55}})
                endif        
              end for
              m.star=false
           endif
    
        m.canvas.setLayer(layer-1,preloader)
    endif


   
m.canvas.setLayer(layer,items)

end function


function carousel_render_titles(overs,items,layer1=false,layer2=false) as void


    if(layer1=false)layer1=82
    if(layer2=false)layer2=83 
   

    if(m.level=(m.levels-1))return
    if(type(overs)="roAssociativeArray" or type(overs)="roArray")m.canvas.setLayer(layer1,overs)
    m.canvas.setLayer(layer2,items)
end function


function carousel_clear_titles()  as void
    m.canvas.clearLayer(82)
    m.canvas.clearLayer(83)
    m.canvas.clearLayer(19)
    m.canvas.clearLayer(20)
end function



function carousel_render_overs(layout,overs) as void

    m.canvas.setLayer(layout,overs)

end function


function carousel_clear_all() as void
    m.canvas.clearLayer(2)
    m.canvas.clearLayer(18)
    m.canvas.clearLayer(9)
    m.canvas.clearLayer(10)
    m.canvas.clearLayer(11)
    m.canvas.clearLayer(13)
    m.canvas.clearLayer(14)
    m.canvas.clearLayer(15)
    m.canvas.clearLayer(56)
    m.canvas.clearLayer(57)
    m.canvas.clearLayer(16)
    m.canvas.clearLayer(31)
    m.canvas.clearLayer(81)
    m.canvas.clearLayer(82)
    m.canvas.clearLayer(83)
    m.canvas.clearLayer(84)
    m.canvas.clearLayer(85)
    m.canvas.clearLayer(86)
    m.clearLoading()
end function



function carousel_clear_loading() as void

    m.canvas.clearLayer(1)
    m.canvas.clearLayer(7)
    m.canvas.clearLayer(17)
    m.canvas.clearLayer(12)
    
end function



function carousel_scroll_horizontal(index) as void


            '######## DO NOT ANYTHING WHEN THE SELECTION IS ON MAIN MENU#######
            if(m.app.menu.inMain) 
                return
            else
            '######## HIDE LINE WHEN MAIN MENU LOST FOCUS
                m.app.menu.hideLineReference()
            endif
            
            positions=m.positions[m.level]
            total=positions.Count()
            items=m.carousel[m.level]
            
                        
            selected=m.selected[m.level]
                        
            
            last=total-1
         
            if(index=4)
            'Left Remote Pressed
                    current=selected+1
                    if(current>last)
                        current=0
                    end if
             else if(index=5)             
            'Right Remote Pressed
                    current=selected-1
                    if(current<0)
                        current=last
                    end if                     
             endif 
        

            m.selected[m.level]=current    
            secuence=GetSecuence(current,total)
            
            if(m.ordering)
                        
                    index=m.getPlaylistIndex()
                    
                    fixeditem=items[m.dragg]
                    currentitem=items[index]
                    
                    items[m.dragg]=currentitem
                    items[index]=fixeditem
                    

                    m.dragg=index
           


            else          
            
                    m.setDescription()                                                    
            endif
            
            
            
            m.setPage()
                

'            m.carousel[m.level]=items
            
            
            for j=0 To last
                 items[j].targetRect=positions[secuence[j]]
            end for
                      


            titles=m.overtitles[m.level]

            if(type(titles)="roAssociativeArray" or type(titles)="roArray")
                
                for j=0 To last
                     p=positions[secuence[j]]
                     x_=p.x
                     titles[j].targetRect.x=x_
                end for
                
            endif            
            
            
            
            
            layer2=83
            if(m.level+1=m.levels)layer2=20
            
            m.renderThumbs(m.layer,items)
            m.renderTitles(false,titles,false,layer2)
            m.paintChildrens()
           
           
           if(type(m.section.onScroll)="roFunction") m.section.onScroll(m)


end function







function carousel_paint_childrens() as void

            
            nextlevel=m.level+1
            
            if(nextlevel>=m.levels) return

            currentitems=m.items[m.level]
           
          
    selected=m.getPlayListIndex()
                     
    item=currentitems[selected]
    
    haschilds=m.section.beforeLevelAction(item.id,m,nextlevel) 'here is the problem dude, find a way to fix 
   
        if(haschilds=false) 
            m.canvas.setLayer(18,{text:"Coming soon",targetRect:{y:m.style.center_y,x:m.style.center_x,w:m.style.w,h:m.style.h},textAttrs:{HAlign:"center",font:m.app.tooltipfont}})
            m.items[nextlevel]=Invalid
            m.carousel[nextlevel]=Invalid
            return
        endif
    
    
    items=m.items[nextlevel] 'nextlevel
   
    totalitems=items.Count()
    total=totalitems-1
    aux_level=m.level
    m.level=nextlevel
   
    positions=m.getPositions(items)
    m.level=aux_level
         childs=[]
         overs=[]
         overtitles=[]
         i=0
         
        for each child in items
                    
                    itemposition=positions[i]
                    itemposition.y=m.style.center_y
                   
                    childs.push({
                                 url:child.thumbnail
                                 targetRect:itemposition
                                 
                                })
                
               if IsHD()                                
                   y_=itemposition.y+95
                   titletarget={x:itemposition.x,y:y_+2,w:itemposition.w,h:Fix(itemposition.h/5)}
                   titletargets1={x:itemposition.x,y:y_,w:itemposition.w,h:Fix(itemposition.h/5)}
               else
                   y_=itemposition.y+65
                   titletarget={x:itemposition.x,y:y_+2,w:itemposition.w,h:Fix(itemposition.h/5)}
                   titletargets1={x:itemposition.x,y:y_,w:itemposition.w,h:Fix(itemposition.h/5)}
               endif
               overs.push({
                                Color:"#a0000000"
                                compositionMode:"Source_Over"
                                targetRect:titletargets1
                                })
                                
               overtitles.push({
                                text:child.title
                                textAttrs:{font:m.app.h4}
                                targetRect:titletarget                                
                                })
                                
                                                                                                             
               i=i+1
        end for
    
    m.overtitles[nextlevel]=overtitles
    
    m.selected[nextlevel]=0
    m.positions[nextlevel]=positions
    m.carousel[nextlevel]=childs
    m.items[nextlevel]=items
    m.renderThumbs(18,childs)
    if(nextlevel<>m.levels-1)m.renderTitles(overs,overtitles,19,20)
    m.updateLevelPositions(nextlevel)
    
   
end function





function carousel_paint_top_levels() as void


toplevel=m.level-1
topitems=m.items[toplevel]



item_width=m.style.w-(10*toplevel)
item_height=Fix((item_width*m.style.h)/m.style.w)


x_=m.app.edge_left+m.app.sidebar_width-10
'If init in the first Level
y_=fix(m.style.center_y-(item_height*2))-(m.style.margin+16)
'If init in latest level
if(m.level=(m.levels-1)) 

    y_=fix(m.style.center_y-(item_height+m.style.margin))
    'Trick, the most low level in where a developer could falling
    if(m.levels>=3) y_=fix(m.style.center_y-(item_height+m.style.margin+6))

endif

    
cont=toplevel
top_level_items=[]
overs=[]

while(toplevel>=0)

    if(type(m.options.toplevels)<>"Invalid")
           if(toplevel=0 and m.level=1)exit while
    endif

    totalitems=topitems.Count()
    total=totalitems-1
    
    item_width=m.style.w-(10*toplevel)
    item_height=Fix((item_width*m.style.h)/m.style.w)
 
 
    current=m.selected[toplevel]
    secuence=GetSecuence(current,totalitems)
 
    positions=m.positions[toplevel]
    
    for i=0 to total
    
    item=topitems[i]
       
        if(type(item)<>Invalid)
            
            itemposition=positions[secuence[i]]
            itemposition.y=y_

            top_level_items.push({url:item.thumbnail,
                                  targetRect:itemposition
                                  })
                                  

           m.updatelevelpositions(toplevel)
                

           if(secuence[i]<>m.firstitem[toplevel])
           overs.push({url:"pkg:/images/opacity.png",
                                 targetRect:itemposition
                                })
           else if(toplevel=0 and m.levels>2)
           'overs.push({url:"pkg:/images/opacity.png",
           '                      targetRect:itemposition
           '                     })                           
           endif
           
                                        
           x_=x_+m.style.w+m.style.margin                          
        end if
    end for
    



    rest=0
    if(toplevel=1) rest=7
    y_=y_-(item_height+m.style.margin+rest)
    toplevel=toplevel-1   
    topitems=m.items[toplevel]
   
   
    if(type(m.options.toplevels)<>"Invalid")
           if(toplevel=0)exit while
    endif
   

end while

 m.renderThumbs(81,top_level_items,false)
 m.renderOvers(84,overs)
end function



function handle_carousel_remote(index) as void
    
    'print "key press"
    'print index
    'Validate not in main menu
    if(m.app.menu.inMain) return


    if(type(m.section.lock_carousel)<>"Invalid" and index<>0)
        if(m.section.lock_carousel)
            m.section.onCarouselLocked(index,m)
        return
        endif
   
    endif

    'Button <LEFT> or Button <RIGHT>
     if(index=4 or index=5)
      m.scrollHorizontal(index)
      m.app.soundFx()
    
    'Button <DOWN>
     else if(index=3)
       if m.app.menu.inMain=false then m.onLevelDown()
    'Button Up
     else if(index=2 or index=7)
       m.onLevelUp()
       m.app.soundFx()
    
     'Go Back <BACK> or <REPEAT/RETURN>
     
     else if(index=0)

       if(type(m.section.onBeforeExit)="roFunction") 
                confirm_exit=m.section.onBeforeExit(m)
                if(confirm_exit=false) return       
       endif
       m.app.menu.unmark()
       m.app.menu.inMain=true
       m.hideRing()
       m.app.menu.drawLineReference()
       'm.app.soundFx("click")
     
       'This shows the home section every time press key BACK o RETURN
       m.app.isPlaces=true
       m.app.section.show(home_section)
       m.app.inNews=true
       'm.app.goHome()
       'm.app.audio.play(m.app.settings.sleep_sound,"sleep.wma")
       m.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
     '<OK> Button
     else if(index=6)
       m.onSelect()
       'm.app.soundFx("click")
     else if(index=10)
        if (m.level=0)
            'print "send to new playlist again with the id of the playlist selected"
            continue=m.section.onContinuePlaylist(m)
            if continue=true
                'currentitems=m.items[m.level]       
                'selected=m.getPlaylistIndex()
                'selected_item=currentitems[selected]
                ''print "selected_item"
                ''print selected_item.id
                'm.selectedItem = selected_item.id
            endif
        endif
        if continue=false return
        
     end if
 



end function




function carousel_on_levelup() as void
    
    prevlevel=m.level-1
    
    'Callback before blur last level
    if(m.level=(m.levels-1))    
        if(type(m.section.onBlurLastLevel)="roFunction") m.section.onBlurLastLevel(m)
    endif
        
    'Overflow top
    if(prevlevel<0) 
        if(type(m.section.onOverflowTop)="roFunction")
            m.section.onOverflowTop(m)
        endif
        return
    else
       m.level=prevlevel
       m.setItems(prevlevel,m.items[prevlevel])
       m.paint()
    endif
    
    m.updateLevelPositions(prevlevel)
    m.drawRing(prevlevel)
    m.layer=2
    
end function




function carousel_on_leveldown() as void
    
    nextlevel=m.level+1
    
    items=m.items[nextlevel]
    'No more levels   
    if(nextlevel>(m.levels-1) or m.levels=1 or type(items)="Invalid")
    
        'Callback when carousel hasn�t no more levels below
        if(type(m.section.onOverflowBottom)="roFunction") m.section.onOverflowBottom(m)
        
        m.app.soundFx("click")
        return  
    endif
    
    'Sound Fx
    m.app.soundFx()
    
    item=items[0]
    total=items.count()


    'On last level
    if nextlevel=(m.levels-1)
         m.level=nextlevel
         m.drawRing(nextlevel)
         m.layer=18
         total=items.count()
         m.createPaginator(1,total)
         m.setPage()
         m.paintTopLevels()
         m.setDescription()
         
            'Callback when carousel is on the last level
           if(type(m.section.onLastLevel)="roFunction") m.section.onLastLevel(m)
           
    'More than two levels
    else         
                
                moreitems=m.section.beforeLevelAction(item.id,m,nextlevel+1)
                                
                if(moreitems)
                    m.level=nextlevel
                    m.setItems(nextlevel,m.items[nextlevel]) ' here is the problem
                    m.paint()
                    m.drawRing(nextlevel)
                    m.layer=2
                endif
                

    end if
    

                      
end function


function carousel_on_select(isShop = false) as void
        
        'Validate not in main and the current level is the lastest (there are videos)
        if(m.app.menu.inMain)return
        
        
        '######## Check if the section provides a callback function for category select        
       if(m.level<>(m.levels-1))
              if(type(m.section.onCategorySelect)="roFunction")
                        continue=m.section.onCategorySelect(m)
                        if continue=false return
               endif
        '##### Check if the section provides a callback funcion before play the video########
       else if(type(m.section.onSelect)="roFunction")
               continue=m.section.onSelect(m)
               if continue=false return
        
       endif
                 
        
        '#####GENERATES THE PLAYLIST AND THROW THE V�DEO
        
      
                            
                            currentitems=m.items[m.level]
                            playlist=[]
                            
                            for each item in currentitems
                                
                                playitem_url=item.url+"/"+item.filename
                                playitem_url=fixVideoUrl(playitem_url) 
                               
                                playlist.push({
                                      id:item.id
                                      thumbnail:item.thumbnail
                                      stream:{url:playitem_url}
                                      streamformat:"hls"
                                      StreamBitrates:[384, 500, 1000, 15000]
                                      StreamQualities:["SD", "SD", "SD","HD"]
                                })
                            
                            end for
                            
                            selected=m.getPlaylistIndex()
                            m.app.player.previewmode=false
                            m.app.player.isShop = m.isShop
                            if(m.playermode="preview" or m.app.trial)m.app.player.previewmode=true
                            m.app.player.setPlaylist(playlist)
                            m.app.player.setTrack(selected)         
                            
                            ''print item.id
                            'ws="counterVideo.php?user_id="+m.app.userid+"&video_id="+item.id
                            'r=m.app.http.getWs(ws)
                            'if(type(r)<>"roInvalid")
                            'end if
                           
                            m.app.player.play()
                                                            

end function



function set_carousel_items(level,items)
'm.level=level
m.items[level]=items
m.positions[level]=m.getPositions(items)
end function


function carousel_get_playlist_index(level=false) as Integer

            if(level=false) level=m.level          
            currentitems=m.items[level]
            selected=m.selected[level]
            
            totalitems=currentitems.Count()
            total=totalitems-1
            
            if(totalitems=3 or totalitems=4 or totalitems=1 or totalitems=2)
                    selected=selected+1
            endif    
            
            if(selected=1 or selected=0)
                if(selected=1)
                    selected=0
                else
                    selected=1
                endif
           else
                    selected=(totalitems-selected)+1
            endif    
            return selected
end function




function set_description() as void


    empty=m.items[m.level]
    if(empty.count()=0)return

    currentitems=m.items[m.level]       
    selected=m.getPlaylistIndex()
    selected_item=currentitems[selected]

'######Title positions
if IsHD()
    t_left=m.app.sidebar_width+70
else
    t_left=m.app.sidebar_width+39
endif
t_width=m.app.size.w-m.app.sidebar_width
if IsHD()
    top_=fix((m.app.size.h/2)+(m.style.h/2)+30)
else
    top_=fix((m.app.size.h/2)+(m.style.h/2)+20)
endif
text_title=selected_item.title
if IsHD()
    xnewpos = 325
else
    xnewpos = 183
endif
    if(type(selected_item.ambiances)<>"Invalid")text_title=text_title+": "
        
        m.selected_title = text_title
        
        titleanddescription=[]
        if IsHD()
            titleanddescription.push({text:text_title,textAttrs:{HAlign:"Left",Font:m.app.carouseltitlefont},targetRect:{x:t_left,y:top_,w:t_width,h:50}})
        else
            titleanddescription.push({text:text_title,textAttrs:{HAlign:"Left",Font:m.app.carouseltitlefont},targetRect:{x:t_left,y:top_,w:t_width,h:33}})
        endif
        if (type(selected_item.ambiances)<>"invalid") then

    'if (selected_item.ambiances>0)
    if selected_item.ambiances=invalid
        ambiance_text = ""
    else
        if m.isplaces
            if isHD()
                xnewpos=210
            else
                xnewpos=120
            endif
            if (m.level=0)
                ambiance_text = selected_item.ambiances.toStr()+" Subcategories"
            else if (m.level=1)
                ambiance_text = selected_item.ambiances.toStr()+" Titles"
            endif
        else if m.isplaylists
            if IsHD()
                xnewpos = 210
            else
                xnewpos = 120
            endif
            if (m.level=0)
                ambiance_text = selected_item.ambiances.toStr()+" Subcategories"
            else if (m.level=1)
                ambiance_text = selected_item.ambiances.toStr()+" Titles"
            endif
        else
            if IsHD()
                xnewpos = 210
            else
                xnewpos = 120
            endif
            ambiance_text = selected_item.ambiances.toStr()+" Titles"
        endif
    endif
else
        ambiance_text = ""
endif

'm.canvas.setLayer(33,{text:ambiance_text,
 '                     textAttrs:{HAlign:"Left",Font:m.app.carouseldescriptionfont}
  '                    targetRect:{x:t_left+300,y:top_,w:t_width,h:50}})
        if IsHD()
            titleanddescription.Push({text:ambiance_text,textAttrs:{HAlign:"Left",Font:m.app.carouseldescriptionfont},targetRect:{x:t_left+xnewpos,y:top_,w:t_width,h:50}})
        else
            titleanddescription.Push({text:ambiance_text,textAttrs:{HAlign:"Left",Font:m.app.carouseldescriptionfont},targetRect:{x:t_left+xnewpos,y:top_,w:t_width,h:33}})
        endif
        m.canvas.setLayer(14,titleanddescription)

'm.canvas.setLayer(14,{text:text_title,
 '                     textAttrs:{HAlign:"Left",Font:m.app.carouseltitlefont}
  '                    targetRect:{x:t_left,y:top_,w:t_width,h:50}})




'###### Descripcion positions
if IsHD()
    t_left=m.app.sidebar_width+70
    t_width=m.app.size.w-m.app.sidebar_width-120
    top_=fix((m.app.size.h/2)+(m.style.h/2)+95)
    
    
    m.canvas.setLayer(15,{text:selected_item.description,
                          textAttrs:{HAlign:"Left",Valign:"top",font:m.app.carouseldescriptionfont}
                      targetRect:{x:t_left,y:top_,w:t_width,h:250}})
else
    t_left=m.app.sidebar_width+39
    t_width=m.app.size.w-m.app.sidebar_width-68
    top_=fix((m.app.size.h/2)+(m.style.h/2)+63)
    
    
    m.canvas.setLayer(15,{text:selected_item.description,
                          textAttrs:{HAlign:"Left",Valign:"top",font:m.app.carouseldescriptionfont}
                      targetRect:{x:t_left,y:top_,w:t_width,h:167}})
endif                      
         
         
'#########Price Values


'######Price Positions
if IsHD()
    p_left=m.app.sidebar_width+65
    p_width=500
    top_=m.app.size.h-m.app.edge_top-80
else
    p_left=m.app.sidebar_width+37
    p_width=253
    top_=m.app.size.h-m.app.edge_top-53
endif

    price=""
    if(type(selected_item.price)<>"Invalid" and selected_item.price<>"0")
        price=selected_item.price 
    else 
        m.canvas.clearLayer(31)
        return
    endif

if IsHD()        
    m.canvas.setLayer(31,{text:"Price: $"+price+" USD",
                      textAttrs:{HAlign:"Left",Font:m.app.h4}
                      targetRect:{x:p_left,y:top_,w:p_width,h:30}})
else
    m.canvas.setLayer(31,{text:"Price: $"+price+" USD",
                      textAttrs:{HAlign:"Left",Font:m.app.h4}
                      targetRect:{x:p_left,y:top_,w:p_width,h:20}})
endif
end function




function carousel_get_selected() as integer

            currentitems=m.items[m.level]
            selected=m.selected[m.level]
            totalitems=currentitems.Count()
            total=totalitems-1
            if(selected=1 or selected=0)
                if(selected=1)
                    selected=totalitems
                else
                    selected=1
                endif
            else
                selected=(totalitems-selected)+1                
            endif
            
            return selected

end function


function create_paginator(current,total)


total=Stri(total)
current=Stri(current)
if IsHD()
    right_=m.app.size.w-70-m.app.edge_left
    top_=fix((m.app.size.h/2)+(m.style.h/2)+40)
    
    m.canvas.setLayer(10,{
                        text:" of "+total,
                        textAttrs:{HAlign:"left",font:m.app.h4}
                        targetRect:{x:right_,y:top_,w:100,h:18}
                        })
                        
    page_right=right_-60
    m.canvas.setLayer(11,{
                        text:" "+current+" ",
                    textAttrs:{HAlign:"left",font:m.app.h4}
                    targetRect:{x:page_right,y:top_,w:100,h:18}                        
                    })
   'print "pager created"
else
    right_=m.app.size.w-39-m.app.edge_left
    top_=fix((m.app.size.h/2)+(m.style.h/2)+27)
    
    m.canvas.setLayer(10,{
                        text:" of "+total,
                        textAttrs:{HAlign:"left",font:m.app.h4}
                        targetRect:{x:right_,y:top_,w:56,h:12}
                        })
                        
    page_right=right_-60
    m.canvas.setLayer(11,{
                        text:" "+current+" ",
                    textAttrs:{HAlign:"left",font:m.app.h4}
                    targetRect:{x:page_right,y:top_,w:56,h:12}                        
                    })
endif
end function


function set_page()

selected=m.getSelected()

page=Stri(selected)

if IsHD()
    right_=m.app.size.w-70-m.app.edge_left
    top_=fix((m.app.size.h/2)+(m.style.h/2)+40)
    page_right=right_-52
    m.canvas.setLayer(11,{
                        text:page,
                        targetRect:{x:page_right,y:top_,w:50,h:20},
                        textAttrs:{HAlign:"right",font:m.app.h4}
                        })
   'print "pager created 2"
else
    right_=m.app.size.w-39-m.app.edge_left
    top_=fix((m.app.size.h/2)+(m.style.h/2)+27)
    page_right=right_-30
    m.canvas.setLayer(11,{
                        text:page,
                        targetRect:{x:page_right,y:top_,w:28,h:13},
                        textAttrs:{HAlign:"right",font:m.app.h4}
                        })
endif


end function


function player_callback(params)

    action=params.action
    if(action=1) 'Move Next Video
       m.scrollHorizontal(5)
    endif   
   
end function



function carousel_update_level_positions(level) as void



    m.firstitem[level]=1
    items=m.items[level]
    total_items=items.count()
    
    if(total_items=3 or total_items=4 or total_items=2 or total_items=1)
            m.firstitem[level]=0
    endif    


end function


'This function receives 4 params
' level in the carousel
' text to display
' size of the tooltip
' and hide after x seconds using m.app.setTimeout 
function carousel_set_tool_tip(level,txt,size="",hide=false) as void

    
    positions=m.positions[level]
    trgt=positions[m.firstitem[level]]
    
    if IsHD()
        x_=FIX(trgt.x+(m.style.w/2)-20)
        y_=trgt.y-30
    else
        x_=FIX(trgt.x+(m.style.w/2)-11)
        y_=trgt.y-20
    endif
    tool_tip_img="pkg:/images/tooltip.png"
    if IsHD()
        w_=620
        h_=61
    else
        w_=349
        h_=41
    endif

    if(type(size)<>"Invalid")
        if(size="sm")
            if IsHD()
                w_=288
            else
                w_=162
            endif
            tool_tip_img="pkg:/images/tooltip_small.png"
        else if(size="md")
            if IsHD()
                w_=429
            else
                w_=241
            endif
            tool_tip_img="pkg:/images/tooltip_middle.png"
        endif
    endif

    tooltip={url:tool_tip_img,targetRect:{x:x_,y:y_,w:w_,h:h_}}   
    if IsHD()
        txt={text:txt,textAttrs:{font:m.app.tooltipfont,VAlign:"center",HAlign:"center"},targetRect:{x:x_+10,y:y_+5,w:w_-20,h:40}}
    else
        txt={text:txt,textAttrs:{font:m.app.tooltipfont,VAlign:"center",HAlign:"center"},targetRect:{x:x_+6,y:y_+3,w:w_-11,h:27}}
    endif
    m.canvas.setLayer(85,tooltip)
    m.canvas.setLayer(86,txt)
    
    if(hide)m.app.setTimeout(m.hideTooltip)
    
end function


function carousel_hide_tool_tip() as void
    m.canvas.clearLayer(85)
    m.canvas.clearLayer(86)
end function 



function carousel_is_empty() as boolean
    items=m.items[m.level]
    total=items.count()
    if(total=0) return true
    return false
end function




function get_carousel_positions(items) as object

'items=m.items[m.level]


positions=[]
total_items=items.count()
    
    if IsHD()
        x_=m.app.edge_left+20
    else
        x_=m.app.edge_left+11
    endif
    item_width=m.style.w
    item_height=m.style.h

    add_x=0
    
    if(m.level>0)
        if IsHD()
            item_width=m.style.w-(70)
        else
            item_width=m.style.w-(39)
        endif
        item_height=Fix((item_width*m.style.h)/m.style.w)
        add_x=m.style.w-item_width
    endif
    
    if(total_items=3 or total_items=4 or total_items=2 or total_items=1)
            if IsHD()
                x_=m.app.edge_left+m.app.sidebar_width+m.style.margin-10
            else
                x_=m.app.edge_left+m.app.sidebar_width+m.style.margin-6
            endif
            m.firstitem[m.level]=0
'    else if(total_items=2 or total_items=1)
'            x_=Fix((m.app.size.w/2)-(((m.style.w+m.style.margin)*total_items))/2)+Fix(m.app.sidebar_width/2)
'            m.firstitem[m.level]=0
            if(m.level=1 or m.level=2) add_x=0  
    else
            if IsHD()
                add_x=50
                if(m.level=0) add_x=-20
            else
                add_x=28
                if(m.level=0) add_x=-11
            endif
    endif

    x_=x_+add_x
    y_=m.style.center_y
    
    if m.levels>1
        if(m.ordering=false) y_=Fix(m.style.center_y-(item_height+m.style.margin))
    endif


    for each i in items
        
        positions.Push({x:x_,y:y_,w:item_width,h:item_height})
        x_=x_+item_width+m.style.margin
        
    end for

    return positions


end function


