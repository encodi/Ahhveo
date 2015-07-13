Function information_section(s) as void


this={
     app:s.app
     canvas:s.app.canvas
     menu:s.app.menu
     remoteCallBack:information_handle_remote
     goBack:information_go_main
     handleAction:information_handle_action
     }


settings_menu=[]

settings_menu.Push({action:information_handle_action,label:"Helpful Hints",params:{subaction:settings_viewing_hints}})
settings_menu.Push({action:information_handle_action,label:"FAQ",params:{subaction:settings_faqs}})
settings_menu.Push({action:information_handle_action,label:"Tutorials",params:{subaction:settings_faqs}})
settings_menu.Push({action:information_handle_action,label:"About",params:{subaction:settings_about}})
settings_menu.Push({action:information_handle_action,label:"Artist",params:{subaction:settings_artist}})
settings_menu.Push({action:information_handle_action,label:"Privacy Policy",params:{subaction:settings_privacy}})
settings_menu.Push({action:information_handle_action,label:"Terms of Use",params:{subaction:settings_terms}})

s.app.menu.setOptions(settings_menu)
s.app.menu.render(1)

's.app.forceSection()
s.app.remoteListener=this

's.app.menu.drawLineReference()
'Manually call to preferences section

if this.app.tos=false and this.app.trial and s.app.seeterms=false and s.app.seepolicy=false
    s.params={subaction:settings_terms}
    s.app.menu.position=7
    s.app.menu.inMain=false
else if this.app.trial and s.app.seeterms
    this.app.tos=false
    s.params={subaction:settings_terms}
    s.app.menu.position=7
    s.app.menu.inMain=false
else if this.app.trial and s.app.seepolicy
    this.app.tos=false
    s.params={subaction:settings_privacy}
    s.app.menu.position=6
    s.app.menu.inMain=false
else
    s.params={subaction:settings_viewing_hints}
    s.app.menu.position=0
    s.app.menu.inMain=true
    s.app.menu.insub=false
endif

s.app.inSettings=true
s.app.menu.drawLineReference()
's.app.menu.mark()
this.handleAction(s)
s.app.loadonchange=true

end Function

'This is very abstract
'Firsts associates the settings remote handler
function information_handle_remote(index) as void


    'Handling the return buttons from remote
    'In this case the focus is still in the main menu
    
    if(index=2 or index=3)
              if(m.app.menu.inMain)
                o=m.app.menu.getAction(index)
                m.app.menu.insub=false
                m.app.section.show(o.action,o.params)
              'else if (m.app.trial=false) 
              '  o=m.app.menu.getAction(index)
              '  m.app.section.show(o.action,o.params)
              endif
    else if index=7 or index=0
    
        r=true
        
        if(type(m.remoteChildrenListener)<>"Invalid")
            if(type(m.remoteChildrenListener.onReturn)="roFunction")r=m.remoteChildrenListener.onReturn(index)
        endif
        if(r=false) return
            m.app.menu.inMain=true
            m.app.menu.drawLineReference()
            
            if(index=0)
                m.goBack()
            else
                m.goBack()
            endif
    else if index=4
        
        if(m.insub=Invalid)
            m.goBack()
        else if m.insub=false
            m.goBack()
        endif
        m.app.menu.unmark()
    else if index=5 or index=6
        m.app.menu.insub=true
    endif

    
    'Associates the children (such as Preferences, FAQ, About, Artist) remote listener to main event
    if(type(m.remoteChildrenListener)="roAssociativeArray") m.remoteChildrenListener.remoteCallback(index)


end function



function information_handle_action(s) as void
    
   'Handles the submenu option selected
   'And associates it children remote listener
    subsection=s.params.subaction(s)
    this={
          app:s.app
          goBack:information_go_back
          goMain:information_go_main
          remoteCallBack:information_handle_remote
          remoteChildrenListener:subsection
          handleAction:information_handle_action
          canvas:s.app.canvas
         }
         
    s.app.remoteListener=this
    'This is a fix for preserve the remoteListener after load the News section
    'This value will recover in the settings_go_back function
    this.app.cachelistener=this

    m.subsection=subsection
    subsection.init(this)
    
    

end function





function information_go_back() as void

    if(m.app.menu.inMain)
            if(m.app.menu.insub=false)
                m.app.menu.inMain=true
                m.goMain()
            else if (m.app.menu.insub=true)
                m.app.menu.insub=false
            else    
                m.app.menu.inMain=true
                m.goMain()                
            endif
     else
        m.inMain=true
        m.app.menu.drawLineReference()
    endif

end function




function information_go_main() as void

       items=[]
       'items.push({action:relaxnow_section,label:"Relax"})
       
       items.push({action:sleep_section,label:"Sleep"})
       items.push({action:places_section,label:"Relax"})
       items.push({action:customize_section,label:"Set Up"})
       'items.push({action:information_section,label:"Information"})
       'items.push({action:shop_section,label:"Shop Ahhveo"})
       'items.push({action:settings_section,label:"Settings"})
       if(m.app.trial)items.push({action:subscribenow_section,label:"Subscribe Now"})
                   
       m.app.loadonchange=false
       m.app.menu.inMain=true
       m.app.menu.setOptions(items)
       m.app.menu.position=3
       m.app.menu.render(0)
       m.app.inSettings=false
       m.app.menu.drawLineReference()
       'm.app.menu.mark()
       m.app.remoteListener=false
       ' this moves user to main menu with news and home screen on
       m.app.inNews=true
       
       m.app.section.show(home_section)
       m.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
       'm.app.remoteListener=m.app.cachelistener
end function



