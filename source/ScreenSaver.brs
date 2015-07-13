Function RunScreenSaver()

   
    this={
         showScreensaver:saver_show_screensaver
         hideScreensaver:saver_hide_screensaver
         randomizeScreensaver:saver_randomize_screensaver
         port:CreateObject("roMessagePort")
         timer:CreateObject("roTimespan")
         randomtime:5000
         lasttime:timer+randomtime
         canvas:CreateObject("roImageCanvas")
         native:true
         }
         
    this.canvas.SetMessagePort(port)
    this.showScreensaver()
   ' this.randomizescreensaver()
    this.canvas.show()
    
    
    while true
    
        msg=wait(340,this.port)
        
        if msg<>Invalid
                
                if(msg.isRemoteKeyPressed())
                    this.hideScreensaver()
                    m.app.sleeping=false
                exit while
        
                endif
        endif
        
            if(this.lasttime<this.timer.TotalMilliseconds())
                   'this.randomizeScreensaver()
                   this.lasttime=this.timer.TotalMilliseconds()+this.randomtime
            endif
    
    end while
    
    
    
    
end Function



function saver_show_screensaver() as void
    
    m.canvas.SetLayer(502,{color:"#000000"})
    
    'm.radomizeScreenSaver()
    
end function

function saver_randomize_screensaver(ss_image_url="/pkg:images/screensaver_logo_ocean.png") as void
    
    
    
    info=CreateObject("roDeviceInfo")
    size=info.GetDisplaySize()    
    w_=size.w
    h_=size.h
    
    if IsHD()
        x_=Rnd(w_-263)
        y_=Rnd(h_-24)
    else
        x_=Rnd(w_-148)
        y_=Rnd(h_-16)
    endif
    m.canvas.setLayer(502,{Color:"#000204",CompositionMode: "Source"})
    if IsHD()
        m.canvas.SetLayer(503,{url:ss_image_url,targetRect:{x:x_,y:y_,w:263,h:24}})
    else
        m.canvas.SetLayer(503,{url:ss_image_url,targetRect:{x:x_,y:y_,w:148,h:16}})
    endif
    
    m.canvas.show()

end function




function saver_hide_screensaver() as void
    if(type(m.native)<>Invalid)
        m.canvas.clearLayer(502)
        m.canvas.clearLayer(503)
    else
        m.canvas.clearLayer(502)
        m.canvas.clearLayer(503)
    endif
end function