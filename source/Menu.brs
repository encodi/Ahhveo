

Function createMenu(app) as Object 
     
       this={app:app
             canvas:app.canvas
             render:menu_render
             level:0
             position:0
             options:false
             size:0
             setOptions:menu_set_options
             handleMenuAction:handle_menu_action
             executeAction:execute_action
             inMain:true
             drawLineReference:menu_draw_line_reference
             hideLineReference:menu_hide_line_reference
             getPositions:get_menu_positions
             getSettingsPositions:get_menu_settings_positions
             mark:menu_mark_selected
             unmark:menu_unmark
             getAction:menu_get_action
             insub:false
           }
        
   
    
    return this


end function

function menu_render(menupositions) as Void
  
    if (menupositions=1)
        positions = m.getSettingsPositions()
    
    else
        positions = m.getPositions()
    endif
    total=positions.count()
    count=total-1

    cont=0
    items=[]
    
    
    position=m.position
   ' secuence=GetSecuence(position,total)
        
    for i=0 to count
    
    label=m.options[i].label    
        items.Push({
            Text:label
            TargetRect:positions[i]
            TextAttrs:{Color:"#ffffff",Font:m.app.menufont,HAlign:"center", VAlign:"VCenter",Direction:"LeftToRight"}
        '    url: "pkg:/images/bgmenuitem.png"
        })
   
    cont=cont+1
    end for
    
    if (menupositions<>2)
        bgurl="pkg:/images/bgmenu.png"
        if (IsHD())
        bgs={
            url:"pkg:/images/bgmenu.png",
            TargetRect:{x:-m.app.edge_left,y:0,w:435}
        }
        else
        bgs={
            url:"pkg:/images/bgmenu.png",
            TargetRect:{x:-m.app.edge_left,y:0,w:245}
        }
        endif
    endif

    m.positions=positions
    m.items=items

    if (menupositions<>2)
        m.canvas.SetLayer(100, bgs)
    endif
    m.canvas.SetLayer(101, items)
    


end function





function menu_mark_selected() as void
    
    items=m.items       
    selected=m.position
    
    
        for each i in items            
            i.textAttrs.Color="#ff444444"
        end for

            items[selected].textAttrs.Color="#ffffffff"

      m.canvas.setLayer(101,items)
      
end function


function menu_unmark() as void

       items=m.items
       for each i in items            
            i.textAttrs.Color="#ffffffff"
       end for
       
      m.canvas.setLayer(101,items)      

end function




function menu_set_options(items) as void
    m.options=items
    m.size=items.count()
end function



function menu_draw_line_reference() as void

    p=m.positions[m.position]

    'm.mark()
    line_y=p.y+(p.h-10)
    if (IsHD())
        if (m.app.inSettings)
            'print "in settings"
          
          linereference={color:"#ffffcc00",targetRect:{x:p.x+65,y:line_y,w:150,h:2}}
          'linereference={url:"pkg:/images/bgmenuitemhover.png"
          '                 targetRect:{x:p.x+65,
          '                             y:line_y,
          '                             w:150,
          '                             h:2}}
        else
         linereference={url:"pkg:/images/bgmenuitemhover.png"
                           targetRect:{x:p.x+65,
                                       y:line_y,
                                       w:150,
                                       h:2}}
        endif                                 
    else
       if (m.app.inSettings)
        linereference={color:"#ffffcc00",targetRect:{x:p.x+25,y:line_y,w:110,h:2}}
       else
        linereference={url:"pkg:/images/bgmenuitemhover.png"
                       targetRect:{x:p.x+25,
                                   y:line_y,
                                   w:110,
                                   h:2}}
       endif
    endif
    
    m.unmark()
    m.canvas.SetLayer(104, linereference)
end function





function menu_hide_line_reference() as void
    m.canvas.clearLayer(120)
end function



function handle_menu_action(index) as Void
'This function handles Vertical or Horizontal Navigation one at time

'print index
if (m.app.inSettings=0)
    dr = m.app.http.getWs("logState.php?userID="+m.app.getRegistry()+"&leftAt=main_menu")
    'print dr.done
endif
'PROCESS MAIN MENU
if(index=2 or index=3)

    m.app.soundFx()
    if(m.inMain)
    
    positions=m.positions
    total=positions.Count()
    items=m.items
    last=total-1
            if(index=2)
                
            'Down Remote Pressed
                     current=m.position-1
                    if(current<0)
                        current=last
                    end if
             else if(index=3)     
                      
            'Up Remote Pressed
                    current=m.position+1
                    if(current>last)
                        current=0
                    end if
             endif 
          
    m.position=current
    m.drawLineReference()
         
          
    end if 'End if in main


'HANDLES THE OK BUTTON
'Call to execute action from Section Manager
else if (index = 6 or index=5)
                        m.app.soundFx("click")
                        if(m.app.inNews=true) 
                                m.app.inNews=false
                        endif

                   
                        m.app.chronListener=false
                        m.executeAction()

                        
else if(index=4 or index=0 or index=7)
        'm.app.soundFx("click")
end if

end function






function execute_action() as Void
    
    m.inMain=false
'    selected=0
'    if(m.position<>0)      
'      selected=m.size-m.position
'    endif
    
    if (m.app.inSettings)
        p=m.positions[m.position]
        line_y=p.y+(p.h-10)
        if (isHD())
            m.canvas.SetLayer(104, {url:"pkg:/images/bgmenuitemhover.png"
                           targetRect:{x:p.x+65,
                                       y:line_y,
                                       w:150,
                                       h:2}})
        else
            m.canvas.SetLayer(104, {url:"pkg:/images/bgmenuitemhover.png"
                           targetRect:{x:p.x+25,
                                       y:line_y,
                                       w:110,
                                       h:2}})
        endif                                  
    endif
    
    'm.mark()
    selected=m.position
    
    if (selected=6)
        wsr="logCounterSubscribe.php?user_id="+m.app.userid+"&where_from=0"
        sr=m.app.http.getWs(wsr)
    end if
    selected=1
    m.app.section.setSection(selected)
    callback=m.options[selected].action
    params=m.options[selected].params
    m.hideLineReference()
    m.app.section.show(callback,params)
end function


function menu_get_action(index) as Object
        
    positions=m.positions
    total=positions.Count()
    items=m.items
    
    last=total-1
            if(index=2)
            'Down Remote Pressed
                     current=m.position-1
                    if(current<0)
                        current=last
                    end if
                    if m.app.trial and m.app.inSettings
                        if current=6
                            current=7
                        end if
                    end if
             else if(index=3)             
            'Up Remote Pressed
                    current=m.position+1
                    if(current>last)
                        current=0
                    end if
                    if m.app.trial and m.app.inSettings
                        if current=6
                            current=7
                        end if
                    end if
             endif 
        
        
        
    selected=current
    
    callback=m.options[selected].action
    params=m.options[selected].params
    
    action={
              action:callback
              params:params
           }
    
    return action
end function

function get_menu_positions() as object


positions=[]
items=m.options

'item_height=fix((m.app.safe_h-m.app.header_h-m.app.margin_top)/items.Count())
if (IsHD())
    item_height=80
    top=50
else
    item_height=53
    top=18
endif

total=items.count()
if(total>6)
    'top=0
    if (IsHD())
        item_height=70
    else    
        item_height=47
    endif
endif
y_=m.app.header_h+m.app.edge_top+m.app.margin_top+top



x_=fix(m.app.edge_left/2)


for each i in items    
    positions.Push({x:x_,y:y_,w:m.app.sidebar_width,h:item_height})
    y_=y_+item_height
end for

return positions


end function

function get_menu_settings_positions() as object


positions=[]
items=m.options

'item_height=fix((m.app.safe_h-m.app.header_h-m.app.margin_top)/items.Count())
if (IsHD())
    item_height=60
    top=50
else
    item_height=40
    top=18
endif

total=items.count()
if(total>6)
    'top=0
    if (IsHD())
        item_height=60
    else
        item_height=40
    endif
endif
y_=m.app.header_h+m.app.edge_top+m.app.margin_top+top



x_=fix(m.app.edge_left/2)


for each i in items    
    positions.Push({x:x_,y:y_,w:m.app.sidebar_width,h:item_height})
    y_=y_+item_height
end for

return positions


end function




