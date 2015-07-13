function settings_artist(s) as object

    this={
          section:s
          remoteCallBack:settings_artist_remote_callback
          init:settings_artist_init
          canvas:s.canvas
          app:s.app
          remaining:60
          position:0
          selected:0
          enabled:false
          onReturn:settings_artist_on_return
          scrollVertical:settings_artist_scroll
          goBack:settings_artist_go_back
         }
         
        
return this    
end function



function settings_artist_init(parent=false) as void

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
        y_=y_+79
    endif
    
    if IsHD()
        header2_rect={x:x_+70,y:y_+340,w:180,h:38}
        header3_rect={x:x_+65,y:y_+280,w:215,h:50}
    else
        header2_rect={x:x_+39,y:y_+220,w:101,h:25}
        header3_rect={x:x_+37,y:y_+177,w:121,h:33}
    endif
    
    w_=w_-(margin_right*2)
    x_=x_+margin_right

    m.w_=w_
    m.x_=x_
    m.start_y=y_
    if IsHD()
        m.scroll=y_+255
    else
        m.scroll=y_+170
    endif
    items.push({text:"Artist",textAttrs:{font:m.app.h2},targetRect:header1_rect})
    items.push({url:"pkg:/images/rect.png",targetRect:header1_rect})
    
    items.push({url:"pkg:/images/peter_roberts_logo.png",targetRect:header2_rect})
    
    items.Push({text:"'I work to capture the magic of idyllic locations and deliver it to people's homes.'",textAttrs:{font:m.app.h5},targetRect:header3_rect})
    m.canvas.setLayer(52,items)
    
    if IsHD()  
        m.canvas.SetLayer(51, { Color: "#343434", CompositionMode: "Source",targetRect:{w:w_,h:159,x:x_,y:0}})
        scroll_x=sb_w+w_aux+40
    else
        m.canvas.SetLayer(51, { Color: "#343434", CompositionMode: "Source",targetRect:{w:w_,h:106,x:x_,y:0}})
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
    
  
    tos=m.app.http.getWs("getArtist.php")
    
    
    
    if(type(tos)<>"roInvalid")
    
        content=strReplace(tos.content,"\n","")

        f=m.app.fonts.GetFont("HelveticaNeueLT Std Lt",28,false,false)
    '    f=m.app.fonts.GetDefaultFont(25,false,false)
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
           ' if(height>scroll_height)m.canvas.setLayer(53,{Color:"#FFFFFF",compositionMode:"Source",targetRect:{w:2,h:scroll_height,y:103,x:scroll_x}})
        endif
        if(type(tos.image)<>"Invalid")
            if IsHD()
                m.canvas.SetLayer(55, { url:tos.image,targetRect:{w:235,h:235,x:x_,y:200}})
            else
                m.canvas.SetLayer(55, { url:tos.image,targetRect:{w:132,h:157,x:x_,y:133}})
            endif
        endif
    
    endif
    
end function




function settings_artist_remote_callback(index) as void

            if(index=4)
                   m.goBack()
                   return
            endif
end function



function settings_artist_scroll() as void
    
    if IsHD()
        privacy={text:m.content,textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:580,x:m.x_+250,y:145,h:820}}
        scroll={Color:"#ffffff",TargetRect:{w:11,h:30,x:m.scroll_x-5,y:m.scroll_y}}
    else
        privacy={text:m.content,textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:326,x:m.x_+141,y:97,h:547}}
        'scroll={Color:"#ffffff",TargetRect:{w:6,h:20,x:m.scroll_x-3,y:m.scroll_y}}
    endif
    m.canvas.setLayer(50,privacy)
    if IsHD()
        if(m.height>m.scroll_height)m.canvas.setLayer(54,scroll)      
    endif
end function





function settings_artist_on_return(index) as boolean
    return true
end function


function settings_artist_go_back() as void
    m.parent.remoteCallback(7)
end function


