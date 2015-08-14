Function setup_section(s) as void

this={
     app:s.app
     canvas:s.app.canvas
     port: s.app.port
     remoteCallback:setup_remote_callback2
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
     
     'Vars
     idxTop: 0
     idxRight: 0
     edit: false
     numberSection: invalid
     dir: invalid
     update: false
     idxMenuTop: 0
     
     'Functions
     getSections: getSettingsVars
     showImageCanvas : showImageCanvas
     setLine: setLine
     drawRec: drawRec
     delLayer: delLayer
     getServerSetting: getServerSetting
     eventClik: eventClik
     save: save
     
     cvString: cvString
     cont: {}

     'Options Paged
     paginate : paginate
     isFocusPaged : false

     contentPage : []
     
     ArrayHints : []
     ArrayAbout : []
     ArrayFAQ : []
     ArrayTerms : []

     TotalPages : 0
     currentPage : 0
     page: 0

     separation : 600
     specialy : -30
     
  }

this.setupPaint()
this.setupPaintStatic()

s.app.remoteListener=this

end Function



Function setup_paint() as void
    print "setup_paint()"
    setupText = {text: "Under development.", textAttrs: {font: m.app.h1}, targetRect:{x:175,y:200,w:1000,h:200}}
    m.getServerSetting()
    ' m.paintSection()
    m.topMenuIndex=2
    m.inTopMenu=true
    m.paintTopMenuSelector(m.topMenuIndex)    
    'm.canvas.setLayer(50, setupText)
End Function



Function paint_static3() as void
    print "paint_static3()"

    staticStuff=[]
    if (IsHD())
        logo={
            url:"pkg:/images/logo.png",
            TargetRect:{x:45,y:40,w:160,h:53}
        }
        bgmenu = {url:"pkg:/images/bgmenunew2.png", TargetRect:{x:0,y:165,w:1280,h:80}}
        exploremenu = {text: "Relax", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:540,y:50,w:200,h:50}}
        sleepmenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:530,y:50,w:200,h:50}}
        sleepmenunew = {url:"pkg:/images/zzz.png", TargetRect:{w:29,h:33,x:660,y:35}}
        setupmenu = {text: "Set up", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:740,y:50,w:200,h:50}}
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
        exploremenu = {text: "Relax", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:380,y:50,w:200,h:50}}
        sleepmenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:530,y:50,w:200,h:50}}
        sleepmenunew = {url:"pkg:/images/zzz.png", TargetRect:{w:29,h:33,x:660,y:35}}
        setupmenu = {text: "Set up", textAttrs: {Color: "#FFFFFF", font: m.app.h2}, targetRect:{x:780,y:50,w:200,h:50}}
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
    m.canvas.setLayer(199, sleepmenunew)
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
    print "paint_top_menu_selector3(";topindex;");"

    pos_rings=[]
    staticStuff=[]
    pos_rings.push({x:345,y:90,w:180,h:2})
    pos_rings.push({x:540,y:90,w:180,h:2})
    pos_rings.push({x:745,y:90,w:180,h:2})

    if (m.idxMenuTop = 0)
        ring={
            url:"pkg:/images/ring_play_100.png",
            targetRect:pos_rings[topindex]
        }
    endif

    if (topindex=0)
        sleepmenu = {text: "Relax", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:340,y:50,w:200,h:50}}
        exploremenu = {text: "Sleep", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:530,y:50,w:200,h:50}}
        setupmenu = {text: "Set up", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:740,y:50,w:200,h:50}}
    else if (topindex=1)
        sleepmenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:340,y:50,w:200,h:50}}
        exploremenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:530,y:50,w:200,h:50}}
        setupmenu = {text: "Set up", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:740,y:50,w:200,h:50}}
    else if (topindex=2)
        sleepmenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:340,y:50,w:200,h:50}}
        exploremenu = {text: "Sleep", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:530,y:50,w:200,h:50}}
        setupmenu = {text: "Set up", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:740,y:50,w:200,h:50}}
    endif
    sleepmenunew = {url:"pkg:/images/zzz.png", TargetRect:{w:29,h:33,x:660,y:35}}
    
    if (m.idxMenuTop = 0) m.canvas.setLayer(181,ring)

    staticStuff.push(exploremenu)
    staticStuff.push(sleepmenu)
    staticStuff.push(setupmenu)

    m.canvas.setLayer(179, staticStuff)
    m.canvas.setLayer(199, sleepmenunew)
    
End Function




Function paint_subtop_menu_selector(topindex=0, active=true) as void
    print "paint_subtop_menu_selector(" topindex "," active ")"
    pos_rings=[]

    pos_rings.push({x:85,y:160,w:130,h:2})
    pos_rings.push({x:365,y:160,w:138,h:2})
    pos_rings.push({x:620,y:160,w:65,h:2})
    pos_rings.push({x:833,y:160,w:50,h:2})
    pos_rings.push({x:1010,y:160,w:155,h:2})

    if (m.idxMenuTop > 0)
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
      print "paint_preference_selector("preferenceindex")"
      pos_rings=[]

      pos_rings.push({x:215,y:360,w:100,h:2})
      pos_rings.push({x:800,y:360,w:100,h:2})
      pos_rings.push({x:540,y:430,w:230,h:2})
      pos_rings.push({x:540,y:570,w:230,h:2})
      pos_rings.push({x:1010,y:160,w:155,h:2})

      if (m.idxMenuTop > 0)
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
    print "paint_section()"
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
        m.page = 0
        m.paintFAQ()
    else if (m.subTopMenuIndex=4)
        m.clearUnderDev()
        m.page = 0
        m.paintPolicyTerms()
    else if (m.subTopMenuIndex=5)
        m.clearUnderDev()
        m.paintPolicyTerms()
    else
        m.setupPaint()
    end if

End Function

Function getSettingsVars(sec) as Object  
    aa={S1:[{
                text: "Time to Advance Setting",
                attr: {VAlign:"top",HAlign:"Left",font:m.app.h3},
                size: {w:290,x:110,y:200,h:100}
            },
            {
                text: "Choose the amount of time a video should play before advancing to next title",
                attr: {VAlign:"top",HAlign:"Left",font:m.app.h3},
                size: {w:480,h:100,x:110,y:250}
            },
            {
                text: "<   "+Str(m.globalvideotime)+"   > minutes",
                attr: {font:m.app.h2, VAlign:"Middle"},
                size: {w:300,h:110,x:170,y:290},
                with: 100
                top: 70
                lf:110
            }
           ],
        S2:[
            {
                text: "Auto-ShutOff Setting",
                attr: {VAlign:"top",HAlign:"Left",font:m.app.h3},
                size: {w:290,x:720,y:200,h:100}                
            },
            {
                text: "<   "+Str(m.autoshutoff)+"   > hours"
                attr: {font:m.app.h2}
                size: {w:300,h:110,x:740,y:290}
                with: 120
                top: 70
                lf:80            
            }
           ],
        S3:[
            {
                text: "Purchase more time"
                attr: {VAlign:"top",HAlign:"Left",font:m.app.h3}
                size: {w:300,h:50,x:210,y:400}
                with: 220
                top: 30
                lf: 86
            }        
        ],
        S4:[
            {
                text: "Change Subscription"
                attr: {VAlign:"top",HAlign:"Left",font:m.app.h3}
                size: {w:300,h:50,x:780,y:400}
                with: 228
                top: 30
                lf: 73
            },
            {
                text: "You can change subscription any time from the following options: $3.99 for 25 hours, and $7.99 for 50 hours. The moment you resubscribe you will get changed and will start the subscription from day one."
                attr: {VAlign:"top",HAlign:"Left",font:m.app.h4}
                size: {w:470,h:50,x:720,y:450}
            }        
        ],

        'Seccion FAQ & Policy&Terms
        PAGED:[
            {
                size: {w:200,h:50,x:550,y:650}
                with: 170
                top: 40
                lf: 0
            }
        ]
       } 
  return aa[sec]
End Function

function paint_preferences() as void
    print "paint_preferences()"
    
    section= m.getSections("S1")
    section2= m.getSections("S2")

    pref = []
    pref.push( {text:section[0].text,textAttrs:section[0].attr,targetRect:section[0].size} )
    pref.push( {text:section[1].text,textAttrs:section[1].attr,targetRect:section[1].size} )
    
    pref.push({text:section[2].text,textAttrs:section[2].attr,targetRect:section[2].size})
    
    
    'Informacion de la seccion 2 de settings
    pref.push( {text:section2[0].text,textAttrs:section2[0].attr,targetRect:section2[0].size} )
    pref.push( {text:"Set a timer to turn of Ahhveo streaming automatically",textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:480,x:720,y:250,h:100}} )

    pref.push({text:section2[1].text,textAttrs:section2[1].attr,targetRect:section2[1].size})
    
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

function paint_additional() as void
    print "paint_additional()"
    
    section3 = m.getSections("S3")
    section4 = m.getSections("S4")
    
    addi = []
      
    addi.push({text:section3[0].text,textAttrs:section3[0].attr,targetRect:section3[0].size})
    
    addi.push({text:section4[1].text,textAttrs:section4[1].attr,targetRect:section4[1].size})
    addi.push({text:section4[0].text,textAttrs:section4[0].attr,targetRect:section4[0].size})

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

function paint_faq(page=0) as void
    if(m.ArrayFAQ.count() = 0)then
      faq=m.app.http.getWs("getFaqs.php")
      if(type(faq)<>"roInvalid")
          content = []
          faqcontent = []
          separation = 0
          specialy = 0
          actualpage = m.page
          totalpages = faq.content.count()-4
          j = 1

          For i=0 To faq.content.count()-1
              content.push(strReplace(faq.content[i],"\n",""))
              m.ArrayFAQ.push(strReplace(faq.content[i],"\n",""))
          End For

          m.TotalPages = m.ArrayFAQ.count()
      endif
    else
        m.TotalPages = m.ArrayFAQ.count()
    endif

    m.currentPage = page
    m.paginate(m.ArrayFAQ)

end function



function paint_hints(page = 0) as void
    if(m.ArrayHints.count() <= 0) then
      hints=m.app.http.getWs("getHints.php")
      if(type(hints)<>"roInvalid")
            print hints
            content = []
            hintscontent = []
            separation = 0
            specialy = 0
            actualpage = 1
            totalpages = hints.content.count()-1
            j = 1
            For i=0 To hints.content.count()-1
                 ' if(i%2 = 0)
                 '   print i
                 ' endif 
                content.push(strReplace(hints.content[i],"\n",""))
                m.ArrayHints.push(strReplace(hints.content[i],"\n",""))
                
                if (i=1)
                    specialy = -30
                endif
                hintscontent.push({text:content[i],textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:530,x:80+separation,y:200 + specialy,h:500}})
                separation = separation + 600
                
                if(j = 2)
                  print "j";j
                  m.ArrayHints.push(hintscontent)
                endif


                if(j < 3) then
                  j = j + 1
                else
                  j = 1
                endif
            End For
            m.TotalPages = m.ArrayHints.count()
            print m.ArrayHints

            if (totalpages>1)
              hintscontent.push({text:"< Page "+actualpage.toStr()+" of "+totalpages.toStr()+" >",textAttrs:{font:m.app.h3},targetRect:{w:200,h:50,x:550,y:650}})
            endif
            ' m.canvas.setLayer(400, hintscontent)
      endif
    else
      hints = m.ArratHints
      m.TotalPages = m.ArrayHints.count()
    endif
    
    m.currentPage = page
    m.paginate(m.ArrayHints)    
End function

function paint_about() as void
    artistscontent = []
    about=m.app.http.getWs("getAbout.php")
    'about = m.cont.about

    if(type(about)<>"roInvalid")
        content=strReplace(about.content,"\n","")
        artistscontent.push( {text:content,textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:590,x:45,y:200,h:500}} )
        'm.canvas.setLayer(400, aboutcontent)
    endif

    artists=m.app.http.getWs("getArtist.php")
    'artists = m.cont.artists
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

    if(m.ArrayTerms.count() = 0) then
        if (m.app.trial)
            privacy=m.app.http.getWs("getTerms.php?tostype=7")
            terms.content[0] = " "
        else
            terms=m.app.http.getWs("getTerms.php?tostype=11")
            privacy=m.app.http.getWs("getPrivacy.php")
        endif
        ' privacy = m.cont.privacy
        ' terms = m.cont.terms
    
        if(type(privacy)<>"roInvalid" AND type(terms)<>"roInvalid")
            if (terms.content[0]=" ")                
                for i=0 to privacy.content.count()-1
                    ' content.push(strReplace(privacy.content[i],"\n",""))
                    m.ArrayTerms.push(strReplace(privacy.content[i],"\n",""))
                endfor
            else                
                for i=0 to privacy.content.count()-1
                    'content.push(strReplace(privacy.content[i],"\n",""))
                    m.ArrayTerms.push(strReplace(privacy.content[i],"\n",""))
                endfor
                for i=0 to terms.content.count()-1
                    'content.push(strReplace(terms.content[i],"\n",""))
                    m.ArrayTerms.push(strReplace(terms.content[i],"\n",""))
                endfor
            endif 
            m.TotalPages = m.ArrayTerms.count()           
        endif
    else
        m.TotalPages = m.ArrayTerms.count()
    endif
    
    m.currentPage = page
    m.paginate(m.ArrayTerms)

end function


function scrolling_focused() as void



end function

function setup_remote_callback2(index) as void
  print "setup_remote_callback2(" index ")"

  if(index = 2) then 'Top
    m.idxMenuTop = m.idxMenuTop - 1
    if(m.idxMenuTop < 0) then
      m.idxMenuTop = 0
    endif

    if(m.idxMenuTop = 0) then
      m.delLayer(400)
      m.canvas.clearLayer(42)
      m.paintTopMenuSelector(m.topMenuIndex)      
      m.subTopMenuIndex = 0

      if(m.subTopMenuIndex = 0)
        m.clearPreferences()
        m.clearAditional()
      endif

    else if(m.idxMenuTop = 1) then
      m.paintSubTopMenuSelector(m.subTopMenuIndex)
      m.isFocusPaged = false      
      m.delLayer(1001)
      
    endif

  else if(index = 3) then 'Down
    m.idxMenuTop = m.idxMenuTop + 1
    if(m.idxMenuTop > 2) then
      m.idxMenuTop = 2
    endif

    if(m.idxMenuTop = 1) then
      m.canvas.clearLayer(181)
      m.paintSubTopMenuSelector()
      m.paintSection()

    else if(m.idxMenuTop = 2) then
      
      m.canvas.ClearLayer(42)

      if(m.subTopMenuIndex = 0)
        m.drawRec()
        m.showImageCanvas()
      else if(m.subTopMenuIndex = 3 or m.subTopMenuIndex = 4)
        paged = m.getSections("PAGED")
        m.isFocusPaged = true
        ' m.page = 0
        m.setLine(paged[0])
      endif
    endif

  else if(index = 4) then 'Left
    if(m.idxMenuTop = 0)
        m.paintTopMenuSelector(1)            
        m.clearSetup()
        sm = sectionManager(m.app)
        sm.show(sleep_section)            
    else if(m.idxMenuTop = 1)
      m.subTopMenuIndex = m.subTopMenuIndex - 1
      if(m.subTopMenuIndex < 0)
        m.subTopMenuIndex = 0
      endif
      
      ' m.page = 0
      m.paintSubTopMenuSelector(m.subTopMenuIndex)
      m.paintSection()
      
    else if(m.idxMenuTop = 2)
        if(m.subTopMenuIndex = 3 or m.subTopMenuIndex = 4)
            m.page = m.page - 1
            if(m.page < 0)
                m.page = 0
            endif
        endif
        
        if(m.subTopMenuIndex = 3)
            m.paintFAQ(m.page)
        endif
        
        if(m.subTopMenuIndex = 4)
            m.paintPolicyTerms(m.page)
        endif
        
    endif

  else if(index = 5) then 'Right
    if(m.idxMenuTop = 1)
      m.subTopMenuIndex = m.subTopMenuIndex + 1
      if(m.subTopMenuIndex > 4)
        m.subTopMenuIndex = 4
      endif

      m.paintSubTopMenuSelector(m.subTopMenuIndex)
      m.paintSection()      
      ' m.page = 0
      
    else if(m.idxMenuTop = 2)
        if(m.subTopMenuIndex = 3 or m.subTopMenuIndex = 4)
            m.page = m.page + 1            
        endif
        if(m.subTopMenuIndex = 3)            
            m.paintFAQ(m.page)
        endif
        
        if(m.subTopMenuIndex = 4)            
            m.paintPolicyTerms(m.page)
        endif
    endif

  else if(index = 6) then 'Enter
  else if(index = 7) then 'Instant Replay

  endif
End Function

function setup_remote_callback(index) as void
    print "setup_remote_callback(" index ")"    
    sett = {
      topMenuIndex: m.topMenuIndex
      inSubTopMenu: m.inSubTopMenu
      inTopMenu: m.inTopMenu
      inPreferences: m.inPreferences
    }

    print sett

    if (index=2) then ' up
        if (m.inSubTopMenu)
          m.inTopMenu=true
          m.topMenuIndex=2
          m.canvas.clearLayer(42)
          m.paintTopMenuSelector(m.topMenuIndex)
          m.clearPreferences()
          m.clearAditional()
          
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
          ' m.paintSection()
        else if (m.inSubTopMenu)
          m.inSubTopMenu=false
          m.canvas.ClearLayer(42)
         ' todo white marker
          m.paintPreferenceSelector(0)
          m.inPreferences=true
          
          m.paintSection()
                    
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


'Test Functions

function showImageCanvas() as void
  print  "showImageCanvas()"
  section= m.getSections("S1") ' 0 - Time to Advance
  section2= m.getSections("S2") ' Auto-ShutOff
  section3= m.getSections("S3") ' Purchase more time
  section4= m.getSections("S4") ' Change Subscription  

  while(true)
    msg = wait(0,m.port)
    if (msg.isRemoteKeyPressed()) then
        i = msg.GetIndex()
        print "Key Pressed - " ; msg.GetIndex()
                        
        if (i = 2) then 'Top
          if(m.idxTop = 0 and NOT m.edit) then
            m.delLayer(1002)
            m.canvas.clearLayer(43)
            
            ' reset values
            m.idxTop = 0
            m.idxRight = 0
                        
            m.paintSubTopMenuSelector()
            m.inSubTopMenu=true
            m.idxMenuTop = 1

            return
          else
            if(NOT m.edit)then
                m.idxTop = m.idxTop - 1
                if(m.idxTop < 0) then
                    m.idxTop = 0 
                end if
                m.delLayer(1001)
                m.drawRec()
            end if
          end if
          
          

        else if(i = 3) then  'Down
            if(NOT m.edit)then
                m.delLayer(1002)
                m.idxTop = m.idxTop + 1        
                if(m.idxTop > 1) then
                    m.idxTop = 1
                end if
                
                m.delLayer(1001)
                m.drawRec()
            end if
            
            ' if(m.idxTop = 1 and m.idxRight = 0) then
                ' m.setLine(section3[0])
            ' else if(m.idxTop = 1 and m.idxRight = 1) then
                ' m.setLine(section4[0])
            ' end if
        else if(i = 4) then ' Left
            if(NOT m.edit)then
                m.idxRight = m.idxRight - 1
                
                if(m.idxRight < 0) then
                    m.idxRight = 0
                end if

                m.delLayer(1001)
                m.drawRec()
            else
                m.eventClik("prev")
            end if
            ' if(m.idxTop = 0 and m.idxRight = 0)then
                ' m.drawRec()
            ' else if(m.idxTop = 1 and m.idxRight = 0) then
                ' m.setLine(section3[0])
            ' else if(m.idxTop = 1 and m.idxRight = 1) then
                ' m.setLine(section4[0])
            ' end if
            
            print m.idxTop "::" m.idxRight
            
        else if(i = 5) then 'Right
            if(NOT m.edit)then
                m.idxRight = m.idxRight + 1
                if(m.idxRight > 1) then
                    m.idxRight = 1
                end if
                
                m.delLayer(1001)
                m.drawRec()
            else
                m.eventClik("next")
            end if
             
            ' if(m.idxTop = 0 and m.idxRight = 1) then
                ' m.drawRec()
            ' else if(m.idxTop = 1 and m.idxRight = 0) then
                ' m.setLine(section3[0])
            ' else if(m.idxTop = 1 and m.idxRight = 1) then
                ' m.setLine(section4[0])
            ' end if
            
            print m.idxTop "::" m.idxRight
                        
        else if(i = 6) then ' Enter
            if(NOT m.edit)then          
                if(m.idxTop = 0 and m.idxRight = 0) then                                    
                    m.setLine(section[2])
                    m.numberSection = 1 ' btnMinuteTime
                    m.edit = true
                    
                else if(m.idxTop = 0 and m.idxRight = 1) then                
                    m.setLine(section2[1])
                    m.numberSection = 2 ' btnHoursAutoShutOff
                    m.edit = true
                    
                else if(m.idxTop = 1 and m.idxRight = 0) then
                    m.setLine(section3[0])
                    m.numberSection = 3 ' btnPurchasesTime
                else if(m.idxTop = 1 and m.idxRight = 1) then
                    m.setLine(section4[0])
                    m.numberSection = 4 ' btnChangeSubscription
                end if                        
            else                
               m.save() 
            end if
            
        end if
    end if    
  end while
End Function

function eventClik(dir="null" as String) as void
    
    if(m.numberSection = 1)then
        if(dir = "next")then        
            m.globalvideotime = m.globalvideotime + 1
            if(m.globalvideotime > 50)then
                m.globalvideotime = 50
            endif
        else
            m.globalvideotime = m.globalvideotime - 1
            if(m.globalvideotime < 5)then
                m.globalvideotime = 5
            endif
        endif
        m.paintPreferences()
        m.update = true
    else if(m.numberSection = 2)then
        if(dir = "next")then        
            m.autoshutoff = m.autoshutoff + 0.5
            if(m.autoshutoff > 12)then
                m.autoshutoff = 12
            endif
        else
            m.autoshutoff = m.autoshutoff - 0.5
            if(m.autoshutoff < 0.5)then
                m.autoshutoff = 0.5
            endif
        endif
        m.paintPreferences()
        m.update = true
    else if(m.numberSection = 3)then
        
    else if(m.numberSection = 4)then
    end if
End Function

function save() as void
    print "save()"
    if(m.numberSection = 1)then
        if(m.update)then
            t = (m.globalvideotime * 60 * 1000)
            t = m.cvString(t)
                     
            print "aqui"
            
            q = "upSettings.php?user_id="+m.app.userid+"&col=global_timer&data="+t
            
            query = m.app.http.getWs(q)
            
            print query
            if(type(query)<>"roInvalid")then
                m.update = false
                m.edit = false
                m.delLayer(1001)
                 
                ' print query
                      
            endif
        endif
    else if(m.numberSection = 2)then
        if(m.update)then
            time_shutoff = ((m.autoshutoff * 60) * 60) * 1000 
            temp_time = m.cvString(time_shutoff)
            
            query =m.app.http.getWs("upSettings.php?user_id="+m.app.userid+"&col=shutoff_timer&data="+temp_time)
            
            if(type(query)<>"roInvalid")then
                    m.update = false
                    m.edit = false
                    m.delLayer(1001)
                     
                    print query
                      
            endif
        endif
    endif
    
End Function

function drawRec() as void
    print "drawRec()"
    print "idxTop" m.idxTop; "idxRight" m.idxRight
    parameter = {
        url:"pkg:/images/bgWhite2.png"                
    }
    if(m.idxTop = 0 and m.idxRight = 0)then
        parameter.TargetRect = {w:485,h:190,x:99,y:195}
    else if(m.idxTop = 0 and m.idxRight = 1) then
        parameter.TargetRect = {w:485,h:190,x:709,y:195}
    else if(m.idxTop = 1 and m.idxRight = 0) then
        parameter.TargetRect = {w:485,h:190,x:99,y:390}
    else if(m.idxTop = 1 and m.idxRight = 1) then
        parameter.TargetRect = {w:485,h:190,x:709,y:390}
    end if    
    m.canvas.setLayer(1002,parameter)
End Function

function delLayer(idx) as void
    m.canvas.clearLayer(idx)
End Function

function setLine(options) as void
    print options
  
    size = options.size
    with = options.with
    top = options.top
    left_x = 0
      
    if(type(options.lf) <> "Invalid") then
        left_x = options.lf
    end if
    
    w_ori = size.w
    'h_ori = size.h
    
    x_ori = size.x
    y_ori = size.y
    
    dir_y = CreateObject("roInt")
    dir_x = CreateObject("roInt")
    w = CreateObject("roInt")
    
    temp = Abs(x_ori + (w_ori - (with + left_x )) / 2)
    
    dir_y.SetInt(y_ori + top)
    dir_x.SetInt(temp)
    w.SetInt(with)
    
    targ = {x:dir_x, y: dir_y, w: w, h: 2}
    print targ

    print m.edit

    item = {url:"pkg:/images/ring_play_100.png", TargetRect:{x:dir_x, y: dir_y, w: w, h: 2}}
    if(NOT m.edit) then
        m.canvas.setLayer(1001,item)
    else
        m.delLayer(1001)
    end if
  
End Function

function getServerSetting() as void
    print "getServerSetting()"
    
    settings=m.app.http.getWs("getSettings.php?user_id="+m.app.userid)
    
    if(type(settings)<>"roInvalid")
        m.shutoff_timer=settings.shutoff_timer
        m.start_shutoff_timer=m.shutoff_timer
        m.automatic_charge=settings.automatic_charge
        m.start_automatic_charge=m.automatic_charge
        m.available_time=settings.available_time
        
        temp_shutoff = (settings.shutoff_timer.toInt() / 1000) / 60 / 60
        
        m.autoshutoff = temp_shutoff 
        
        global_t = (settings.global_timer.toInt() / 1000) / 60 
        
        print global_t  
        m.globalvideotime = global_t
        
    endif    

End Function

'Clear Sections
function clearSection() as void
  if(m.subTopMenuIndex = 0) then
  
  else if(m.subTopMenuIndex = 1) then
  
  else if(m.subTopMenuIndex = 2) then
  
  else if(m.subTopMenuIndex = 3) then
  
  else if(m.subTopMenuIndex = 4) then

  endif
End Function

function paginate(Data as dynamic, currentPage = 0) as void
  totalpages = m.TotalPages - 1 ' RlCeil(m.TotalPages)
  
  if(totalpages = 2)then
    init = 0
  else
    init = m.currentPage
  endif
  
  limit = init + 1
  
  
  if(init > totalpages)
    limit = totalpages
    init = totalpages
    m.page = totalpages
    m.currentPage = totalpages
  endif    
  
  print init;":-:";limit; totalpages     
    content = []
    separation = 0
  For i=init To limit   
    content.push({text:Data[i],textAttrs:{VAlign:"top",HAlign:"Left",font:m.app.h3},targetRect:{w:530,x:80+separation,y:200,h:500}})    
    separation = separation + 600
  End For
  
  actualpage = init + 1  
  if(totalpages > 2) then
    content.push({text:"< Page "+actualpage.toStr()+" of "+m.TotalPages.toStr()+" >",textAttrs:{font:m.app.h3},targetRect:{w:200,h:50,x:550,y:650}})
  endif
  
  m.canvas.setLayer(400, content)    
End Function

function page_settings () as object    
     return {
        attr: {Color:"#FFFFFF", font:m.app.h3},
        size: {w:200,h:50,x:550,y:650},
        with: 200
        top: 30
        lf: 0
     }
End Function

' Utils

function cvString(v as dynamic) as string    
    
    out = ""
    
    v = box(v)
    vType = type(v)
    
    if vType = "roInt"
        out = out + v.tostr()
    else if vType = "roFloat"
        out = out + str(v)
    end if

    return out.Trim()       
End Function