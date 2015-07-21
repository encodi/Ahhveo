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
     paintPreferenceSelector:paint_preference_selector
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
     inSubTopMenu:false
     inPreferences:false
     inAutoShutOff:false
     inBuyAdditionalTime:false
     inChangeSubscription:false
     inFAQFocus:false
     inPolicyFocus:false
     scrollingFocused:scrolling_focused
     globalvideotime:5
     autoshutoff:0.5
     page:1
     faqpage:0
     pppage:0
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
        bgmenu = {url:"pkg:/images/bgmenunew2.png", TargetRect:{x:0,y:165,w:1280,h:80}}
        exploremenu = {text: "Relax", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        sleepmenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
        preferencessubmenu = {text: "Settings", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:110,y:120,w:200,h:50}}
        helpfulhintssubmenu = {text: "Helpful Hints", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:365,y:120,w:200,h:50}}
        artistsubmenu = {text: "About", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:520,y:120,w:200,h:50}}
        faqsubmenu = {text: "FAQ", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:833,y:120,w:200,h:50}}
        'additionalsubmenu = {text: "Additional Time", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:765,y:120,w:200,h:50}}
        aboutsubmenu = {text: "About", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:620,y:120,w:200,h:50}}
        policytermssubmenu = {text: "Policy & Terms", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:1010,y:120,w:200,h:50}}
    else
        logo={
            url:"pkg:/images/logo.png",
            TargetRect:{x:45,y:40,w:160,h:53}

        }
        bgmenu = {url:"pkg:/images/bgmenunew2.png", TargetRect:{x:0,y:165,w:1280,h:80}}
        exploremenu = {text: "Relax", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        sleepmenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
        preferencessubmenu = {text: "Settings", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:110,y:120,w:200,h:50}}
        helpfulhintssubmenu = {text: "Helpful Hints", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:365,y:120,w:200,h:50}}
        artistsubmenu = {text: "About", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:520,y:120,w:200,h:50}}
        faqsubmenu = {text: "FAQ", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:833,y:120,w:200,h:50}}
        'additionalsubmenu = {text: "Additional Time", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:765,y:120,w:200,h:50}}
        aboutsubmenu = {text: "About", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:620,y:120,w:200,h:50}}
        policytermssubmenu = {text: "Policy & Terms", textAttrs: {HAlign:"Left",Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:1010,y:120,w:200,h:50}}
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
    'staticStuff.Push(additionalsubmenu)
    'staticStuff.Push(aboutsubmenu)
    staticStuff.Push(policytermssubmenu)
    m.canvas.setLayer(201, staticStuff)
    m.canvas.setLayer(170, bgmenu)
End Function




''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' paints the selector for the top menu
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function paint_top_menu_selector3(topindex=0) as void

    pos_rings=[]
    staticStuff=[]
    pos_rings.push({x:425,y:90,w:180,h:2})
    pos_rings.push({x:625,y:90,w:180,h:2})
    pos_rings.push({x:825,y:90,w:180,h:2})

    if (m.inTopMenu)
        ring={
            url:"pkg:/images/ring_play_100.png",
            targetRect:pos_rings[topindex]
        }
    endif
print "topindex"
print topindex
    if (topindex=0)
        sleepmenu = {text: "Relax", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        exploremenu = {text: "Sleep", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
    else if (topindex=1)
        sleepmenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        exploremenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
    else if (topindex=2)
        sleepmenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:420,y:50,w:200,h:50}}
        exploremenu = {text: "Sleep", textAttrs: {Color: "#666666", font: m.app.h2}, targetRect:{x:620,y:50,w:200,h:50}}
        setupmenu = {text: "Set Up", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:820,y:50,w:200,h:50}}
    endif

    if (m.inTopMenu) m.canvas.setLayer(181,ring)

    staticStuff.push(exploremenu)
    staticStuff.push(sleepmenu)
    staticStuff.push(setupmenu)

    m.canvas.setLayer(179, staticStuff)

End Function




Function paint_subtop_menu_selector(topindex=0, active=true) as void

    pos_rings=[]

    pos_rings.push({x:110,y:160,w:130,h:2})
    pos_rings.push({x:365,y:160,w:138,h:2})
    pos_rings.push({x:620,y:160,w:65,h:2})
    pos_rings.push({x:833,y:160,w:50,h:2})
    pos_rings.push({x:1010,y:160,w:155,h:2})

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


Function paint_preference_selector(preferenceindex=0) as void
      pos_rings=[]

      pos_rings.push({x:215,y:360,w:100,h:2})
      pos_rings.push({x:800,y:360,w:100,h:2})
      pos_rings.push({x:540,y:430,w:230,h:2})
      pos_rings.push({x:540,y:570,w:230,h:2})
      pos_rings.push({x:1010,y:160,w:155,h:2})

      if (NOT m.inTopMenu)
          ring={
              url:"pkg:/images/ring_play_100.png",
              targetRect:pos_rings[preferenceindex]
          }
      else
          ring={
              url:"pkg:/images/bgmenuitemhover.png",
              targetRect:pos_rings[preferenceindex]
          }
      endif

      m.canvas.setLayer(43,ring)
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
        m.paintAditional()
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
        m.paintPolicyTerms()
    else if (m.subTopMenuIndex=5)
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
    pref.push( {text:"Time to Advance Setting",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:290,x:110,y:200,h:100}} )
    pref.push( {text:"Choose the amount of time a video should play before advancing to next title",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:480,x:110,y:250,h:100}} )
    '
    'pref.push({url:"pkg:/images/rect.png",targetRect:{w:500,h:150,x:45,y:190}})
    pref.push({text:"<   "+m.globalvideotime.toStr()+"   > minutes",textAttrs:{font:m.app.h2},targetRect:{w:300,h:110,x:170,y:290}})
    pref.push( {text:"Auto-ShutOff Setting",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:290,x:720,y:200,h:100}} )
    pref.push( {text:"Set a timer to turn of Ahhveo streaming automatically",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:480,x:720,y:250,h:100}} )
    '
    'pref.push({url:"pkg:/images/rect.png",targetRect:{w:500,h:150,x:690,y:190}})

    pref.push({text:"<   "+Str(m.autoshutoff)+"   > hours",textAttrs:{font:m.app.h2},targetRect:{w:300,h:110,x:740,y:290}})
    pref.push({text:"THESE SETTINGS GOVERNS ALL DEVICES ON ACCOUNT",textAttrs:{font:m.app.hnova},targetRect:{w:800,h:50,x:280,y:580}})
    hour = (m.available_time.toInt()/1000)/60/60
    minutes = (m.available_time.toInt()/1000)/60/60/60
    hr = Str(Fix(hour))
    min = Str(Fix(minutes))
    pref.push( {text:"Time Remaining: "+hr+" hours and "+min+" minutes",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:500,x:70,y:630,h:100}} )
    pref.push({text:"Token: "+m.app.getRegistry(),textAttrs:{HAlign:"Right",font:m.app.h3},targetRect:{w:250,x:960,y:597,h:100}})
    pref.push({url:"pkg:/images/rect.png",targetRect:{w:1190,h:40,x:45,y:625}})
    pref.push({text:"Build version: "+m.app.appInfo.GetVersion(),textAttrs:{font:m.app.h4},targetRect:{w:190,x:570,y:635,h:100}})

    m.canvas.setLayer(400, pref)

end function



function paint_faq(page=0) as void

    faq=m.app.http.getWs("getFaqs.php")
    if(type(faq)<>"roInvalid")
        content = []
        faqcontent = []
        separation = 0
        specialy = 0
        actualpage = m.page
        totalpages = faq.content.count()-4
        For i=0 To faq.content.count()-1
            content.push(strReplace(faq.content[i],"\n",""))
        End For
        if (type(content[page+1])<>"Invalid")
          if (m.page>1)
            specialy = -30
          endif
          faqcontent.push({text:content[page],textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:530,x:80+separation,y:200 + specialy,h:500}})
          separation = separation + 600
          faqcontent.push({text:content[page+1],textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:530,x:80+separation,y:200 + specialy,h:500}})
          if (m.inFaqFocus)
            faqcontent.push({text:"< Page "+actualpage.toStr()+" of "+totalpages.toStr()+" >",textAttrs:{Color:"#FFFF55", font:m.app.h3},targetRect:{w:200,h:50,x:550,y:650}})
          else
            faqcontent.push({text:"< Page "+actualpage.toStr()+" of "+totalpages.toStr()+" >",textAttrs:{Color:"#FFFFFF", font:m.app.h3},targetRect:{w:200,h:50,x:550,y:650}})
          endif
          m.canvas.setLayer(400, faqcontent)
        endif
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
        if (totalpages>1)
          hintscontent.push({text:"< Page "+actualpage.toStr()+" of "+totalpages.toStr()+" >",textAttrs:{font:m.app.h3},targetRect:{w:200,h:50,x:550,y:650}})
        endif
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


    addi.push({text:"Purchase more time",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:300,h:50,x:210,y:420}})
    addi.push({text:"You can change subscription any time from the following options: $3.99 for 25 hours, and $7.99 for 50 hours. The moment you resubscribe you will get changed and will start the subscription from day one.",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h4},targetRect:{w:530,h:50,x:720,y:390}})
    addi.push({text:"Change Subscription",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:300,h:50,x:780,y:520}})

    'addi.push({text:"THIS SETTINGS GOVERNS ALL DEVICES ON ACCOUNT",targetRect:{w:700,h:50,x:300,y:550}})
    hour = (m.available_time.toInt()/1000)/60/60
    minutes = (m.available_time.toInt()/1000)/60/60/60
    hr = Str(Fix(hour))
    min = Str(Fix(minutes))
    addi.push( {text:"Time Remaining: "+hr+" hours and "+min+" minutes",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:500,x:70,y:780,h:100}} )
    addi.push({text:"Token: "+m.app.getRegistry(),textAttrs:{HAlign:"Right",font:m.app.h3},targetRect:{w:250,x:960,y:760,h:100}})
    addi.push({url:"pkg:/images/rect.png",targetRect:{w:1190,h:40,x:45,y:795}})
    addi.push({text:"Build version: "+m.app.appInfo.GetVersion(),textAttrs:{font:m.app.h4},targetRect:{w:190,x:570,y:805,h:100}})

    m.canvas.setLayer(401, addi)

end function


function paint_about() as void
    artistscontent = []
    about=m.app.http.getWs("getAbout.php")
    if(type(about)<>"roInvalid")
        content=strReplace(about.content,"\n","")
        artistscontent.push( {text:content,textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:590,x:45,y:200,h:500}} )
        'm.canvas.setLayer(400, aboutcontent)
    endif

    artists=m.app.http.getWs("getArtist.php")
    if(type(artists)<>"roInvalid")

        content=strReplace(artists.content,"\n","")
        artistscontent.push({text:content,textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:550,x:650,y:360,h:500}})
        'artistscontent.push({url:"pkg:/images/peter_roberts_logo.png",targetRect:{w:110,h:30,x:945,y:200}})
        artistscontent.Push({text:"'I work to capture the magic of idyllic locations and deliver it to people's homes.'",textAttrs:{font:m.app.h5},targetRect:{w:235,h:235,x:900,y:180}})
        artistscontent.push({ url:artists.image,targetRect:{w:200,h:200,x:650,y:200}})
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


function paint_policy_terms(page=0) as void
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
        actualpage = m.page
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
        totalpages = totalpages - 13
        if (type(content[page+1])<>"Invalid")
          'For i=0 To content.count()-1
              'content.push(strReplace(privacy.content[i],"\n",""))
              if (page>1)
                specialy = -30
              endif
              datacontent.push({text:content[page],textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:530,x:80+separation,y:200 + specialy,h:500}})
              separation = separation + 600
              datacontent.push({text:content[page+1],textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:530,x:80+separation,y:200 + specialy,h:500}})
          'End For
          if (m.inPolicyFocus)
            datacontent.push({text:"Page < "+actualpage.toStr()+" of "+totalpages.toStr()+" >",textAttrs:{Color:"#FFFF55",font:m.app.h3},targetRect:{w:200,h:50,x:550,y:650}})
          else
            datacontent.push({text:"Page < "+actualpage.toStr()+" of "+totalpages.toStr()+" >",textAttrs:{Color:"#FFFFFF",font:m.app.h3},targetRect:{w:200,h:50,x:550,y:650}})
          endif
          m.canvas.setLayer(400, datacontent)
        endif
    endif

end function


function scrolling_focused() as void



end function


function setup_remote_callback(index) as void
    print index
    if (index=2) then ' up
        if (m.inSubTopMenu)
          m.inTopMenu=true
          m.topMenuIndex=2
          m.canvas.clearLayer(42)
          m.paintTopMenuSelector(m.topMenuIndex)
        else if (m.inPreferences OR m.inAutoShutOff)
          m.canvas.clearLayer(43)
          m.inPreferences=false
          m.inAutoShutOff=false
          m.paintSubTopMenuSelector()
          m.inSubTopMenu=true
        else if (m.inBuyAdditionalTime)
          m.inBuyAdditionalTime=false
          m.inPreferences=true
          m.paintPreferenceSelector(0)
        else if (m.inChangeSubscription)
          m.inChangeSubscription=false
          m.inBuyAdditionalTime=true
          m.paintPreferenceSelector(2)
        endif
    else if (index=3) then ' down
        if (m.inTopMenu)
          m.canvas.clearLayer(181)
          m.inTopMenu=false
          m.paintSubTopMenuSelector()
          m.inSubTopMenu=true
        else if (m.inSubTopMenu)
          m.inSubTopMenu=false
          m.canvasClearLayer(42)
         ' todo white marker
          m.paintPreferenceSelector(0)
          m.inPreferences=true
        else if (m.inPreferences OR m.inAutoShutOff)
          m.inPreferences=false
          m.inAutoShutOff=false
          m.inBuyAdditionalTime=true
          m.PaintPreferenceSelector(2)
        else if (m.inBuyAdditionalTime)
          m.inBuyAdditionalTime=false
          m.inChangeSubscription=true
          m.paintPreferenceSelector(3)
        endif
    else if (index=4) then ' left
        if (m.topMenuIndex>0 AND m.inTopMenu)
            m.topMenuIndex = m.topMenuIndex - 1
            m.paintTopMenuSelector(m.topMenuIndex)
            if (m.topMenuIndex=1)
                m.clearSetup()
                sm = sectionManager(m.app)
                sm.show(sleep_section)
            endif
        else if (m.subTopMenuIndex>0 AND m.inSubTopMenu)
            m.subTopMenuIndex = m.subTopMenuIndex - 1
            m.paintSubTopMenuSelector(m.subTopMenuIndex)
            m.paintSection()
        else if (m.inPreferences AND m.globalvideotime>5)
            m.globalvideotime = m.globalvideotime - 1
            m.paintPreferences()
        else if (m.inAutoShutOff AND m.autoshutoff>0.5)
            m.autoshutoff = m.autoshutoff - 0.5
            m.paintPreferences()
        else if (m.inFaqFocus)
            if (m.faqpage>0)
              m.faqpage = m.faqpage - 2
              if (m.page>0)
                m.page = m.page - 1
              endif
              m.paintFaq(m.faqpage)
            endif
        else if (m.inPolicyFocus)
          if (m.pppage>0)
            m.pppage = m.pppage - 2
            if (m.page>0)
              m.page = m.page - 1
            endif
            m.paintPolicyTerms(m.pppage)
          endif
        endif
    else if (index=5) then ' right
        if (m.topMenuIndex<2 AND m.inTopMenu)
            m.topMenuIndex = m.topMenuIndex + 1
            m.paintTopMenuSelector(m.topMenuIndex)
        else if (m.subTopMenuIndex<4 AND m.inSubTopMenu)
            m.subTopMenuIndex = m.subTopMenuIndex + 1
            m.paintSubTopMenuSelector(m.subTopMenuIndex)
            m.paintSection()
        else if (m.inPreferences AND m.globalvideotime<50)
            m.globalvideotime = m.globalvideotime + 1
            m.paintPreferences()
        else if (m.inAutoShutOff AND m.autoshutoff<12)
            m.autoshutoff = m.autoshutoff + 0.5
            m.paintPreferences()
        else if (m.inFaqFocus)
            if (m.faqpage<40)
              m.faqpage = m.faqpage + 2
              if (m.page<40)
                m.page = m.page + 1
              endif
              m.paintFaq(m.faqpage)
            endif
        else if (m.inPolicyFocus)
          if (m.pppage<40)
            m.pppage = m.pppage + 2
            if (m.page<40)
              m.page = m.page + 1
            endif
            m.paintPolicyTerms(m.pppage)
          endif
        endif
    else if (index=6) then
        if (m.subTopMenuIndex=0)
          if (m.inPreferences)
              m.inPreferences=false
              m.inAutoShutOff=true
              m.PaintPreferenceSelector(1)
          else if (m.inAutoShutOff)
              m.inAutoShutOff=false
              m.inBuyAdditionalTime=true
              m.PaintPreferenceSelector(2)
          else if (m.inBuyAdditionalTime)
              m.inBuyAdditionalTime=false
              'dialog
          else if (m.inChangeSubscription)
              m.inChangeSubscription=false
              'dialog
          endif
        else if (m.subTopMenuIndex=3) ' FAQ focus
          if (m.inFaqFocus)
            m.inFaqFocus=false
            m.page=1
            m.inSubTopMenu=true
          else
            m.inFaqFocus=true
            m.inSubTopMenu=false
          endif
          m.paintFaq(m.page)
        else if (m.subTopMenuIndex=4) ' policy
          if (m.inPolicyFocus)
            m.inPolicyFocus=false
            m.page=1
            m.inSubTopMenu=true
          else
            m.inPolicyFocus=true
            m.inSubTopMenu=false
          endif
          m.paintPolicyTerms(m.page)
        endif

    else if (index=7) then



    end if
end function


function clear_setup() as void
    m.canvas.clearLayer(50)
    'm.canvas.clearLayer(36)
    m.canvas.clearLayer(201)
    m.canvas.clearLayer(401)
    m.canvas.clearLayer(170)
    m.canvas.clearLayer(178)
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
    m.canvas.clearLayer(401)
end function
