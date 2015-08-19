function settings_terms(s) as object

    this={
          section:s
          remoteCallBack:settings_terms_remote_callback
          init:settings_terms_init
          canvas:s.canvas
          app:s.app
          remaining:60
          position:0
          selected:0
          enabled:false
          onReturn:settings_terms_on_return
          scrollVertical:settings_terms_scroll
          goBack:settings_terms_go_back
          validateAgree:settings_terms_validate_agree
         }
         
        
return this    
end function



function settings_terms_init(parent=false) as void

    m.parent=parent
    

    size=m.app.size
    sb_w=m.app.sidebar_width
    edge_top=m.app.edge_top
    center_x=sb_w+Fix((size.w-sb_w)/2)
    
    if IsHD()
        margin_right=50
    else
        margin_right=28
    endif
    w_=(size.w-sb_w)-(margin_right*2)
    x_=sb_w+margin_right
    if IsHD()
        y_=50+edge_top
    else
        y_=33+edge_top
    endif
    w_m=fix((size.w-sb_w)/2)
    
    w_aux=w_
        
    items=[]
    
    positions=[]
    
    if IsHD()
        header1_rect={x:x_,y:y_,w:w_,h:50}
    else
        header1_rect={x:x_,y:y_,w:w_,h:33}
    endif
    w_m=fix((size.w-sb_w)/2)
    if IsHD()
        y_=y_+80
    else
        y_=y_+53
    endif
    
    w_=w_-(margin_right*2)
    x_=x_+margin_right

    m.w_=w_
    m.x_=x_
    m.start_y=y_
    m.scroll=y_
    
    if m.app.trial then
        if (m.app.tos)
            items.push({text:"Terms of Use & Privacy Policy Free Version",textAttrs:{font:m.app.h2},targetRect:header1_rect})
        else 
            if m.app.tos=false and m.app.trial and m.app.seeterms=false and m.app.seepolicy=false
                items.push({text:"Terms of Use & Privacy Policy Free Version",textAttrs:{font:m.app.h2},targetRect:header1_rect})
            else
                 items.push({text:"Terms of use",textAttrs:{font:m.app.h2},targetRect:header1_rect})
            endif
        endif
    else
        items.push({text:"Terms of use",textAttrs:{font:m.app.h2},targetRect:header1_rect})
    endif
    
    items.push({url:"pkg:/images/rect.png",targetRect:header1_rect})
    
    m.canvas.setLayer(52,items)
    
    if IsHD()
        m.canvas.SetLayer(51, { Color: "#343434", CompositionMode: "Source",targetRect:{w:w_,h:159,x:x_,y:0}})
    else
        m.canvas.SetLayer(51, { Color: "#343434", CompositionMode: "Source",targetRect:{w:w_,h:106,x:x_,y:0}})
    endif
    
    if IsHD()
        scroll_x=sb_w+w_aux+40
    else
        scroll_x=sb_w+w_aux+23
    endif
    m.scroll_x=scroll_x
    if IsHD()
        scroll_y=155
    else
        scroll_y=113
    endif
    m.start_scroll_y=scroll_y
    m.scroll_y=scroll_y
    if IsHD()
        scroll_height=m.app.size.h-200
    else
        scroll_height=m.app.size.h-133
    endif
    m.scroll_height=scroll_height
    
    if m.app.trial then
        if (m.app.tos)
            tos=m.app.http.getWs("getTerms.php?tostype=11")
        else
            if m.app.tos=false and m.app.trial and m.app.seeterms=false and m.app.seepolicy=false
                tos=m.app.http.getWs("getTerms.php?tostype=11")
            else
                tos=m.app.http.getWs("getTerms.php?tostype=7")
            endif
        endif
    else
        tos=m.app.http.getWs("getTerms.php?tostype=7")
    endif
    
    
    
    if(type(tos)<>"roInvalid")
    
        content=strReplace(tos.content,"\n","")
        
        if IsHD()
            f=m.app.fonts.GetFont("HelveticaNeueLT Std Lt",28,false,false)
        else
            f=m.app.fonts.GetFont("HelveticaNeueLT Std Lt",16,false,false)
        endif
    '    f=m.app.fonts.GetDefaultFont(27,false,false)
        lnw=f.getOneLineWidth(content,1000000000)
        lnh=f.getOneLineHeight()
        total_lines=lnw/w_
        
        if(type(tos.salts)<>"roInvalid")
            salts=tos.salts
        endif
        

        height=Fix(total_lines*lnh)+(lnh*salts)
        
        m.height=height
        m.lineheight=lnh
        m.content=content
        m.scrollVertical()
        if IsHD()
            if(height>scroll_height)m.canvas.setLayer(53,{Color:"#FFFFFF",compositionMode:"Source",targetRect:{w:2,h:scroll_height,y:155,x:scroll_x}})       
        else
            if(height>scroll_height)m.canvas.setLayer(53,{Color:"#FFFFFF",compositionMode:"Source",targetRect:{w:2,h:scroll_height,y:113,x:scroll_x}})
        endif
    endif
    dr = m.app.http.getWs("logState.php?userID="+m.app.getRegistry()+"&leftAt=terms_of_use")
    
end function




function settings_terms_remote_callback(index) as void

    'Do nothing when in main
    if m.app.menu.inMain return
    
    'print "Terms of Use"
    'print index
    'print "-------"    
    
    if (index=5 or index=6) return

            y_=m.scroll
            lnh=m.lineheight
            height=m.height
            if IsHD()
                maxbottom=m.app.size.h-150
                if m.app.trial = true maxbottom = m.app.size.h+50
                v_step=lnh*18 ' this is the magic to move down the lines of text
            else
                maxbottom=m.app.size.h+500
                if m.app.trial = true maxbottom=m.app.size.h-50
                v_step=lnh*18 ' this is the magic to move down the lines of text
            endif
            
            
            scroll_y=m.scroll_y
            scroll_h=m.scroll_height
            s_step=Fix((scroll_h*v_step)/height)
            
            
            
            if(index=2)
                    'Up
                   if(y_<m.start_y)
                        y_=y_+v_step
                        scroll_y=scroll_y-s_step
                        if((y_+v_step)>m.start_y)scroll_y=m.start_scroll_y
                   endif
            else if(index=3)
                    'Down
                    'print maxbottom
                    'print "<"
                    'print y_+height
                    if(maxbottom<y_+height)
                        y_=y_-v_step
                        
                        scroll_y=scroll_y+s_step                        
                        
                        if IsHD()
                            if(maxbottom>y_+height)scroll_y=m.start_scroll_y+m.scroll_height-30
                        else
                            if(maxbottom>y_+height)scroll_y=m.start_scroll_y+m.scroll_height-20
                        endif
                    endif
            else if(index=4)
                  m.goBack()
                  return        
            endif
           
            m.scroll=y_
            m.scroll_y=scroll_y
            m.scrollVertical()


end function



function settings_terms_scroll() as void


    
    privacy={text:m.content,textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:m.w_,x:m.x_,y:m.scroll,h:m.height}}
    
    if IsHD()
        scroll={Color:"#ffffff",TargetRect:{w:11,h:30,x:m.scroll_x-5,y:m.scroll_y}}
    else
        scroll={Color:"#ffffff",TargetRect:{w:6,h:20,x:m.scroll_x-3,y:m.scroll_y}}
    endif
    m.canvas.setLayer(50,privacy)
    if(m.height>m.scroll_height)m.canvas.setLayer(54,scroll) 

end function





'This function will be called after the below function settings_terms_go_back()
function settings_terms_on_return(index) as boolean          
          return m.validateAgree()
end function





function settings_terms_go_back() as void
        m.parent.remoteCallback(7)
end function





function settings_terms_validate_agree() as boolean
    if(m.app.tos=false and m.app.trial)    
        if m.app.seeterms=false and m.app.seepolicy=false 
            dr = m.app.http.getWs("logState.php?userID="+m.app.getRegistry()+"&leftAt=trial_popup")
            ws="getPopup.php?id=5"
            popup=m.app.http.getWs(ws)
            r3=m.app.dialog.optional({text:popup[0].content,options:[popup[0].option_1,popup[0].option_2,popup[0].option_3]})                               
            if(r3=2)
                if m.app.seeterms=false and m.app.seepolicy=false
                    m.app.exploreAhhveo()
                else 
                    m.app.subscribe(m.app.st)
                endif
                'm.goBack()
                return false
            else if(r3=1)
                m.parent.params={subaction:settings_terms}
                m.parent.app.menu.position=7
                m.parent.app.menu.inMain=false
                m.parent.app.menu.drawLineReference()
                m.parent.app.menu.mark()
                m.parent.handleAction(m.parent)
                return false
            else if (r3=0)
                if m.app.tos=false and m.app.trial and m.app.seeterms=false and m.app.seepolicy=false
                    m.app.tosAgree()
                else 
                    m.app.subscribe(m.app.st)
                endif
                return false
            else 
                if m.app.tos=false and m.app.trial and m.app.seeterms=false and m.app.seepolicy=false
                    m.app.exploreAhhveo()
                else 
                    m.app.subscribe(m.app.st)
                endif
                return false
            endif
        else
            m.app.subscribe(m.app.st)
            return false
        endif
        
                                       
    endif

    return true
end function