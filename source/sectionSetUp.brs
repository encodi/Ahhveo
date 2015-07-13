Function setup_section(s) as void

this={
     app:s.app
     canvas:s.app.canvas
     remoteCallback:setup_remote_callback
     setupPaint:setup_paint
     clearsetup:clear_setup
     setupPaintStatic:paint_static3
     paintTopMenuSelector:paint_top_menu_selector3
     paintSubTopMenuSelector:paint_subtop_menu_selector
     inTopMenu:true
     topMenuIndex:0
     subTopMenuIndex:0
     paintSection:paint_section
     paintFAQ:paint_faq
     clearFAQ:clear_faq
     clearUnderDev:clear_under_development
     paintHints:paint_hints
     clearHints:clear_hints
     paintAbout:paint_about
     clearAbout:clear_about
     paintArtist:paint_artist
     clearArtist:clear_artist
     paintPolicyTerms:paint_policy_terms
     clearPolicyTerms:clear_policy_terms
     paintPreferences:paint_preferences
     clearPreferences:clear_preferences
     paintAditional:paint_additional
     clearAditional:clear_additional
     isInFocus:false
     scrollingFocused:scrolling_focused
     }

this.setupPaint()
this.setupPaintStatic()

s.app.remoteListener=this

end Function



Function setup_paint() as void
    setupText = {text: "Under development.", textAttrs: {font: m.app.h1}, targetRect:{x:175,y:200,w:1000,h:200}}
    m.paintSection()
    m.topMenuIndex=2
    m.inTopMenu=true
    m.paintTopMenuSelector(m.topMenuIndex)
    'm.canvas.setLayer(50, setupText)
End Function



Function paint_static3() as void
    staticStuff=[]
    if (IsHD())
        logo={
            url:"pkg:/images/logo.png",
            TargetRect:{x:45,y:40,w:160,h:53}
        }
        exploremenu = {text: "Relax", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        sleepmenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
        preferencessubmenu = {text: "Preferences", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:110,y:120,w:200,h:50}}
        helpfulhintssubmenu = {text: "Helpful Hints", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:315,y:120,w:200,h:50}}
        artistsubmenu = {text: "About", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:520,y:120,w:200,h:50}}
        faqsubmenu = {text: "FAQ", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:645,y:120,w:200,h:50}}
        additionalsubmenu = {text: "Additional Time", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:765,y:120,w:200,h:50}}
        aboutsubmenu = {text: "About", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:520,y:120,w:200,h:50}}
        policytermssubmenu = {text: "Policy & Terms", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:1010,y:120,w:200,h:50}}
    else
        logo={
            url:"pkg:/images/logo.png",
            TargetRect:{x:45,y:40,w:160,h:53}
        
        }
        exploremenu = {text: "Relax", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        sleepmenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
        preferencessubmenu = {text: "Preferences", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:45,y:120,w:200,h:50}}
        helpfulhintssubmenu = {text: "Helpful Hints", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:250,y:120,w:200,h:50}}
        artistsubmenu = {text: "About", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:455,y:120,w:200,h:50}}
        faqsubmenu = {text: "FAQ", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:580,y:120,w:200,h:50}}
        additionalsubmenu = {text: "Additional Time", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:700,y:120,w:200,h:50}}
        aboutsubmenu = {text: "About", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:455,y:120,w:200,h:50}}
        policytermssubmenu = {text: "Policy & Terms", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:940,y:120,w:200,h:50}}
    endif
    '#9da2a6
    'staticStuff.push(logo)
    'staticStuff.push(exploremenu)
    'staticStuff.push(setupmenu)
    'staticStuff.push(sleepmenu)
    staticStuff.Push(preferencessubmenu)
    staticStuff.Push(helpfulhintssubmenu)
    staticStuff.Push(aboutsubmenu)
    staticStuff.Push(faqsubmenu)
    staticStuff.Push(additionalsubmenu)
    'staticStuff.Push(aboutsubmenu)
    staticStuff.Push(policytermssubmenu)
    m.canvas.setLayer(201, staticStuff)
    
End Function




''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' paints the selector for the top menu
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function paint_top_menu_selector3(topindex=0) as void

    pos_rings=[]
    
    pos_rings.push({x:425,y:90,w:180,h:2})
    pos_rings.push({x:625,y:90,w:180,h:2})
    pos_rings.push({x:825,y:90,w:180,h:2}) 
    
    if (m.inTopMenu)
        ring={
            url:"pkg:/images/ring_play_100.png",
            targetRect:pos_rings[topindex]
        }
    else
        ring={
            url:"pkg:/images/bgmenuitemhover.png",
            targetRect:pos_rings[topindex]
        }
    endif
    
    m.canvas.setLayer(42,ring)

End Function




Function paint_subtop_menu_selector(topindex=0) as void

    pos_rings=[]
    
    pos_rings.push({x:110,y:160,w:130,h:2})
    pos_rings.push({x:315,y:160,w:138,h:2})
    pos_rings.push({x:520,y:160,w:65,h:2}) 
    pos_rings.push({x:640,y:160,w:60,h:2})
    pos_rings.push({x:765,y:160,w:170,h:2})
    pos_rings.push({x:1005,y:160,w:165,h:2})
    'pos_rings.push({x:1080,y:160,w:160,h:2})
    
    if (NOT m.inTopMenu)
        ring={
            url:"pkg:/images/ring_play_100.png",
            targetRect:pos_rings[topindex]
        }
    else
        ring={
            url:"pkg:/images/bgmenuitemhover.png",
            targetRect:pos_rings[topindex]
        }
    endif
    
    m.canvas.setLayer(42,ring)
    

End Function



Function paint_section() as void

    print m.topMenuIndex
    m.clearHints()
    m.clearFAQ()
    m.clearAbout()
    m.clearArtist()
    m.clearPolicyTerms()
    m.clearPreferences()
    m.clearAditional()
    if (m.subTopMenuIndex=0)
        m.clearUnderDev()
        m.paintPreferences()
    else if (m.subTopMenuIndex=1)
        m.clearUnderDev()
        m.paintHints()
    else if (m.subTopMenuIndex=2)
        m.clearUnderDev()
        m.paintAbout()
    else if (m.subTopMenuIndex=3)
        m.clearUnderDev()
        m.paintFAQ()
    else if (m.subTopMenuIndex=4)
        m.clearUnderDev()
        m.paintAditional()
    else if (m.subTopMenuIndex=5)
        m.clearUnderDev()
        m.paintPolicyTerms()
    else if (m.subTopMenuIndex=6)
        m.clearUnderDev()
        m.paintPolicyTerms()
    else
        m.setupPaint()
    end if

End Function



function paint_preferences() as void
    settings=m.app.http.getWs("getSettings.php?user_id="+m.app.userid)
    
    if(type(settings)<>"roInvalid")
        m.shutoff_timer=settings.shutoff_timer
        m.start_shutoff_timer=m.shutoff_timer
        m.automatic_charge=settings.automatic_charge
        m.start_automatic_charge=m.automatic_charge
        m.available_time=settings.available_time
        m.app.globalvideotimer = settings.global_timer
    endif
    
    pref = []
    pref.push( {text:"Global Video Timer",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:290,x:110,y:200,h:100}} )
    pref.push( {text:"Choose the amount of time you want all videos to play",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:480,x:110,y:250,h:100}} )
    '
    'pref.push({url:"pkg:/images/rect.png",targetRect:{w:500,h:150,x:45,y:190}})
    pref.push({text:"<   0   > minutes",textAttrs:{font:m.app.h2},targetRect:{w:300,h:110,x:170,y:290}})
    pref.push( {text:"Auto-ShutOff",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:290,x:720,y:200,h:100}} )
    pref.push( {text:"Set a timer to turn of Ahhveo streaming automatically",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:480,x:720,y:250,h:100}} )
    '
    'pref.push({url:"pkg:/images/rect.png",targetRect:{w:500,h:150,x:690,y:190}})
    pref.push({text:"<   0   > hours",textAttrs:{font:m.app.h2},targetRect:{w:300,h:110,x:740,y:290}})
    pref.push({text:"THIS SETTINGS GOVERNS ALL DEVICES ON ACCOUNT",targetRect:{w:700,h:50,x:300,y:550}})
    hour = (m.available_time.toInt()/1000)/60/60
    minutes = (m.available_time.toInt()/1000)/60/60/60
    hr = Str(Fix(hour))
    min = Str(Fix(minutes))
    pref.push( {text:"Time Remaining: "+hr+" hours and "+min+" minutes",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:500,x:70,y:635,h:100}} )
    pref.push({text:"Token: "+m.app.getRegistry(),textAttrs:{HAlign:"Right",font:m.app.h3},targetRect:{w:250,x:960,y:599,h:100}})
    pref.push({url:"pkg:/images/rect.png",targetRect:{w:1190,h:40,x:45,y:625}})
    pref.push({text:"Build version: "+m.app.appInfo.GetVersion(),textAttrs:{font:m.app.h4},targetRect:{w:190,x:570,y:635,h:100}})
    
    m.canvas.setLayer(400, pref)

end function



function paint_faq() as void

    faq=m.app.http.getWs("getFaqs.php")
    if(type(faq)<>"roInvalid")
        content = []
        faqcontent = []
        separation = 0
        specialy = 0
        actualpage = 1
        totalpages = faq.content.count()-1
        For i=0 To faq.content.count()-1
            content.push(strReplace(faq.content[i],"\n",""))
            if (i=1)
                specialy = -30
            endif
            faqcontent.push({text:content[i],textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:530,x:80+separation,y:200 + specialy,h:500}})
            separation = separation + 600
        End For
        faqcontent.push({text:"< Page "+actualpage.toStr()+" of "+totalpages.toStr()+" >",textAttrs:{font:m.app.h3},targetRect:{w:200,h:50,x:550,y:650}})
        m.canvas.setLayer(400, faqcontent)
    endif

end function



function paint_hints() as void
    
    hints=m.app.http.getWs("getHints.php")
    if(type(hints)<>"roInvalid")
        print hints
        content = []
        hintscontent = []
        separation = 0
        specialy = 0
        actualpage = 1
        totalpages = hints.content.count()-1
        For i=0 To hints.content.count()-1
            content.push(strReplace(hints.content[i],"\n",""))
            if (i=1)
                specialy = -30
            endif
            hintscontent.push({text:content[i],textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:530,x:80+separation,y:200 + specialy,h:500}})
            separation = separation + 600
        End For
        hintscontent.push({text:"Page "+actualpage.toStr()+" of "+totalpages.toStr(),textAttrs:{font:m.app.h3},targetRect:{w:200,h:50,x:550,y:650}})
        m.canvas.setLayer(400, hintscontent)
    endif

End function


function paint_additional() as void
    
    addi = []
    settings=m.app.http.getWs("getSettings.php?user_id="+m.app.userid)
    
    if(type(settings)<>"roInvalid")
        m.shutoff_timer=settings.shutoff_timer
        m.start_shutoff_timer=m.shutoff_timer
        m.automatic_charge=settings.automatic_charge
        m.start_automatic_charge=m.automatic_charge
        m.available_time=settings.available_time
        m.app.globalvideotimer = settings.global_timer
    endif
    
    
    addi.push({text:"Buy Additional Time",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:300,h:50,x:550,y:230}})
    addi.push({text:"You can change subscription any time from the following options: $3.99 for 25 hours, and $7.99 for 50 hours. The moment you resubscribe you will get changed and will start the subscription from day one.",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h4},targetRect:{w:1180,h:50,x:45,y:290}})
    addi.push({text:"Change Subscription",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:300,h:50,x:550,y:380}})
    
    addi.push({text:"THIS SETTINGS GOVERNS ALL DEVICES ON ACCOUNT",targetRect:{w:700,h:50,x:300,y:550}})
    hour = (m.available_time.toInt()/1000)/60/60
    minutes = (m.available_time.toInt()/1000)/60/60/60
    hr = Str(Fix(hour))
    min = Str(Fix(minutes))
    addi.push( {text:"Time Remaining: "+hr+" hours and "+min+" minutes",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:500,x:70,y:635,h:100}} )
    addi.push({text:"Token: "+m.app.getRegistry(),textAttrs:{HAlign:"Right",font:m.app.h3},targetRect:{w:250,x:960,y:599,h:100}})
    addi.push({url:"pkg:/images/rect.png",targetRect:{w:1190,h:40,x:45,y:625}})
    addi.push({text:"Build version: "+m.app.appInfo.GetVersion(),textAttrs:{font:m.app.h4},targetRect:{w:190,x:570,y:635,h:100}})
    
    m.canvas.setLayer(400, addi)
    
end function


function paint_about() as void
    artistscontent = []
    about=m.app.http.getWs("getAbout.php")
    if(type(about)<>"roInvalid")
        content=strReplace(about.content,"\n","")
        artistscontent.push( {text:content,textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:590,x:650,y:200,h:500}} )
        'm.canvas.setLayer(400, aboutcontent)
    endif

    artists=m.app.http.getWs("getArtist.php")
    if(type(artists)<>"roInvalid")
        
        content=strReplace(artists.content,"\n","")
        artistscontent.push({text:content,textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:550,x:45,y:360,h:500}})
        artistscontent.push({url:"pkg:/images/peter_roberts_logo.png",targetRect:{w:110,h:30,x:350,y:200}})
        artistscontent.Push({text:"'I work to capture the magic of idyllic locations and deliver it to people's homes.'",textAttrs:{font:m.app.h5},targetRect:{w:235,h:235,x:300,y:180}})
        artistscontent.push({ url:artists.image,targetRect:{w:200,h:200,x:45,y:200}})
        m.canvas.setLayer(400, artistscontent)
    endif
End function



function paint_artist() as void
    
    artists=m.app.http.getWs("getArtist.php")
    if(type(artists)<>"roInvalid")
        artistscontent = []
        content=strReplace(artists.content,"\n","")
        artistscontent.push({text:content,textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:900,x:300,y:200,h:500}})
        artistscontent.push({url:"pkg:/images/peter_roberts_logo.png",targetRect:{w:110,h:30,x:100,y:490}})
        artistscontent.Push({text:"'I work to capture the magic of idyllic locations and deliver it to people's homes.'",textAttrs:{font:m.app.h5},targetRect:{w:235,h:235,x:45,y:450}})
        artistscontent.push({ url:artists.image,targetRect:{w:235,h:235,x:45,y:250}})
        m.canvas.setLayer(400, artistscontent)
    endif

End function


function paint_policy_terms() as void
    if (m.app.trial)
        privacy=m.app.http.getWs("getTerms.php?tostype=7")
        terms.content[0] = " "
    else
        terms=m.app.http.getWs("getTerms.php?tostype=11")
        privacy=m.app.http.getWs("getPrivacy.php")
    endif
    
    if(type(privacy)<>"roInvalid" AND type(terms)<>"roInvalid")
        content = []
        privacycontent = []
        termscontent = []
        datacontent = []
        separation = 0
        specialy = 0
        actualpage = 1
        print type(terms)
        print terms
        if (terms.content[0]=" ")
            content = []
            totalpages = privacy.content.count() - 1
            for i=0 to privacy.content.count()-1
                content.push(strReplace(privacy.content[i],"\n",""))
            endfor
        else
            totalpages = privacy.content.count() + terms.content.count() - 1
            j = 0
            content = []
            for i=0 to privacy.content.count()-1
                content.push(strReplace(privacy.content[i],"\n",""))
            endfor
            for i=0 to terms.content.count()-1
                content.push(strReplace(terms.content[i],"\n",""))
            endfor
        endif
        For i=0 To content.count()-1
            'content.push(strReplace(privacy.content[i],"\n",""))
            datacontent.push({text:content[i],textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:530,x:80+separation,y:200 + specialy,h:500}})
            separation = separation + 600
        End For
        datacontent.push({text:"Page "+actualpage.toStr()+" of "+totalpages.toStr(),textAttrs:{font:m.app.h3},targetRect:{w:200,h:50,x:550,y:650}})
        m.canvas.setLayer(400, datacontent)
    endif

end function


function scrolling_focused() as void
    
    
    
end function


function setup_remote_callback(index) as void
    print index 
    if (index=2) then
        m.inTopMenu=true
        m.topMenuIndex=2
        m.paintTopMenuSelector(m.topMenuIndex)
    else if (index=3) then
        m.inTopMenu=false
        m.paintSubTopMenuSelector()
    else if (index=4) then ' left
        if (m.topMenuIndex>0 AND m.inTopMenu)
            m.topMenuIndex = m.topMenuIndex - 1
            m.paintTopMenuSelector(m.topMenuIndex)
            if (m.topMenuIndex=1)                
                m.clearSetup()
                sm = sectionManager(m.app)
                sm.show(places_section)
            endif
        else if (m.subTopMenuIndex>0 AND NOT m.inTopMenu)
            m.subTopMenuIndex = m.subTopMenuIndex - 1
            m.paintSubTopMenuSelector(m.subTopMenuIndex)
            m.paintSection()
        endif
    else if (index=5) then ' right
        if (m.topMenuIndex<2 AND m.inTopMenu)
            m.topMenuIndex = m.topMenuIndex + 1
            m.paintTopMenuSelector(m.topMenuIndex)
        else if (m.subTopMenuIndex<5 AND NOT m.inTopMenu)
            m.subTopMenuIndex = m.subTopMenuIndex + 1
            m.paintSubTopMenuSelector(m.subTopMenuIndex)
        endif
        m.paintSection()
    else if (index=6) then
    
       'm.app.setLogo()
       'm.app.setBackground()
       if (m.inTopMenu)
            if (m.topMenuIndex=0)
               m.clearsetup()
               m.app.section.show(sleep_section)
               m.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
            else if (m.topMenuIndex=1)
               m.clearsetup()
               m.app.isPlaces=true
               m.app.section.show(places_section)
               m.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
            endif
       endif
       
    
    else if (index=7) then
       'm.app.setLogo()
       'm.app.setBackground()
       m.clearsetup()
       m.app.isPlaces=true
       m.app.section.show(places_section)
       m.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
    end if
end function


function clear_setup() as void
    m.canvas.clearLayer(50)
    'm.canvas.clearLayer(36)
    m.canvas.clearLayer(201)
    m.canvas.clearLayer(42)
    m.canvas.clearLayer(400)
end function


function clear_under_development() as void
    m.canvas.clearLayer(50)
end function

function clear_faq() as void
    m.canvas.clearLayer(400)
end function

function clear_hints() as void
    m.canvas.clearLayer(400)
end function

function clear_about() as void
    m.canvas.clearLayer(400)
end function

function clear_artist() as void
    m.canvas.clearLayer(400)
end function

function clear_policy_terms() as void
    m.canvas.clearLayer(400)
end function

function clear_preferences() as void
    m.canvas.clearLayer(400)
end function

function clear_additional() as void
    m.canvas.clearLayer(400)
end function