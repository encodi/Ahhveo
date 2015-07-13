function settings_about(s) as object

    this={
          section:s
          remoteCallBack:settings_about_remote_callback
          init:settings_about_init
          canvas:s.canvas
          app:s.app
          remaining:60
          position:0
          selected:0
          enabled:false
          onReturn:settings_about_on_return
          scrollVertical:settings_about_scroll
          goBack:settings_about_go_back
         }
         
        
return this    
end function



function settings_about_init(parent=false) as void

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
    if (IsHD())
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

    items.push({text:"About Ahhveo",textAttrs:{font:m.app.h2},targetRect:header1_rect})
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
        scroll_y=103
    endif
    m.start_scroll_y=scroll_y
    m.scroll_y=scroll_y
    if IsHD()
        scroll_height=m.app.size.h-200
    else
        scroll_height=m.app.size.h-133
    endif
    m.scroll_height=scroll_height
    
  
    tos=m.app.http.getWs("getAbout.php")
    
    
    
    if(type(tos)<>"roInvalid")
    
        content=strReplace(tos.content,"\n","")

        f=m.app.fonts.GetFont("HelveticaNeueLT Std Lt",28,false,false)
      '  f=m.app.fonts.GetDefaultFont(27,false,false)
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
            'if(height>scroll_height)m.canvas.setLayer(53,{Color:"#FFFFFF",compositionMode:"Source",targetRect:{w:2,h:scroll_height,y:103,x:scroll_x}})
        endif
    endif
    
end function




function settings_about_remote_callback(index) as void

    'Do anything when in main
    if m.app.menu.inMain return


            y_=m.scroll
            lnh=m.lineheight
            height=m.height
            if IsHD()
                maxbottom=m.app.size.h-200
            else
                maxbottom=m.app.size.h-100
            endif
            
            v_step=lnh*3
            
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
            if IsHD()
                m.scrollVertical()
            endif


end function



function settings_about_scroll() as void


    
    privacy={text:m.content,textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:m.w_,x:m.x_,y:m.scroll,h:m.height}}
    
    if IsHD()
        scroll={Color:"#ffffff",TargetRect:{w:11,h:30,x:m.scroll_x-5,y:m.scroll_y}}
    else
        scroll={Color:"#ffffff",TargetRect:{w:6,h:20,x:m.scroll_x-3,y:m.scroll_y}}
    endif
    m.canvas.setLayer(50,privacy)
    'if(m.height>m.scroll_height)m.canvas.setLayer(54,scroll)    

end function





function settings_about_on_return(index) as boolean
    return true
end function


function settings_about_go_back() as void
    m.parent.remoteCallback(7)
end function
