
Function sectionManager(app) as object

    manager=CreateObject("roAssociativeArray")
    
    manager.home=home_section
    manager.Moods=moods_section
    manager.http=NewHttp(app)
    manager.app=app
    manager.canvas=app.canvas
    manager.show=show_section
    manager.section=0
    manager.setSection=set_section
    manager.clear=clear_section
    app.canvas.setRequireAllImagesToDraw(false)
  
    return manager
      
End Function


function set_section(s)
m.section=s
end function


function clear_section()

'Clear the main Layer 1 where are the sections
m.canvas.clearLayer(1)
'Clear the carousel main items layer
m.canvas.clearLayer(2)

'Clear all the dynamic layers
for i=7 to 74
m.canvas.clearLayer(i)
endfor

'Tooltip and parents layer
'm.canvas.clearLayer(81)
'm.canvas.clearLayer(82)
m.canvas.clearLayer(83)
m.canvas.clearLayer(84)
m.canvas.clearLayer(85)
m.canvas.clearLayer(86)
m.canvas.clearLayer(87)
m.canvas.clearLayer(88)
m.canvas.clearLayer(89)
m.canvas.clearLayer(90)
m.canvas.clearLayer(91)


m.app.remoteListener=false
end function


Function show_section(cb,params=false) as Void

    m.clear()
    s=m.section
    m.app.menu.continue=false

    m.params=params
        
    if(type(cb)="Function" or type(cb)="roFunction") cb(m)

    return     
end function








