function playlists_section(s) as object


      this={
            parent:s
           
            onCarouselLocked:playlists_on_carousel_locked
            
            beforeLevelAction:playlists_before_level_action
            
            onOverflowTop:playlists_on_overflow_top
            
            onOverflowBottom:playlists_on_overflow_bottom
            
            onLastLevel:playlists_on_last_level
            
            onBlurLastLevel:playlists_on_blur_last_level
            
            onReorder:playlists_on_reorder
            
            onEmpty:playlists_on_empty
            
            onSelect:playlists_on_select
            
            onCategorySelect:playlists_on_category_select
            
            onContinuePlaylist:playlists_on_continue_creation
            
            onScroll:playlists_on_scroll
            
            newPlaylist:playlists_new_playlist
            
            savePlaylist:playlists_save_playlist
            
            onEdit:playlists_on_edit
            
            lock_carousel:false           
            
            position:1
            
            setSelected:playlists_set_selected
            
            drawRing:playlists_draw_ring
            
            hideRing:playlists_hide_ring
            
            onBeforeExit:playlists_on_before_exit
            
            goPlaylists:playlists_go_playlists
            
            disableOptions:playlists_disable_options
            
            app:s.app
            
            creating:false
            
            thelist:CreateObject("roAssociativeArray")
            
            myid:invalid
            
            init:playlists_init
            
            remoteCallBack:playlist_remote_callback
            
            car:invalid
           }
           
    wsplaylists=s.http.getWs("getPlaylist.php?user_id="+s.app.userid)
    items=[]
    i=0
    obj_videos=[]
    this.thelist = []
    for each playlist in wsplaylists
    
        theid=playlist.id.toint()
        
        this.thelist[i]={id:theid}
    
        items[i]={id:i,
                 title:playlist.title,
                 thumbnail:playlist.thumbnail
                }
         videos=[]
         for each video in playlist.videos
               video.parent_id=theid
               videos.push(video)
         end for                  
        obj_videos[i]=videos
    
    i=i+1
    end for
    
    this.videos=obj_videos
    
    
    'Instantiate a Pseudo Class roCarousel
    if IsHD()
        carousel=NewCarousel({
                app:s.app,
                canvas:s.canvas,
                style:{w:288,h:170,margin:15,padding:15}
                section:this
                levels:2
    '            toplevels:1
                })
    else
        carousel=NewCarousel({
                app:s.app,
                canvas:s.canvas,
                style:{w:162,h:113,margin:10,padding:10}
                section:this
                levels:2
    '            toplevels:1
                })
    endif   
            m.car = carousel
    'Associate the handler for Main event propagation
    s.app.remoteListener=carousel
    s.app.player.playerListener=carousel
    'Sets the first Level Items
    
    
    
    
    playlist_menu=[]
    
    
    sb_w=s.app.sidebar_width
    screen_w=s.app.size.w-sb_w
    
    if IsHD()
        playl_x=sb_w+Fix(screen_w/2)-225
        play_y=30
    else
        playl_x=sb_w+Fix(screen_w/2)-127
        play_y=20
    endif
    
    if IsHD()
        positions=[
               {x:this.app.sidebar_width+78,y:this.app.edge_top,w:39,h:32},
               {w:150,h:25,x:playl_x,y:play_y},
               {w:150,h:25,x:playl_x+150,y:play_y},
               {w:150,h:25,x:playl_x+275,y:play_y},
               {w:150,h:25,x:playl_x+400,y:play_y}
              ]
    else
        positions=[
               {x:this.app.sidebar_width+44,y:this.app.edge_top,w:22,h:21},
               {w:84,h:17,x:playl_x,y:play_y},
               {w:84,h:17,x:playl_x+84,y:play_y},
               {w:84,h:17,x:playl_x+155,y:play_y},
               {w:84,h:17,x:playl_x+225,y:play_y}
              ]
    endif
    playlist_menu.Push({url:"pkg:/images/back.png",textAttrs:{font:s.app.carouseldescriptionfont,HAlign:"Left"},targetRect:positions[0]})
    playlist_menu.push({text:"Playlists",textAttrs:{font:s.app.carouseldescriptionfont,HAlign:"center"},targetRect:positions[1]})
    playlist_menu.push({text:"Edit",textAttrs:{font:s.app.carouseldescriptionfont,HAlign:"center"},targetRect:positions[2]})
    playlist_menu.push({text:"New",textAttrs:{font:s.app.carouseldescriptionfont,HAlign:"center"},targetRect:positions[3]})



    this.playlistmenu=playlist_menu
    this.positions=positions

    carousel.setItems(0,items)
    carousel.paint()
    
    s.canvas.setLayer(87,playlist_menu) 
    this.setSelected(1)
   
    'm.drawRing(0)
    'm.lock_carousel=true
    dr = s.app.http.getWs("logState.php?userID="+s.app.getRegistry()+"&leftAt=playlists")
    return this
end function

Function playlist_remote_callback(index) as void
 'Associate the handler for Main event propagation
    m.app.remoteListener=m.car
    m.app.player.playerListener=m.car
End Function 

Function playlists_init(parent = false) as void
    m.parent=parent
End Function

'Returns true if you want to continue the flow or false if you break it
function playlists_on_select(o) as boolean

        if(o.editable)
                    
            if(o.ordering=false)
                o.ordering=true
                
'                m.setToolTip(1,"Press sideways to rearrange the playlist or down to remove video")
                
                selected=o.getPlaylistIndex()
                tselected=o.getSelected()
               
                positions=o.positions[o.level]
                coords=positions[o.firstitem[o.level]]
 
                'm.fixed=m.selected[m.level]
                
                o.index=o.getSelected()
                o.fixed=o.getPlaylistIndex()
                o.fixedselection=o.selected[o.level]
                o.dragg=o.getPlaylistIndex()

                items=o.items[o.level]
                item=items[selected]              
                tselected=item.title
               
               if IsHD()
                    target={x:coords.x+(o.style.w-30),y:coords.y+(o.style.h-22),w:25,h:18}
               else
                    target={x:coords.x+(o.style.w-17),y:coords.y+(o.style.h-15),w:14,h:12}
               endif
               o.setToolTip(1,"Press sideways then 'OK' to rearrange playlist. Press down arrow to remove this title.")
          
                
             else
             
                    o.ordering=false
                    o.setToolTip(1,"Push 'OK' to change order or remove title, press down to delete entire playlist.")
                    m.onReorder(o)
                    
             endif
        
        
            return false
        
        end if
    
        return true

end function



function playlists_on_category_select(o) as boolean

         
         if(o.editable)
                if(o.level=0)
                    o.onLevelDown()
                    return false
                endif
         
         else if(o.level=0)
             o.onLevelDown()
            return true
            
         endif
         
         
         
end function


function playlists_on_continue_creation(o) as boolean
    
    ''' here we send the playlist info and start new playlist
    if (o.editable)
        m.setSelected(3)
        m.creating=true
        m.lock_carousel=false
        m.hideRing()
        o.hideTooltip()
        m.newPlaylist(o)
        
        m.myid = o.selected[o.level] ' this is the id of the list to be edited
            
        return true
    else
        return false
    endif
end function


function playlists_before_level_action(id,o,level) as boolean


                items=m.videos[id]
                if(type(items)<>invalid)
                    o.setItems(level,items)

                    return true
                else
                    return false
                endif

end function


function playlists_go_playlists(reload_pl = false) as void
    'if (reload_pl) m.lock_carousel = true
    m.parent.show(playlists_section)    
    m.setSelected(1)
    m.position=0
    if reload_pl
        m.position=1
        m.drawRing(0)
    endif
end function



function playlists_on_before_exit(o) as boolean
    
    
    counter=m.ids_videos
        if(m.creating)
            if(counter.count()>0)
                ws="getPopup.php?id=7"
                popup=m.app.http.getWs(ws)
                r=m.app.dialog.optional({text:popup[0].content,options:[popup[0].option_1,popup[0].option_2,popup[0].option_3],default:2})
                    if(r=0)
                        m.savePlaylist(o)
                        return false
                    else if(r=1)
                        return true
                    endif
            
            return false
            else
                return true
            endif
        endif
    
    
    
    return true
    
        
  '  r=true
  '  if(m.creating)
  '      
  '      ids=m.ids_videos
  '      total=ids.count()
  '      
  '      if(total>0)
  '         r=m.app.dialog.confirm("Discard playlist edition?")
  '         return r
  '      endif
        
    
    
   ' endif
    
  
end function



function playlists_on_carousel_locked(index,o) as void
 
    'print o ' is the carousel
        'validate not inMain Menu
        if(m.app.menu.inMain) return

        'Validate empty playlist
                position=m.position
                
                if((index=3 and o.isEmpty()) or (index=6 and m.position<>3 and m.position<>0 and o.isEmpty())) return
                ' >>> 4 or 5 are the sideways controls m.position<>2 allows add new playlist
    
        
    'One level up more
    if(index=7) 'index=2 or  returns when up key too
        'Exit section and go home
     '   if(position=0)
            m.app.forceSection()
            return
     '   endif
    'If Down continue 
 '   else if(index=3)
            
 '       o.updateLevelPositions(0)
 '       m.lock_carousel=false
 '       o.level=0
 '       m.onEdit(o)
   
   else if(index=4 or index=5)
        m.app.soundFx()
        position=m.position
        
        'By default the positions are 3 (Back,Playlist, Edit, New)
        count=4       
        total=count-1
        
    '    if(index=4)
    '        position=position-1
    '        if(position<0) position=total
            
    '    else
    '        position=position+1
    '        if(position>total) position=0
            
   '     endif
    
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
    
  'else if (index=10)
    
   
   else if(index=6 or index=3)
        print "current position"
        print m.position
        m.app.soundFx("click")
        '####### restart
        '######  for index=3
     '   o.updateLevelPositions(0)
     '   m.lock_carousel=false
     '   o.level=0
     '   m.onEdit(o)
        '####################
        '####################
           
          'Go Back
          if(m.position=0 and index=6)
              m.app.forceSection()
              return
       
         'All Playlists                   
         else if(m.position=1)
        
            m.setSelected(1)
            if(m.creating)
                  discard=m.app.dialog.confirm("Discard playlist edition?")
                  if(discard=false) return
            end if
        
            'Force to reload the playlists section from sectionManager
            
            m.goPlaylists()
            
            
                    
        'Editing
        else if(m.position=2)
            o.updateLevelPositions(0)
            m.setSelected(2)
            o.editable=true
            m.onEdit(o)
            o.level=0
             if(m.app.trial)
                        ws="getPopup.php?id=12"
                        popup=m.app.http.getWs(ws)
                
                        r=m.app.dialog.confirm2(popup[0].content,[popup[0].option_1,popup[0].option_2])
                        
                        if r then
                          ' ws="getPopup.php?id=1"
                          'popup=m.app.http.getWs(ws)
                          'r2=m.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
                          '  options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                          '    if r2=2
                          '      m.app.subscribe(3)
                          '    else if r2=1
                          '      m.app.subscribe(2)
                          '    else if r2=0
                          '      m.app.subscribe(1)
                          '    endif
                          m.app.istrial()    
                        else
                            m.app.forceSection()
                            return
                        endif
                    
                    return
                    endif
        
        'Creating playlist
        else if(m.position=3)
            m.myid=invalid
            m.setSelected(3)
            m.creating=true
            m.lock_carousel=false
            m.hideRing()
            m.newPlaylist(o)
             if(m.app.trial)
                        ws="getPopup.php?id=12"
                        popup=m.app.http.getWs(ws)
                
                        r=m.app.dialog.confirm2(popup[0].content,[popup[0].option_1,popup[0].option_2])
                        
                        if r then
                          '  ws="getPopup.php?id=1"
                          'popup=m.app.http.getWs(ws)
                          'r2=m.app.dialog.optional2({text:popup[0].content, text2:popup[0].content_2, text3:popup[0].content_3,  text4:"Prices are USD.",
                          '  options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]}, popup[0].title)
                          '    if r2=2
                          '      m.app.subscribe(3)
                          '    else if r2=1
                           '     m.app.subscribe(2)
                           '   else if r2=0
                          '      m.app.subscribe(1)
                          '    endif
                          m.app.istrial()    
                        else
                            m.app.forceSection()
                            return
                        endif
                    
                    return
              endif
            return
        endif
        
                
        m.hideRing()
        o.drawRing()
        m.lock_carousel=false
   endif
    
    
   
    
end function


function playlists_set_selected(n) as void

    menu=m.playlistmenu
    blur_color="#eea4a4a4"
    focus_color="#ffffffff"
       
    
    for each mn in menu
        mn.textAttrs.color=blur_color
    end for
        
    menu[n].textAttrs.color=focus_color    
    m.app.canvas.setLayer(87,menu)
end function


function playlists_draw_ring(index) as void


    p=m.position
    
    imgring="pkg:/images/ring_play_100.png"
    
    if IsHD()
        x_=m.positions[p].x+15
        y_=m.positions[p].y+25
        w_=120
        h_=2
    else
        x_=m.positions[p].x+8
        y_=m.positions[p].y+17
        w_=68
        h_=2
    endif
   
    if(p<>1)
            imgring="pkg:/images/ring_play_50.png"
            if IsHD()
                w_=59
                x_=x_+30
            else
                w_=33
                x_=x_+20
            endif                         
    endif
    
    if(p=0)
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


function playlists_hide_ring() as void

    m.parent.canvas.clearLayer(88)

end function




function playlists_on_reorder(o) as void


        'Getting the start selected index item
        f=o.fixed
        
        'Getting the items from the roCarousel object passed
        items=o.items[o.level]
        
        'Getting the selected carousel element and all properties based on index
        fixed=items[f]
        
        'Getting the final index position in the playlist and element
        c=o.getPlaylistIndex()
        current=items[c]


        'No changes 
        if(f=c) return


        m.app.soundFx("click")
        respuesta=m.app.dialog.confirm("Save Changes?")
        

        if(respuesta)        

                    'Invert positions on the items for corresponding level
                    items[f]=current
                    items[c]=fixed
                    o.items[o.level]=items
                    
                    'Getting the url params for the webservice call
                    video_id=fixed.id
                    playlist_id=fixed.parent_id
                    ws_selected=c
                    video_pos=Stri(ws_selected)
                    video_pos=video_pos.trim()
                    plid = playlist_id.tostr()
                    plid = plid.trim()
                    'Save on the webservice
                    ws="setPlaylistOrder.php?video_id="+video_id+"&playlist_id="+plid+"&video_position="+video_pos
                    o.setTooltip(1,"Saving...","sm")
                    r=m.parent.http.getWs(ws)
                    
                    if(r.done="1")
                        o.setToolTip(1,"The order was change","sm",true)
                    else
                        o.setTooltip(1,"An error occurred while trying to save",invalid,true)

                    end if      
        
                    return
        
        else
        
            'Revert positions on the carousel array and repaint
             o.selected[o.level]=o.fixedselection
                        
        endif

        o.paint()
       
end function



'This function is called when 
'the carousel level is lower than level 0
function playlists_on_overflow_top(o) as void

    'Hide any tooltip displayed to avoid mix these
    o.hideTooltip()
    o.hideRing()
    m.lock_carousel=true
    m.drawRing(0)

end function


'This function is called when
'the carousel level is upper than total levels
function playlists_on_overflow_bottom(o) as void
         
        m.app.soundFx("click")


        'Getting the items from the roCarousel object passed
        items=o.items[o.level]
        
        'Getting the selected carousel element and all properties based on index


    'Only takes action if the mode is 'Editable
   if(o.editable)
        
        'For delete a single v�deo
        if(o.ordering)


            
            if(m.app.dialog.confirm("Remove this video from playlist?"))
                    f=o.fixed
                    fixed=items[f]
                    playlist_id=fixed.parent_id
                    video_id=fixed.id
                    
                    ws="deletePlaylistItem.php?playlist_id="+playlist_id.tostr()+"&video_id="+video_id
                    
                    r=m.parent.http.getWs(ws)
                           
                        if(r.done="1")
                            items.delete(f)
                          '  o.items[o.level]=items
                            o.setItems(1,items)
                            o.selected[o.level]=0
                            o.updateLevelPositions(1)
                            o.ordering=false
                        end if        
                       
                       if items.count()>0 
                        o.paint()
                        o.setToolTip(1,"Push 'OK' to change order or remove title, press down to delete entire playlist")
                       else
                        m.goPlaylists() 
                       endif
                       
            
            else
              'Revert positions on the carousel array and repaint
              o.selected[o.level]=o.fixedselection
              'Leave ordering
              o.ordering=false
              o.paint() 
            endif
        else
        'Delete an entirely playlist
         ws="getPopup.php?id=6"
         popup=m.app.http.getWs(ws)
                 if(m.app.dialog.confirm(popup[0].content))
                    
                    
                    f=o.getPlaylistIndex()
                    fixed=items[f]
                    playlist_id=fixed.parent_id    
                    
                    r=m.app.http.getWs("deletePlaylist.php?playlist_id="+playlist_id.tostr())
                    
                    if(r.done="1")
                        m.goPlaylists()
                    endif            
                 endif

        endif


   endif

end function



function playlists_on_edit(o) as void
    
        m.hideRing()
        o.drawRing()
    
        if(o.editable)
            
            if(o.level=0)
                o.setToolTip(0,"Push 'OK' to edit this playlist or push '*' to add a new title to playlist") '   
            else if(o.editable)
                o.setToolTip(1,"Push 'OK' to change order or remove title, press down to delete entire playlist")
            endif
    
        endif
end function




function playlists_on_scroll(o) as void
    
    return

end function




function playlists_on_last_level(o) as void

  if(o.editable) o.setToolTip(1,"Push 'OK' to change order or remove title, press down to delete entire playlist")

end function




function playlists_on_blur_last_level(o) as void

'                o.hideToolTip()
                o.ordering=false
                o.level=0
                m.onEdit(o)
end function




function playlists_on_empty(o) as void

    x_=m.app.sidebar_width+m.app.edge_left
    if IsHD()
        populate={text:"Create a Playlist to populate this section",
              textAttrs:{font:m.app.h3}
              targetRect:{x:x_,y:m.app.size.center_y,w:m.app.size.free_width,h:50}}
    else
        populate={text:"Create a Playlist to populate this section",
              textAttrs:{font:m.app.h3}
              targetRect:{x:x_,y:m.app.size.center_y,w:m.app.size.free_width,h:33}}
    endif
    m.app.canvas.setLayer(1,populate) 
    if(o.editable)
            m.goPlaylists()
        return
    end if

    m.onOverflowTop(o)

end function



function playlists_disable_options() as void

    menu=m.playlistmenu
    
    for each mn in menu
        mn.textAttrs.color="#eea4a4a4"
    end for


        menu[3].textAttrs.color="#ffFFCC00"


    m.app.canvas.setLayer(87,menu)
end function




function playlists_new_playlist(o) as void
    
     'm.myid = invalid
    
     save_option={text:"Save",textAttrs:{color:"#eea4a4a4",font:m.app.carouseldescriptionfont,HAlign:"center"},targetRect:m.positions[4]}
     m.app.canvas.setLayer(55,save_option)
     m.disableOptions()
    
    'Copying the parent functions to this context
    this=m
    
    'Adding new properties to the context
    this.ids_videos=[]
    
    'Replacing functions inherit from parent
    this.onSelect=playlists_places_on_select
    this.beforeLevelAction=playlists_places_before_level_action
    this.onLastLevel=playlists_places_on_last_level
    this.onOverflowTop=playlists_places_on_overflow_top
    this.onScroll=playlists_places_on_scroll
    this.beforePaint=playlists_places_before_paint
    this.onCategorySelect=playlists_places_on_category_select
    
    
    wsplaces=m.parent.http.getWs("getPlaces.php?user_id="+m.app.userid)

     items=[]  
     i=0
     obj_videos=[]
     j=0
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
        carousel=NewCarousel({
            app:m.app,
            canvas:m.app.canvas,
            style:{w:288,h:170,margin:15,padding:15}
            section:this
            levels:3
'            toplevels:1
            })   
    else
        carousel=NewCarousel({
            app:m.app,
            canvas:m.app.canvas,
            style:{w:162,h:113,margin:10,padding:10}
            section:this
            levels:3
'            toplevels:1
            })
    endif
    'Associate the handler for Main event propagation
    m.app.remoteListener=carousel
    m.app.player.playerListener=carousel
    
        
    'Sets the first Level Items
    carousel.setItems(0,items)
    carousel.paint()    
    
    'm.drawRing(1)

end function



function playlists_places_before_level_action(id,o,level) as boolean


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



function playlists_places_on_select(o) as boolean

    f=o.getPlaylistIndex()
    items=o.items[o.level]
    fixed=items[f]    

    ids_videos=m.ids_videos

    id=fixed.id
   exists=false
   
   for each v in ids_videos
        if v=id 
            exists=true
            exit for
        end if
   end for
   
   if (exists=false)
    if (m.myid<>invalid)
        if (m.myid<>invalid)
            plResponse=m.parent.http.getWs("getPlaylistWithId.php?pid="+m.thelist[m.myid].id.tostr())
            if plResponse<>invalid
                for each v in plResponse[0].videos
                     if v=id 
                        exists=true
                        exit for
                    end if
                end for   
            endif
        endif
    endif 
   endif
   
   
   if(exists=false) 
        ids_videos.push(id)
        m.ids_videos=ids_videos   
        o.setTooltip(2,"Video added to the playlist","sm",true)
   else
        o.setTooltip(2,"The video has already been added","md")
   
   endif
    
    
    
    return false
end function



function playlists_places_before_paint(o) as void

    o.isplaylists=true
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





function playlists_places_on_last_level(o) as void

  o.setTooltip(2,"Press 'OK' to add title to new playlist","md")

end function

function playlists_places_on_scroll(o) as void
  if(o.level=2) o.setTooltip(2,"Press 'OK' to add title to new playlist","md")
end function


function playlists_places_on_overflow_top(o) as void

    counter=m.ids_videos
    if(counter.count()>0)
'            if(m.app.dialog.confirm("Save changes?"))
'                m.savePlaylist(o)
'                return
'            endif
'    else if(m.app.dialog.confirm("Discard playlist edition?")=false)
'            return

        ws="getPopup.php?id=7"
                popup=m.app.http.getWs(ws)
                r=m.app.dialog.optional({text:popup[0].content,options:[popup[0].option_1,popup[0].option_2,popup[0].option_3],default:2})
            if(r=0)
                m.savePlaylist(o)
                return
            else if(r=2)
                return
            endif
    endif
    
    m.goPlaylists(true)

end function







function playlists_save_playlist(o) as void

    
    
    
     kb = CreateObject("roKeyboardScreen")
     port = CreateObject("roMessagePort") 
     kb.SetMessagePort(o.app.port)
     kb.SetTitle("Name your Playlist")
     if (m.myid<>invalid)
        myResponse=m.parent.http.getWs("getPlaylistWithId.php?pid="+m.thelist[m.myid].id.tostr())
        if myResponse<>invalid
            kb.SetText(myResponse[0].title)
        endif
    endif
'     kb.SetText("default")
     kb.SetDisplayText("Type the playlist title")
     kb.SetMaxLength(14)
     kb.AddButton(1, "Ok")
     kb.AddButton(2, "Cancel")
     kb.Show() 
    
  
     while true
         msg = wait(350,o.app.port) 

            
                     if type(msg) = "roKeyboardScreenEvent"
                         if msg.isScreenClosed()
                             return
                         else if msg.isButtonPressed() then
                             if msg.GetIndex() = 1
                                 playlist_title= kb.GetText()
                                 'if (len(playlist_title)<15)
                                    kb.Close()
                                 'else
                                       
                                 'endif
                                 
                                 exit while
                             else if msg.getIndex()=2
                                    kb.Close()
                                    return
                             endif
                         endif
                     endif
                     
     end while 
    
    '' we get here the list with the id if is not invalid
    if (m.myid<>invalid)
        plResponse=m.parent.http.getWs("getPlaylistWithId.php?pid="+m.thelist[m.myid].id.tostr())
        'print plResponse[0].id
        'print plResponse[0].title
        vids=m.ids_videos
        str_videos=""
        for each v in vids
            str_videos=str_videos+v+","
        end for
        for each v in plResponse[0].videos
            str_videos=str_videos+v+","
        end for        
        print str_videos
        print m.thelist[m.myid].id.tostr()
        print plResponse[0].title
        ws="updatePlaylist.php?pid="+m.thelist[m.myid].id.tostr()+"&video_ids="+str_videos+"&playlist_title="+plResponse[0].title
        
        o.setTooltip(2,"Saving...","sm")
        
        r=m.parent.http.getWs(ws)
        
        ' FIXME broken return as 1
        if r<>invalid    
            if(r.done="1")
                    m.app.dialog.alert("Playlist updated.")
                    m.goPlaylists()
            else
                print "Error on saving playlist update"
                o.setTooltip(2,"An error occurred while trying to save")
            endif
        else
            print "Error on saving playlist update"
            'o.setTooltip(2,"An error occurred while trying to save")
        endif
    else ' is new playlist
        vids=m.ids_videos
        str_videos=""
        
        'Validate the title not empty
        if(playlist_title="")return
        
        for each v in vids
            str_videos=str_videos+v+","
        end for
        
        playlist_title=m.parent.http.Http.Escape(playlist_title)
    
        ws="setNewPlaylist.php?user_id="+m.app.userid+"&video_ids="+str_videos+"&playlist_title="+playlist_title
        
        o.setTooltip(2,"Saving...","sm")
        
        r=m.parent.http.getWs(ws)
        
            
        if(r.done="1")
                m.app.dialog.alert("New Playlist saved to 'My Playlists'.")
                m.goPlaylists()
        else
            o.setTooltip(2,"An error occurred while trying to save")
        endif
    end if
    
    
    

end function







function playlists_places_on_category_select(o) as boolean
    o.onLevelDown()
    if(o.level=1 or o.level=2)return false
    return true
end function







