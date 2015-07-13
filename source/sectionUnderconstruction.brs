function underconstruction(s) as void


    
    tp=FIX(s.app.size.h/2)
    s.app.canvas.setLayer(1,{text:"In Development",
                             textAttrs:{HAlign:"center",font:"Huge"},
                             targetRect:{x:150,y:tp,w:1200,h:80}
                             })


s.app.remoteListener=UnderConstructionRemoteListener(s)

end function


function UnderConstructionRemoteListener(s) as object

    this={
            app:s.app
            remoteCallBack:under_construction_remote_callback
         }

    return this


end function


function under_construction_remote_callback(index) as void
    if(index=0)
       m.app.menu.inMain=true
       m.app.menu.drawLineReference()
    endif
end function