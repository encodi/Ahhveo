Function Thumby2(arguments) as object
    this = {
                app:arguments.app
                canvas:arguments.canvas
                remoteCallback:handle_carousel_keys2
                paint:initThumby2
                clearMenu:clear_menu
                exploreData:invalid
                getExploreData:get_explore_data
                explorePositions:invalid
                exploreBGPositions:invalid
                exploreTPositions:invalid
                paintExplore:paint_explore
                exploreThumbnails:[]
                exploreBackgrounds:[]
                exploreTitles:[]
                idExploreSelected:0
                idPlacesSelected:0
                idSubPlacesSelected:0
                idVideosSelected:0
                levelPositions:[]
                subLevelPositions:[]
                phantomLevelPositions:[]
                paintLevelFor:paint_level_for
                paintSubLevelFor:paint_sublevel_for
                paintPhantomLevelFor:paint_phantomlevel_for
                resetPhantomLevel:reset_phantom_level
                getDataFor:get_data_for
                getVideosFor:get_videos_for
                allData:invalid
                clearLevel:clear_level
                clearSubLevel:clear_sublevel
                placesArray:[]
                subPlacesArray:[]
                videosArray:[]
                videosList:[]
                levelThumbnails:[]
                levelBackgrounds:[]
                levelTitles:[]
                subLevelThumbnails:[]
                subLevelBackgrounds:[]
                subLevelTitles:[]
                phantomLevelThumbnails:[]
                phantomLevelBackground:[]
                phantomLevelTitles:[]
                levelBGPositions:invalid
                levelTitlePositions:invalid
                subLevelBGPositions:invalid
                subLevelTitlePositions:invalid
                subLevelTitlePosition:invalid
                subLevelDescriptionPosition:invalid
                phantomBGPositions:invalid
                phantomTitlePositions:invalid
                drawSelector:draw_selected
                clearSelector:clear_selector
                clearAll:clear_all
                currentLevel:0
                moveLeft:move_left
                moveRight:move_right
                resetExplore:reset_explore
                resetSubLevel:reset_sublevel
                resetLevel:reset_level
                videosLimit:6
                theTitle:""
                theDescription:""
                theCounter:""
                paintStatic:paint_static
                topPhantomLevelPositions:[]
                topPhantomLevelThumbnails:[]
                topPhantomLevelBackground:[]
                topPhantomLevelTitles:[]
                topPhantomBGPositions:invalid
                topPhantomTPositions:invalid
                paintTopPhantomLevelFor:paint_topphantomlevel_for
                resetTopPhantomLevel:reset_topphantom_level
                getFavoritesFor:get_favorites_for
                favoritesList:[]
                getPlaylistsFor:get_playlists_for
                playlistsList:[]
                videoIndex:0
                playerCallBack:player_callback2
                scrollHorizontal:carousel_scroll_horizontal2
                paintTopMenuSelector:paint_top_menu_selector
                inTopMenu:false
                topMenuIndex:0
                paintTopShadow:paint_top_shadow
                paintBottomShadow:paint_bottom_shadow
                clearTopShadow:clear_top_shadow
                clearBottomShadow:clear_bottom_shadow
                epager:0
                spager:0
                total:0
                subtotal:0
                paintMarketing:paint_marketing
                clearMarketing:clear_marketing
                level1index:1
                level2index:1
                level3index:1
                loginahhveo:login_the_user
           }

    return this
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' clears the main menu layer
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function clear_menu() as void
    m.canvas.clearlayer(100)
    m.canvas.clearlayer(101)
    m.canvas.clearlayer(104)
    m.canvas.clearlayer(105)
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' gets the explore data from web services
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function get_explore_data() as void
    m.exploreData=m.app.http.getWs("getExplore.php")
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' gets the data according to explore id
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function get_data_for(id) as void
    m.allData=m.app.http.getWs("getNextLevel.php?eid="+id)
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' gets the data according to explore id
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function get_videos_for(id, pors) as void
    print "getting videos"
    print id
    print pors
    m.videosList=m.app.http.getWs("getVideos.php?"+pors+"="+id)
End Function



''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' gets the data according to favorites
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function get_favorites_for() as void
    print "getting favs"
    m.favoritesList=m.app.http.getWs("getRelaxNow.php?user_id="+m.app.userid)
End Function



''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' gets the data according to favorites
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function get_playlists_for() as void
    m.playlistsList=m.app.http.getWs("getPlaylist.php?user_id="+m.app.userid)
End Function



''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' initializes the script, painting the canvas
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function initThumby2() as void

    m.canvas.clearLayer(777)
    m.clearMenu()
    m.currentLevel=0
    m.getExploreData()
    m.paintExplore()
    m.paintStatic()
    m.loginahhveo()
    if (m.app.loggedflag=true)
        print "paint marketing at init"
        m.paintMarketing()
        m.inTopMenu = true
        m.currentLevel=-1
        m.canvas.clearLayer(29)
        m.canvas.clearLayer(33)
        m.clearTopShadow()
        m.topMenuIndex = 0
        m.paintTopMenuSelector(0)
        m.drawSelector(m.currentLevel)
        m.idExploreSelected = m.exploreData[0].id
        print "EXPLORE ID"
        print m.idExploreSelected
        m.getDataFor(m.idExploreSelected)
        m.paintSubLevelFor(m.idExploreSelected)
        if (m.idExploreSelected<>"10")
            m.paintPhantomLevelFor(false)
        endif
    else
        print "paint marketing at init"
        m.paintMarketing()
        m.inTopMenu = true
        m.currentLevel=-1
        m.canvas.clearLayer(29)
        m.canvas.clearLayer(33)
        m.clearTopShadow()
        m.topMenuIndex = 0
        m.paintTopMenuSelector(0)
        m.drawSelector(m.currentLevel)
        m.idExploreSelected = m.exploreData[0].id
        print "EXPLORE ID"
        print m.idExploreSelected
        m.getDataFor(m.idExploreSelected)
        m.paintSubLevelFor(m.idExploreSelected)
        if (m.idExploreSelected<>"10")
            m.paintPhantomLevelFor(false)
        endif
        'sm = sectionManager(m.app)
        'sm.show(places_section)
    endif
End Function


Function login_the_user() as void

    token = m.app.getRegistry()
    print "current token"
    print token

    if (token<>invalid)
        user = m.app.http.getWs("searchUser.php?token="+token)
        print "user -------------------------------------------"
        print user
        if (user.id<>invalid)
            print "user data exists"
            m.app.trial = false
            m.app.userid=user.id
            wsString="device_id="+m.app.getRegistry()+"&email="+user.email
           'here we get the settings data
           print "wsString ---------------"
           print wsString
        else
            print "user is new, is a trial"
            m.app.trial = true
            wss="getTrial.php?device_id="+m.app.getRegistry()
            trialuser=m.app.http.getWs(wss)
            print "trial user info"
            print trialuser
            wsString="device_id="+m.app.getRegistry()+"&name="+trialuser.name+"&email="+trialuser.email
            print "wsString ---------------"
            print wsString
        endif
    else
        token = m.app.http.getWs("getToken.php")
        if (token<>invalid)
            if (token.registrationToken<>"0")
                token = token.registrationToken
                m.app.setRegistry(token)
                m.app.trial = true
                user = m.app.http.getWs("createTrialUser.php?token="+token)
                print "new token"
                print token
                wsString="device_id="+m.app.getRegistry()+"&name="+user.name+"&email="+user.email
            endif
        endif
    endif

    ws="getUser.php?"+wsString
    user=m.app.http.getWs(ws)
    print "user info -----------------------------"
    print user
    m.app.userid = user.uid
    settings={
                sleep_sound:user.settings.sleep_sound
                shutoff_timer:user.settings.shutoff_timer.toint()
                sleep_timer:user.settings.sleep_timer.toint()
             }

    settingss=m.app.http.getWs("getSettings.php?user_id="+m.app.userid)
    print "Settings -------------------------"
    print settingss
    m.app.settings=settings

    if settingss.sleep_sound="Ocean Waves" then
    'ocean
        m.app.sleepSound=1
    else if settingss.sleep_sound="Peaceful Frogs" then
    'frogs
        m.app.sleepSound=2
    else if settingss.sleep_sound="Summer Rain" then
    'rain
        m.app.sleepSound=3
    else if settingss.sleep_sound="Relaxing Crickets" then
    'crickets
        m.app.sleepSound=5
    else if settingss.sleep_sound="Chorus Frogs" then
    'crickets
        m.app.sleepSound=4
    else if settingss.sleep_sound="Sleepy Thunder" then
    'crickets
        m.app.sleepSound=0
    endif

    ' if user is a trial then we show the popup to subscribe or share information on existent account
    if (user.trial)
        print "trial popup"
        if (m.app.ispreview = false)
            m.app.isTrial()
        endif
    else
        print "subscriber"

    endif

    m.app.store.GetPurchases()
    m.app.restartGlobalSleepTimer()

End Function


Function paint_marketing() as void

    print "marketing"

    if m.app.trial
        json=m.app.http.getWs("getNews.php?trial=0")
    else
        json=m.app.http.getWs("getNews.php?trial=1")
    endif
    m.app.json=json

    items = []

    bottombg = {url:"pkg:/images/bottombg.png",TargetRect:{x:0,y:555,w:1280,h:150}}

    'items.push({Color: "#343434", TargetRect:{x:0,y:530,w:1280,h:200}})

    items.push({text:json.title,
            textAttrs:{HAlign:"left",font:m.app.carouseltitlefont},
           targetRect:{x:330,y:560,w:580,h:50}})

    items.push({text:json.content,
                textAttrs:{HAlign:"left",font:m.app.h4},
               targetRect:{x:330,y:595,w:580,h:50}})

    items.push({url:json.thumb2,
           targetRect:{x:910,y:590,w:150,h:85}})

    items.push({url:json.thumb1,
           targetRect:{x:1080,y:590,w:150,h:85}})

    m.canvas.setLayer(17, bottombg)
    m.canvas.setLayer(70, items)

End Function



Function clear_marketing() as void
    
    m.canvas.clearLayer(17)
    m.canvas.clearLayer(70)

End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' paints the static logo and top title
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function paint_static() as void
    staticStuff=[]
    if (IsHD())
        logo={
            url:"pkg:/images/logo.png",
            TargetRect:{x:45,y:20,w:230,h:84}
        }
        bgmenu = {url:"pkg:/images/bgmenunew.png", TargetRect:{x:0,y:0,w:1280,h:120}}
        shapebehindboxessleep =  {url:"pkg:/images/shapebehindboxessleep.png", TargetRect:{x:60,y:120,w:1148,h:265}}
        newShadow1 = {url:"pkg:/images/nextsmallarrow.png",targetRect:{w:36,h:36,x:420,y:230}}
        newShadow2 = {url:"pkg:/images/nextsmallarrow.png",targetRect:{w:36,h:36,x:830,y:230}}
        'exploremenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:530,y:50,w:200,h:50}}
        'sleepmenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:330,y:50,w:200,h:50}}
        sleepmenunew = {url:"pkg:/images/zzz.png", TargetRect:{w:29,h:33,x:660,y:35}}
        'setupmenu = {text: "Set up", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:740,y:50,w:200,h:50}}
        sleepmenu = {text: "Relax", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:340,y:50,w:200,h:50}}
        exploremenu = {text: "Sleep", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:530,y:50,w:200,h:50}}
        setupmenu = {text: "Set up", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:740,y:50,w:200,h:50}}
        'normalmenu = {text: "Simple", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:420,y:100,w:200,h:50}}
        'advancedmenu = {text: "Advanced", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:620,y:100,w:200,h:50}}
    else
        logo={
            url:"pkg:/images/logo.png",
            TargetRect:{x:45,y:20,w:230,h:84}
        }
        bgmenu = {url:"pkg:/images/bgmenunew.png", TargetRect:{x:0,y:0,w:1280,h:120}}
        shapebehindboxessleep =  {url:"pkg:/images/shapebehindboxessleep.png", TargetRect:{x:60,y:120,w:1148,h:265}}
        newShadow1 = {url:"pkg:/images/nextsmallarrow.png",targetRect:{w:36,h:36,x:420,y:230}}
        newShadow2 = {url:"pkg:/images/nextsmallarrow.png",targetRect:{w:36,h:36,x:830,y:230}}
        exploremenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:530,y:50,w:200,h:50}}
        sleepmenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:330,y:50,w:200,h:50}}
        sleepmenunew = {url:"pkg:/images/zzz.png", TargetRect:{w:29,h:33,x:660,y:35}}
        setupmenu = {text: "Set up", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:740,y:50,w:200,h:50}}
        'normalmenu = {text: "Simple", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:420,y:100,w:200,h:50}}
        'advancedmenu = {text: "Advanced", textAttrs: {Color: "#FFFFFF", font: m.app.h3}, targetRect:{x:620,y:100,w:200,h:50}}
    endif
    '#9da2a6
    'm.canvas.clearlayer(201)
    m.canvas.setLayer(178, bgmenu)

    'staticStuff.push(logo)
    staticStuff.push(exploremenu)
    staticStuff.push(sleepmenu)
    
    staticStuff.push(setupmenu)
    'staticStuff.push(sleepmenunew)
    m.canvas.setLayer(199, sleepmenunew)
    'staticStuff.push(normalmenu)
    'staticStuff.push(advancedmenu)
    m.canvas.setLayer(179, staticStuff)
    m.canvas.setLayer(180, logo)
    'm.canvas.setLayer(33, shapebehindboxessleep)
    'm.canvas.setLayer(34, newshadow1)
    'm.canvas.setLayer(35, newshadow2)
    m.paintTopMenuSelector(0)
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' paints the selector for the top menu
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function paint_top_menu_selector(topindex=0) as void

    pos_rings=[]
    staticStuff=[]
    pos_rings.push({x:345,y:90,w:180,h:2})
    pos_rings.push({x:540,y:90,w:180,h:2})
    pos_rings.push({x:745,y:90,w:180,h:2})

    if (m.inTopMenu)
        ring={
            url:"pkg:/images/ring_play_100.png",
            targetRect:pos_rings[topindex]
        }
    endif
    sleepmenunew = {url:"pkg:/images/zzz.png", TargetRect:{w:29,h:33,x:660,y:35}}
    if (topindex=0)
    'sleepmenunew = {url:"pkg:/images/zzz.png", TargetRect:{w:29,h:33,x:660,y:35}}
        sleepmenu = {text: "Relax", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:340,y:50,w:200,h:50}}
        exploremenu = {text: "Sleep", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:530,y:50,w:200,h:50}}
        setupmenu = {text: "Set up", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:740,y:50,w:200,h:50}}
    else if (topindex=1)
        sleepmenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:340,y:50,w:200,h:50}}
        exploremenu = {text: "Sleep", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:530,y:50,w:200,h:50}}
        setupmenu = {text: "Set up", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:740,y:50,w:200,h:50}}
    else if (topindex=2)
        exploremenu = {text: "Relax", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:340,y:50,w:200,h:50}}
        setupmenu = {text: "Sleep", textAttrs: {Color: "#666666", font: m.app.menufont}, targetRect:{x:530,y:50,w:200,h:50}}
        setupmenu = {text: "Set up", textAttrs: {Color: "#FFFFFF", font: m.app.menufont}, targetRect:{x:740,y:50,w:200,h:50}}
    endif
    

    if (m.inTopMenu) m.canvas.setLayer(181,ring)

    staticStuff.push(exploremenu)
    staticStuff.push(sleepmenu)
    staticStuff.push(setupmenu)

    m.canvas.setLayer(179, staticStuff)
    m.canvas.setLayer(199, sleepmenunew)
End Function



''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' paints the 3rd phantom level
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function paint_topphantomlevel_for(moving=false) as void
    m.resetTopPhantomLevel()
    xTopPhantom = 0
    if (m.currentLevel=2)
        m.topPhantomLevelPositions={x:45, y: -47, w:269, h: 149}
        m.topPhantomBGPositions={x:45, y: -47, w:269, h: 149}
        m.topPhantomTPositions={x:45, y: 18, w:269, h: 149}
        for each thumb in m.exploreData
            m.topPhantomLevelThumbnails.push({url: thumb.thumbnail, targetRect: m.topPhantomLevelPositions})
            m.topPhantomLevelBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:m.topPhantomBGPositions})
            m.topPhantomLevelTitles.push({text: thumb.title, textAttrs: {font: m.app.h4}, targetRect:m.topPhantomTPositions})
            xTopPhantom = xTopPhantom + 286
            m.TopPhantomLevelPositions={x:45 + xTopPhantom, y: -47, w:269, h: 149}
            m.TopPhantomBGPositions={x:45 + xTopPhantom, y: -47, w:269, h: 149}
            m.topPhantomTPositions={x:45 + xTopPhantom, y: 18, w:269, h: 149}
        end for
            m.canvas.setlayer(40, m.topPhantomLevelThumbnails)
            m.canvas.setLayer(41, m.topPhantomLevelBackground)
            m.canvas.setLayer(43, m.topPhantomLevelTitles)
    end if
End Function



''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' paints the 3rd phantom level
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function paint_phantomlevel_for(moving=false) as void
    m.resetPhantomLevel()
    xPhantom = 0
    i = 0
    if (m.currentLevel=0)
        if (m.allData[0].hasVideos) then
            if (NOT moving)
                m.videosArray = m.allData[0].videos
            endif
            m.phantomLevelPositions={x:45, y: 421, w:176, h: 98}
            m.phantomBGPositions={x:45, y: 421, w:176, h: 98}
            for each video in m.videosArray
                if (i<8)
                    m.phantomLevelThumbnails.push({url: video.thumbnail, targetRect: m.phantomLevelPositions})
                    'm.phantomLevelBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:m.phantomBGPositions})
                    xPhantom = xPhantom + 191
                    m.phantomLevelPositions={x:45 + xPhantom, y: 421, w:176, h: 98}
                    m.phantomBGPositions={x:45 + xPhantom, y: 421, w:176, h: 98}
                endif
                    i = i + 1
            end for
            m.canvas.setlayer(38, m.phantomLevelThumbnails)
            'm.canvas.setLayer(39, m.phantomLevelBackground)
        endif
    else if (m.currentLevel=1 OR m.currentLevel=-1)
        if (m.allData[0].hasVideos) then
            if (NOT moving)
                if (m.idExploreSelected="10")
                    m.getFavoritesFor()
                    m.videosArray = m.favoritesList
                else
                    if (m.allData[0].hasplaces)
                        toAdd = "pid"
                        id =  m.idPlacesSelected
                    else if (m.allData[0].hassubplaces)
                        toAdd = "sid"
                        id =  m.idSubPlacesSelected
                    endif
                    m.getVideosFor(id, toAdd)
                    m.videosArray = m.videosList
                endif
            endif
            m.phantomLevelPositions={x:45, y: 421, w:176, h: 98}
            m.phantomBGPositions={x:45, y: 421, w:176, h: 98}
            for each video in m.videosArray
                if (i<8)
                    m.phantomLevelThumbnails.push({url: video.thumbnail, targetRect: m.phantomLevelPositions})
                    'm.phantomLevelBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:m.phantomBGPositions})
                    xPhantom = xPhantom + 191
                    m.phantomLevelPositions={x:45 + xPhantom, y: 421, w:176, h: 98}
                    m.phantomBGPositions={x:45 + xPhantom, y: 421, w:176, h: 98}
                endif
                    i = i + 1
            end for
            m.canvas.setlayer(38, m.phantomLevelThumbnails)
            'm.canvas.setLayer(39, m.phantomLevelBackground)
        endif
    else if (m.currentLevel=2)
        if (m.allData[0].hasVideos) then
            if (NOT moving)
                m.videosArray = m.allData[0].videos
            endif
            m.phantomLevelPositions={x:45, y: 421, w:176, h: 98}
            m.phantomBGPositions={x:45, y: 421, w:176, h: 98}

            videoLevelTitlePosition={x:410, y: 535, w:760, h: 100}
            videoLevelDescriptionPosition={x:410, y: 600, w:760, h: 100}
            singleThumbPosition={x:130, y: 575, w:195, h: 114}
            for each video in m.videosArray
                if (i<8)
                    m.phantomLevelThumbnails.push({url: video.thumbnail, targetRect: m.phantomLevelPositions})
                    if (i=0)
                        m.theTitle = {text: video.title, textAttrs: {HAlign:"Left",font: m.app.carouseltitlefont}, targetRect:videoLevelTitlePosition}
                        m.theDescription = {text: video.description, textAttrs: {HAlign:"Left",font: m.app.carouseldescriptionfont}, targetRect:videoLevelDescriptionPosition}
                        phantomSingleThumb = {url: m.videosArray[0].thumbnail, targetRect: singleThumbPosition}
                    endif
                    'm.phantomLevelBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:m.phantomBGPositions})
                    xPhantom = xPhantom + 191
                    m.phantomLevelPositions={x:45 + xPhantom, y: 421, w:176, h: 98}
                    m.phantomBGPositions={x:45 + xPhantom, y: 421, w:176, h: 98}
                endif
                    i = i + 1
            end for
            m.canvas.setlayer(38, m.phantomLevelThumbnails)
            m.canvas.setLayer(60, m.theTitle)
            m.canvas.setLayer(61, m.theDescription)
            m.canvas.setLayer(62, phantomSingleThumb)
            bottombg = {url:"pkg:/images/bottombg.png",TargetRect:{x:0,y:555,w:1280,h:150}}
            m.canvas.setLayer(17, bottombg)
        endif
    end if
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' paints the selector
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function draw_selected(level) as void
    url_rings=[]
    pos_rings=[]
    url_rings.push("pkg:/images/ring_level_1_active.png")
    url_rings.push("pkg:/images/ring_level_1_active.png")
    url_rings.push("pkg:/images/ring_level_1_active.png")
    url_rings.push("pkg:/images/ring_level_1_active.png")

    pos_rings.push({x:40,y:115,w:280,h:160})
    pos_rings.push({x:40,y:280,w:225,h:130})
    pos_rings.push({x:40,y:418,w:186,h:105})
    pos_rings.push({x:40,y:418,w:186,h:105})

    ring={
        url:url_rings[level],
        targetRect:pos_rings[level]
    }

    m.canvas.setLayer(29,ring)
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' paints the explore level in the canvas
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function paint_explore() as void
    m.resetExplore()
    xExplore = 0
    k = 0
    total = m.exploreData.count()
    total = total.tostr()
    subtotal=0
    for each thumb in m.exploreData
        m.exploreThumbnails.push({url: thumb.thumbnail, targetRect: m.explorePositions})
        if k=0
            print "placesTotal"
            print thumb.placesTotal
            if (type(thumb.placesTotal)<>Invalid)
                stotal = thumb.placesTotal
                if (stotal="0")
                    stotal = thumb.subplacesTotal
                    if (stotal="0")
                        stotal = thumb.videosTotal
                    endif
                endif
            else
                stotal = "0"
            endif
            'm.exploreTitles.push({text: "("+stotal+")", textAttrs: {font: m.app.h5}, targetRect:{x:-70, y: 196, w:269, h: 125}})
            'm.exploreTitles.push({text: "("+m.level1index.tostr()+" of "+total+")", textAttrs: {font: m.app.h5}, targetRect:{x:150, y: 196, w:269, h: 125}})
        endif
        m.exploreTitles.push({text: thumb.title, textAttrs: {font: m.app.h3}, targetRect:m.exploreTPositions})
        m.exploreBackgrounds.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:m.exploreBGPositions})
        xExplore = xExplore + 286
        k = k + 1
        m.explorePositions = {x:45 + xExplore, y: 120, w:269, h: 149}
        m.exploreBGPositions = {x:45 + xExplore, y: 242, w:269, h: 27}
        m.exploreTPositions = {x:45 + xExplore, y: 194, w:269, h: 125}
    end for

    'exploreTotal = {text: m.exploreData.count(), textAttrs: {font: m.app.h4}, targetRect:}
    m.canvas.setlayer(30, m.exploreThumbnails)
    m.canvas.setlayer(31, m.exploreBackgrounds)
    m.canvas.setlayer(32, m.exploreTitles)
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Paint the level above in canvas
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function paint_level_for(moving=false) as void
    m.resetLevel()
    xLevel = 0
    if (m.allData[0].hasplaces)
        print "has places"
        if (NOT moving)
            m.placesArray = m.allData[0].places
        endif
       for each place in m.placesArray
            m.levelThumbnails.push({url: place.thumbnail, targetRect: m.levelPositions})
            m.levelTitles.push({text: place.title, textAttrs: {font: m.app.h4}, targetRect:m.levelTitlePositions})
            m.levelBackgrounds.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:m.levelBGPositions})
            xLevel = xLevel + 286
            m.levelPositions = {x:45 + xLevel, y: 120, w:269, h: 149}
            m.levelBGPositions = {x:45 + xLevel, y: 244, w:269, h: 25}
            m.levelTitlePositions = {x:45 + xLevel, y: 196, w:269, h: 125}
        end for
        m.canvas.setlayer(30, m.levelThumbnails)
        m.canvas.setlayer(31, m.levelBackgrounds)
        m.canvas.setlayer(32, m.levelTitles)
    else if (m.allData[0].hassubplaces)
        print "has subplaces"
        if (NOT moving)
            m.subPlacesArray = m.allData[0].subplaces
        endif
        for each subplace in m.subPlacesArray
            m.levelThumbnails.push({url: subplace.thumbnail, targetRect: m.levelPositions})
            m.levelTitles.push({text: subplace.title, textAttrs: {font: m.app.h4}, targetRect:m.levelTitlePositions})
            m.levelBackgrounds.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:m.levelBGPositions})
            xLevel = xLevel + 286
            m.levelPositions = {x:45 + xLevel, y: 120, w:269, h: 149}
            m.levelBGPositions = {x:45 + xLevel, y: 244, w:269, h: 25}
            m.levelTitlePositions = {x:45 + xLevel, y: 196, w:269, h: 125}
        end for
        m.canvas.setlayer(30, m.levelThumbnails)
        m.canvas.setlayer(31, m.levelBackgrounds)
        m.canvas.setlayer(32, m.levelTitles)
    else if (m.allData[0].hasvideos)
        print "has videos"
        if (NOT moving)
            m.videosArray = m.allData[0].videos
        end if
        for each video in m.videosArray
            m.levelThumbnails.push({url: video.thumbnail, targetRect: m.levelPositions})
            m.theTitle = {text: m.videosArray[0].title, textAttrs: {font: m.app.carouseltitlefont}, targetRect:m.subLevelTitlePosition}
            m.theDescription = {text: m.videosArray[0].description, textAttrs: {font: m.app.carouseldescriptionfont}, targetRect:m.subLevelDescriptionPosition}
            'm.levelTitles.push({text: video.title, textAttrs: {font: m.app.h2}, targetRect:m.levelTitlePositions})
            'm.levelBackgrounds.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:m.levelBGPositions})
            xLevel = xLevel + 286
            m.levelPositions = {x:45, y: 120, w:269, h: 149}
            'm.levelBGPositions = {x:100, y: 220, w:269, h: 50}
            'm.levelTitlePositions = {x:100, y: 175, w:269, h: 150}
        end for
        m.canvas.setlayer(30, m.levelThumbnails)
        m.canvas.setlayer(31, m.theDescription)
        m.canvas.setlayer(32, m.theTitle)
        bottombg = {url:"pkg:/images/bottombg.png",TargetRect:{x:0,y:555,w:1280,h:150}}
        m.canvas.setLayer(17, bottombg)
    endif
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Paint the level below in canvas
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function paint_sublevel_for(id, moving=false) as void
    m.resetSubLevel()
    xSubLevel = 0
    if (m.currentLevel=0 OR m.currentLevel=1 OR m.currentLevel=-1)
        if (m.allData[0].hasplaces)
            total = m.allData[0].totalplaces.tostr()
            subtotal = m.allData[0].totalvideos.tostr()
            print "has places"
            if (NOT moving)
                m.placesArray = m.allData[0].places
            endif
            k = 0
            for each place in m.placesArray
                m.subLevelThumbnails.push({url: place.thumbnail, targetRect: m.subLevelPositions})
                print place
                if k=0
                    'm.subLevelTitles.push({text: "("+place.totalvideosinplace+")", textAttrs: {font: m.app.h5}, targetRect:{x:-75, y: 332, w:269, h: 125}})
                    'm.subLevelTitles.push({text: "("+m.level2index.tostr()+" of "+total+")", textAttrs: {font: m.app.h5}, targetRect:{x:95, y: 332, w:269, h: 125}})
                endif
                k = k + 1
                m.subLevelTitles.push({text: place.title, textAttrs: {font: m.app.h45}, targetRect:m.subLevelTitlePositions})
                m.subLevelBackgrounds.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:m.subLevelBGPositions})
                xSubLevel = xSubLevel + 231
                m.subLevelPositions={x:45 + xSubLevel, y: 286, w:215, h: 119}
                m.subLevelBGPositions={x:45 + xSubLevel, y: 380, w:215, h: 25}
                m.subLevelTitlePositions={x:45 + xSubLevel, y: 382, w:215, h: 25}
            end for
            m.canvas.setlayer(33, m.subLevelThumbnails)
            m.canvas.setlayer(34, m.subLevelBackgrounds)
            m.canvas.setlayer(35, m.subLevelTitles)
            m.idPlacesSelected = m.placesArray[0].id
        else if (m.allData[0].hassubplaces)
            total = m.allData[0].totalsubplaces
            print "has subplaces"
            if (NOT moving)
                m.subPlacesArray = m.allData[0].subplaces
            endif
            for each subplace in m.subPlacesArray
                m.subLevelThumbnails.push({url: subplace.thumbnail, targetRect: m.subLevelPositions})
                m.subLevelTitles.push({text: subplace.title, textAttrs: {font: m.app.h4}, targetRect:m.subLevelTitlePositions})
                m.subLevelBackgrounds.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:m.subLevelBGPositions})
                xSubLevel = xSubLevel + 231
                m.subLevelPositions={x:45 + xSubLevel, y: 286, w:215, h: 119}
                m.subLevelBGPositions={x:45 + xSubLevel, y: 380, w:215, h: 25}
                m.subLevelTitlePositions={x:45 + xSubLevel, y: 382, w:215, h: 25}
            end for
            m.canvas.setlayer(33, m.subLevelThumbnails)
            m.canvas.setlayer(34, m.subLevelBackgrounds)
            m.canvas.setlayer(35, m.subLevelTitles)
            m.idSubPlacesSelected = m.subPlacesArray[0].id
        else if (m.allData[0].hasvideos)
            total = m.allData[0].totalvideos
            print "has videos"
            if (NOT moving)
                if (m.idExploreSelected="10")
                    m.getFavoritesFor()
                    m.videosArray = m.favoritesList
                else if (m.idExploreSelected="11")
                    'm.getPlaylistsFor()
                    'm.videosArray = m.playlistsList
                    m.videosArray = m.allData[0].videos
                else
                    m.videosArray = m.allData[0].videos
                endif
            end if
            i = 0
            m.subLevelPositions={x:45, y: 286, w:215, h: 119}

            videoLevelTitlePosition={x:410, y: 535, w:760, h: 100}
            videoLevelDescriptionPosition={x:410, y: 600, w:760, h: 100}
            singleThumbPosition={x:130, y: 575, w:195, h: 114}
            titlesingle = []

            for each video in m.videosArray
                if (i<m.videosLimit)
                    m.subLevelThumbnails.push({url: video.thumbnail, targetRect: m.subLevelPositions})
                    m.theTitle = {text: m.videosArray[0].title, textAttrs: {HAlign:"Left",font: m.app.h2}, targetRect:videoLevelTitlePosition}
                    m.theDescription = {text: m.videosArray[0].description, textAttrs: {HAlign:"Left",font: m.app.h2}, targetRect:videoLevelDescriptionPosition}
                    phantomSingleThumb = {url: m.videosArray[0].thumbnail, targetRect: singleThumbPosition}
                    'm.subLevelTitles.push({text: video.title, textAttrs: {font: m.app.h2}, targetRect:m.subLevelTitlePositions})
                    'm.subLevelBackgrounds.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:m.subLevelBGPositions})
                    xSubLevel = xSubLevel + 231
                    m.subLevelPositions={x:45 + xSubLevel, y: 286, w:215, h: 119}
                    'm.subLevelBGPositions={x:100 + xSubLevel, y: 400, w:230, h: 50}
                    'm.subLevelTitlePositions={x:100 + xSubLevel, y: 405, w:230, h: 50}
                endif
                i = i + 1
            end for

            m.canvas.setlayer(33, m.subLevelThumbnails)
            if (m.currentLevel=1 AND (m.idExploreSelected="10" OR m.idExploreSelected="12"))
                titlesingle.push(m.theTitle)
                titlesingle.push(m.theDescription)
                titlesingle.push(phantomSingleThumb)
                m.canvas.setLayer(34, titlesingle)
                bottombg = {url:"pkg:/images/bottombg.png",TargetRect:{x:0,y:555,w:1280,h:150}}
                m.canvas.setLayer(17, bottombg)
                'm.canvas.setlayer(34, m.theDescription)
                'm.canvas.setlayer(35, m.theTitle)
                'm.canvas.setlayer(147, phantomSingleThumb)
            endif
        endif
    else if (m.currentLevel=2 OR m.currentLevel=3)
        if (m.allData[0].hasvideos)
            total = m.allData[0].totalvideos
            print "has videos"
            if (NOT moving)
                if (m.idExploreSelected="10")
                    m.getFavoritesFor()
                    m.videosArray = m.favoritesList
                else
                    if (m.allData[0].hasplaces)
                        toAdd = "pid"
                        id =  m.idPlacesSelected
                    else if (m.allData[0].hassubplaces)
                        toAdd = "sid"
                        id =  m.idSubPlacesSelected
                    endif
                    m.getVideosFor(id, toAdd)
                    m.videosArray = m.videosList
                endif
            endif
            i = 0
            m.subLevelPositions={x:45, y: 286, w:215, h: 119}
            for each video in m.videosArray
                if (i<m.videosLimit)
                    m.subLevelThumbnails.push({url: video.thumbnail, targetRect: m.subLevelPositions})
                    m.theTitle = {text: m.videosArray[0].title, textAttrs: {HAlign:"Left",font: m.app.h2}, targetRect:m.subLevelTitlePosition}
                    m.theDescription = {text: m.videosArray[0].description, textAttrs: {HAlign:"Left",font:m.app.h2}, targetRect:m.subLevelDescriptionPosition}
                    'm.subLevelTitles.push({text: video.title, textAttrs: {font: m.app.h2}, targetRect:m.subLevelTitlePositions})
                    'm.subLevelBackgrounds.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:m.subLevelBGPositions})
                    xSubLevel = xSubLevel + 231
                    m.subLevelPositions={x:45 + xSubLevel, y: 286, w:215, h: 119}
                    'm.subLevelBGPositions={x:100 + xSubLevel, y: 400, w:230, h: 50}
                    'm.subLevelTitlePositions={x:100 + xSubLevel, y: 405, w:230, h: 50}
                endif
                i = i + 1
            end for
            m.canvas.setlayer(33, m.subLevelThumbnails)
            m.canvas.setlayer(34, m.theDescription)
            m.canvas.setlayer(35, m.theTitle)
        endif
    endif
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Manages the left movement
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function move_left() as void
    if (m.currentLevel=0)
        print "Moving exploreData"
        exploreTemp = []
        if (m.exploreData.count()>1)
            lastElement = m.exploreData[m.exploreData.count()-1]
            for i=0 to (m.exploreData.count()-1)
                j=i
                if (m.exploreData[j-1]<>invalid) then
                    exploreTemp[i] = m.exploreData[j-1]
                else
                    exploreTemp[i] = lastElement
                end if
            end for
            if (m.level1index>1)
                m.level1index = m.level1index-1
            else if (m.level1index=1)
                m.level1index = m.exploreData.count()
            endif
            m.exploreData = exploreTemp
            m.paintExplore()
            m.idExploreSelected = m.exploreData[0].id
            m.getDataFor(m.idExploreSelected)
            m.subLevelPositions={x:45, y: 285, w:215, h: 119}
            m.paintSubLevelFor(m.idExploreSelected)
            if (m.idExploreSelected<>"10" AND m.idExploreSelected<>"2" AND m.idExploreSelected<>"12")
                m.paintPhantomLevelFor(false)
            else
                m.resetPhantomLevel()
            endif
        end if
    else if (m.currentLevel=1)
        if (m.allData[0].hasplaces)
            print "Moving placesArray"
            placesTemp = []
            if (m.placesArray.count()>1)
                lastElement = m.placesArray[m.placesArray.count()-1]
                for i=0 to (m.placesArray.count()-1)
                    j=i
                    if (m.placesArray[j-1]<>invalid) then
                        placesTemp[i] = m.placesArray[j-1]
                    else
                        placesTemp[i] = lastElement
                    end if
                end for
                if (m.level2index>1)
                    m.level2index = m.level2index - 1
                else if (m.level2index=1)
                    m.level2index = m.placesArray.count()
                endif
                m.placesArray = placesTemp
                if (m.currentLevel=2)m.paintLevelFor(true)
                m.idPlacesSelected = m.placesArray[0].id
                m.paintSubLevelFor(m.idExploreSelected, true)
                if (m.currentLevel=2)m.paintSubLevelFor(m.idExploreSelected, false)
                m.paintPhantomLevelFor(false)
            end if
        else if (m.allData[0].hassubplaces)
            print "Moving subPlacesArray"
            subPlacesTemp = []
            if (m.subPlacesArray.count()>1)
                lastElement = m.subPlacesArray[m.subPlacesArray.count()-1]
                for i=0 to (m.subPlacesArray.count()-1)
                    j=i
                    if (m.subPlacesArray[j-1]<>invalid) then
                        subPlacesTemp[i] = m.subPlacesArray[j-1]
                    else
                        subPlacesTemp[i] = lastElement
                    end if
                end for
                if (m.level2index>1)
                    m.level2index = m.level2index - 1
                else if (m.level2index=1)
                    m.level2index = m.suPlacesArray.count()
                endif
                m.subPlacesArray = subPlacesTemp
                m.idSubPlacesSelected = m.subPlacesArray[0].id
                m.paintSubLevelFor(m.idExploreSelected, true)
                if (m.currentLevel=2)m.paintSubLevelFor(m.idExploreSelected, false)
                m.paintPhantomLevelFor(false)
            end if
        else if (m.allData[0].hasvideos)
            print "Moving videosArray"
            videosTemp = []
            if (m.videosArray.count()>1)
                lastElement = m.videosArray[m.videosArray.count()-1]
                for i=0 to (m.videosArray.count()-1)
                    j=i
                    if (m.videosArray[j-1]<>invalid) then
                        videosTemp[i] = m.videosArray[j-1]
                    else
                        videosTemp[i] = lastElement
                    end if
                end for
                if (m.level2index>1)
                    m.level2index = m.level2index - 1
                else if (m.level2index=1)
                    m.level2index = m.videosArray.count()
                endif
                m.videosArray = videosTemp
                m.idVideosSelected = m.videosArray[0].id
                m.paintSubLevelFor(m.idExploreSelected, true)
                if (m.currentLevel=2)m.paintSubLevelFor(m.idExploreSelected, false)
            end if
        end if
    else if (m.currentLevel=2)
         if (m.allData[0].hasvideos)
            print "Moving videosArray"
            videosTemp = []
            if (m.videosArray.count()>1)
                lastElement = m.videosArray[m.videosArray.count()-1]
                for i=0 to (m.videosArray.count()-1)
                    j=i
                    if (m.videosArray[j-1]<>invalid) then
                        videosTemp[i] = m.videosArray[j-1]
                    else
                        videosTemp[i] = lastElement
                    end if
                end for
                m.videosArray = []
                m.videosArray = videosTemp
                m.idVideosSelected = m.videosArray[0].id
                'm.paintSubLevelFor(m.idExploreSelected, true)
                m.paintPhantomLevelFor(true)
            end if
        end if
    else if (m.currentLevel=3)
        if (m.allData[0].hasvideos)
            print "Moving videosArray"
            videosTemp = []
            if (m.videosArray.count()>1)
                lastElement = m.videosArray[m.videosArray.count()-1]
                for i=0 to (m.videosArray.count()-1)
                    j=i
                    if (m.videosArray[j-1]<>invalid) then
                        videosTemp[i] = m.videosArray[j-1]
                    else
                        videosTemp[i] = lastElement
                    end if
                end for
                m.videosArray = videosTemp
                m.idVideosSelected = m.videosArray[0].id
                m.paintSubLevelFor(m.idExploreSelected, true)
                if (m.currentLevel=2)m.paintSubLevelFor(m.idExploreSelected, false)
            end if
        end if
    end if
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Manages the right movement
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function move_right() as void
    if (m.currentLevel=0)
        print "Moving exploreData"
        exploreTemp = []
        if (m.exploreData.count()>1)
            firstElement = m.exploreData[0]
            for i=0 to (m.exploreData.count()-1)
                j=i
                if (m.exploreData[j+1]<>invalid) then
                    exploreTemp[i] = m.exploreData[j+1]
                else
                    exploreTemp[i] = firstElement
                end if
            end for
            if (m.level1index<m.exploreData.count())
                m.level1index = m.level1index+1
            else if (m.level1index=m.exploreData.count())
                m.level1index = 1
            endif
            m.exploreData = exploreTemp
            m.paintExplore()
            m.idExploreSelected = m.exploreData[0].id
            m.getDataFor(m.idExploreSelected)
            m.subLevelPositions={x:45, y: 285, w:215, h: 119}
            m.paintSubLevelFor(m.idExploreSelected)
            if (m.idExploreSelected<>"10" AND m.idExploreSelected<>"2" AND m.idExploreSelected<>"12")
                m.paintPhantomLevelFor(false)
            else
                m.resetPhantomLevel()
            endif
        end if
    else if (m.currentLevel=1)
        if (m.allData[0].hasplaces)
            print "Moving placesArray"
            placesTemp = []
            if (m.placesArray.count()>1)
                firstElement = m.placesArray[0]
                for i=0 to (m.placesArray.count()-1)
                    j=i
                    if (m.placesArray[j+1]<>invalid) then
                        placesTemp[i] = m.placesArray[j+1]
                    else
                        placesTemp[i] = firstElement
                    end if
                end for
                if (m.level2index<m.placesArray.count())
                    m.level2index = m.level2index + 1
                else if (m.level2index=m.placesArray.count())
                    m.level2index = 1
                endif
                m.placesArray = placesTemp
                m.idPlacesSelected = m.placesArray[0].id
                print "place selected id: "
                print m.idPlacesSelected
                if (m.currentLevel=2)m.paintLevelFor(true)
                m.paintSubLevelFor(m.idExploreSelected, true)
                if (m.currentLevel=2)m.paintSubLevelFor(m.idExploreSelected, false)
                m.paintPhantomLevelFor(false)
            end if
        else if (m.allData[0].hassubplaces)
            print "Moving subPlacesArray"
            subPlacesTemp = []
            if (m.subPlacesArray.count()>1)
                firstElement = m.subPlacesArray[0]
                for i=0 to (m.subPlacesArray.count()-1)
                    j=i
                    if (m.subPlacesArray[j+1]<>invalid) then
                        subPlacesTemp[i] = m.subPlacesArray[j+1]
                    else
                        subPlacesTemp[i] = firstElement
                    end if
                end for
                if (m.level2index<m.subPlacesArray.count())
                    m.level2index = m.level2index + 1
                else if (m.level2index=m.subPlacesArray.count())
                    m.level2index = 1
                endif
                m.subPlacesArray = subPlacesTemp
                m.idSubPlacesSelected = m.subPlacesArray[0].id
                m.paintSubLevelFor(m.idExploreSelected, true)
                if (m.currentLevel=2)m.paintSubLevelFor(m.idExploreSelected, false)
                m.paintPhantomLevelFor(false)
            end if
        else if (m.allData[0].hasvideos)
            print "Moving videosArray"
            videosTemp = []
            if (m.videosArray.count()>1)
                firstElement = m.videosArray[0]
                for i=0 to (m.videosArray.count()-1)
                    j=i
                    if (m.videosArray[j+1]<>invalid) then
                        videosTemp[i] = m.videosArray[j+1]
                    else
                        videosTemp[i] = firstElement
                    end if
                end for
                if (m.level2index<m.videosArray.count())
                    m.level2index = m.level2index + 1
                else if (m.level2index=m.videosArray.count())
                    m.level2index = 1
                endif
                m.videosArray = videosTemp
                m.idVideosSelected = m.videosArray[0].id
                m.paintSubLevelFor(m.idExploreSelected, true)
                if (m.currentLevel=2)m.paintSubLevelFor(m.idExploreSelected, false)
                'if (m.currentLevel=2)m.paintPhantomLevelFor(false)
            end if
        end if
    else if (m.currentLevel=2)
        if (m.allData[0].hasvideos)
            print "Moving videosArray"
            videosTemp = []
            if (m.videosArray.count()>1)
                firstElement = m.videosArray[0]
                for i=0 to (m.videosArray.count()-1)
                    j=i
                    if (m.videosArray[j+1]<>invalid) then
                        videosTemp[i] = m.videosArray[j+1]
                    else
                        videosTemp[i] = firstElement
                    end if
                end for
                m.videosArray = []
                m.videosArray = videosTemp
                m.idVideosSelected = m.videosArray[0].id
                'm.paintSubLevelFor(m.idExploreSelected, true)
                'if (m.currentLevel=2)m.paintSubLevelFor(m.idExploreSelected, false)
                m.paintPhantomLevelFor(true)
            end if
        end if
    else if (m.currentLevel=3)
        if (m.allData[0].hasvideos)
            print "Moving videosArray"
            videosTemp = []
            if (m.videosArray.count()>1)
                firstElement = m.videosArray[0]
                for i=0 to (m.videosArray.count()-1)
                    j=i
                    if (m.videosArray[j+1]<>invalid) then
                        videosTemp[i] = m.videosArray[j+1]
                    else
                        videosTemp[i] = firstElement
                    end if
                end for
                m.videosArray = videosTemp
                m.idVideosSelected = m.videosArray[0].id
                m.paintSubLevelFor(m.idExploreSelected, true)
                if (m.currentLevel=2)m.paintSubLevelFor(m.idExploreSelected, false)
            end if
        end if
    end if
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Manages the key presses
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function handle_carousel_keys2(index) as void
    print "pressed index: "+Str(index)
    if (index=2 or index=3) 'up/down
        m.level1index=1
        m.level2index=1
        m.level3index=1
        if (index=2) 'up
            if (m.currentLevel>-1)
                m.currentLevel = m.currentLevel-1
                
                if (m.currentLevel>=0)
                    m.inTopMenu = false
                    m.drawSelector(m.currentLevel)
                    if (m.currentLevel=1) m.clearBottomShadow()
                    if (m.currentLevel=0) m.clearTopShadow()

                    if (m.currentLevel<2)
                        m.canvas.clearLayer(60)
                        m.canvas.clearLayer(61)
                        m.canvas.clearLayer(62)
                        print "paint marketing here"
                        m.canvas.clearLayer(60)
                        m.canvas.clearLayer(61)
                        m.canvas.clearLayer(62)
                        'm.canvas.clearLayer(34)
                        'm.canvas.clearLayer(41)
                        'm.canvas.clearLayer(43)
                        if (m.currentLevel<0) 
                            'm.paintMarketing()
                        else
                            m.clearMarketing()
                        endif
                    endif
                else
                    m.inTopMenu = true
                    'm.drawSelector(m.currentLevel)
                    m.paintMarketing()
                    m.canvas.clearLayer(29)
                    m.clearTopShadow()
                    m.topMenuIndex = 0
                    m.paintTopMenuSelector(0)
                endif
                'if (m.currentLevel=1)
                '        m.paintExplore()
                '        m.resetTopPhantomLevel()
                '        m.paintPhantomLevelFor()
                '        m.paintSubLevelFor(m.idExploreSelected)
                '        m.paintStatic()
                'end if
            endif
        else if (index=3) 'down
            m.canvas.clearLayer(181)
            m.clearMarketing()
            m.inTopMenu = false
            print "explore id"
            print m.idExploreSelected
            if (m.idExploreSelected="10" OR m.idExploreSelected="12")
                maxSub = 1
            else
                maxSub = 2
            endif
            if (m.currentLevel<maxSub)
                m.currentLevel = m.currentLevel+1
                m.drawSelector(m.currentLevel)
                m.topMenuIndex=0
                'm.paintTopMenuSelector(1)
                print "m.currentlevel"
                print m.currentLevel
                if (m.currentLevel=0)
                    m.paintMarketing()
                endif
                if (m.currentLevel>0) m.paintTopShadow()
                if (maxSub=1)
                    'm.clearMarketing()
                    m.paintSubLevelFor(m.idExploreSelected, true)
                    bottombg = {url:"pkg:/images/bottombg.png",TargetRect:{x:0,y:555,w:1280,h:150}}
                    m.canvas.setlayer(17, bottombg)
                endif
                if (m.currentLevel=2 OR (m.currentLevel=1 AND maxSub=2))
                    if (m.currentLevel>1) m.paintBottomShadow()
                    m.paintPhantomLevelFor(true)
                    m.clearMarketing()
                    bottombg = {url:"pkg:/images/bottombg.png",TargetRect:{x:0,y:555,w:1280,h:150}}
                    m.canvas.setlayer(17, bottombg)
                endif
            endif
            'if (m.currentLevel=2)
            '        m.resetPhantomLevel()
            '        m.paintTopPhantomLevelFor()
            '        m.paintLevelFor()
            '        m.paintSubLevelFor(m.idExploreSelected)
            '        m.drawSelector(3)
            '        m.currentLevel=3
            '        m.canvas.clearLayer(42)
            '        m.canvas.clearLayer(36)
            'end if
        end if
    else if (index=4 or index=5) 'left/right
        if (m.inTopMenu=false)
            if (index=4)
                m.moveLeft()
            else if (index=5)
                m.moveRight()
            endif
        else
            if (index=4)
                if (m.topMenuIndex>0)
                    m.topMenuIndex = m.topMenuIndex - 1
                endif
            else if (index=5)
                if (m.topMenuIndex<2)
                    m.topMenuIndex = m.topMenuIndex + 1
                endif
            endif
            m.paintTopMenuSelector(m.topMenuIndex)
            ' go to section according to paint top
            if (m.topMenuIndex=1)
                m.clearAll()
                sm = sectionManager(m.app)
                sm.show(sleep_section)
            else if (m.topMenuIndex=2)
                m.clearAll()
                sm = sectionManager(m.app)
                sm.show(setup_section)
            endif
        endif
    else if (index=6 AND m.currentLevel=-1)

        if (m.topMenuIndex=1)
            m.clearAll()
            sm=sectionManager(m.app)
            sm.show(sleep_section)
        else if (m.topMenuIndex=2)
            m.clearAll()
            sm=sectionManager(m.app)
            'm.app.setLogo() ' this sets the logo for the old menu
            sm.show(setup_section)
        endif

    else if ((index=6 AND m.currentLevel=3) OR (m.currentLevel=1 AND index=6 AND (m.idExploreSelected="10" OR m.idExploreSelected="12")))
        if (NOT m.inTopMenu)
            currentitems=m.videosArray
            playlist=[]
            for each item in currentitems

                if (m.idExploreSelected="10")
                    playitem_url=item.url+"/"+item.filename
                else
                    playitem_url="http://wpc.B624.edgecastcdn.net/00B624/"+item.video_url
                endif
                playitem_url=fixVideoUrl(playitem_url)

                playlist.push({
                      id:item.id
                      thumbnail:item.thumbnail
                      stream:{url:playitem_url}
                      streamformat:"hls"
                      StreamBitrates:[384, 500, 1000, 15000]
                      StreamQualities:["SD", "SD", "SD","HD"]
                })

            end for
            m.canvas.clearLayer(178)
            m.canvas.clearLayer(179)
            m.canvas.clearLayer(180)
            m.canvas.clearLayer(199)
            selected=m.idVideosSelected
            selected = m.videoIndex 'TODO selected as index of array not as id
            m.app.player.previewmode=false
            if(m.app.trial)m.app.player.previewmode=true
            m.app.player.setPlaylist(playlist)
            m.app.player.setTrack(selected)

            m.app.player.play()
        endif
    else if (index=6 AND (m.currentLevel=0 OR m.currentLevel=1 OR m.currentLevel=2))
      print "not playing"
        if (NOT m.inTopMenu)
            if (m.idExploreSelected="11")

                ' TODO playlist


            endif
            if (m.idExploreSelected="10")
                maxSub = 2
            else
                maxSub = 4
            endif
            if (m.currentLevel<maxSub)
                m.currentLevel = m.currentLevel+1
                m.drawSelector(m.currentLevel)

                if (m.currentLevel=2)
                    m.resetPhantomLevel()
                    m.paintTopPhantomLevelFor()
                    m.paintLevelFor()
                    m.paintSubLevelFor(m.idExploreSelected)
                    m.drawSelector(3)
                    m.currentLevel=3
                    m.canvas.clearLayer(42)
                    'm.canvas.clearLayer(36)
                end if

            endif
            if (m.idExploreSelected="10")
                currentitems=m.videosArray
                playlist=[]
                for each item in currentitems
    
                    if (m.idExploreSelected="10")
                        playitem_url=item.url+"/"+item.filename
                    else
                        playitem_url="http://wpc.B624.edgecastcdn.net/00B624/"+item.video_url
                    endif
                    playitem_url=fixVideoUrl(playitem_url)
    
                    playlist.push({
                          id:item.id
                          thumbnail:item.thumbnail
                          stream:{url:playitem_url}
                          streamformat:"hls"
                          StreamBitrates:[384, 500, 1000, 15000]
                          StreamQualities:["SD", "SD", "SD","HD"]
                    })
    
                end for
                m.canvas.clearLayer(178)
                m.canvas.clearLayer(179)
                m.canvas.clearLayer(180)
                m.canvas.clearLayer(199)
                selected=m.idVideosSelected
                selected = m.videoIndex 'TODO selected as index of array not as id
                m.app.player.previewmode=false
                if(m.app.trial)m.app.player.previewmode=true
                m.app.player.setPlaylist(playlist)
                m.app.player.setTrack(selected)
    
                m.app.player.play()
            endif   
       endif
    else if (index=10) then
       m.app.section.show(playlists_section)
    end if
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Clear canvas for level above
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function clear_level() as void
    m.canvas.clearLayer(30)
    m.canvas.clearLayer(31)
    m.canvas.clearLayer(32)
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Clear canvas for level above
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function clear_sublevel() as void
    'm.canvas.clearLayer(33)
    m.canvas.clearLayer(34)
    m.canvas.clearLayer(35)
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Clear canvas for selector
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function clear_selector() as void
    m.canvas.clearLayer(29)
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Clear canvas for all
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function clear_all() as void
    m.canvas.clearLayer(17)
    m.canvas.clearLayer(29)
    'm.canvas.clearLayer(36)
    m.canvas.clearLayer(38)
    m.canvas.clearLayer(39)
    m.canvas.clearLayer(40)
    m.canvas.clearLayer(41)
    m.canvas.clearLayer(42)
    m.canvas.clearLayer(43)
    m.canvas.clearLayer(50)
    m.canvas.clearLayer(51)
    m.canvas.clearLayer(60)
    m.canvas.clearLayer(61)
    m.canvas.clearLayer(62)
    m.clearLevel()
    m.clearSubLevel()
    m.clearMarketing()
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' reseting explore values
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function reset_explore() as void
    m.clearLevel()
    m.exploreThumbnails=[]
    m.exploreTitles=[]
    m.exploreBackgrounds=[]
    m.explorePositions = {x:45, y: 120, w:269, h: 149}
    m.exploreBGPositions = {x:45, y: 242, w:269, h: 27}
    m.exploreTPositions = {x:45, y: 194, w:269, h: 125}
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' resettings level values
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function reset_level() as void
    m.clearLevel()
    m.levelThumbnails=[]
    m.levelTitles=[]
    m.levelBackgrounds=[]
    m.levelPositions = {x:45, y: 120, w:269, h: 149}
    m.levelBGPositions = {x:45, y: 244, w:269, h: 25}
    m.levelTitlePositions = {x:45, y: 196, w:269, h: 125}
    m.subLevelTitlePosition={x:45, y:520, w:300, h:32}
    m.subLevelDescriptionPosition={x:45, y:470, w:700, h:25}
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' resettings sublevel values
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function reset_sublevel() as void
    m.clearSubLevel()
    m.subLevelThumbnails=[]
    m.subLevelTitles=[]
    m.subLevelBackgrounds=[]
    m.subLevelPositions={x:45, y: 286, w:215, h: 119}
    m.subLevelBGPositions={x:45, y: 380, w:215, h: 25}
    m.subLevelTitlePositions={x:45, y: 382, w:215, h: 25}
    m.subLevelTitlePosition={x:45, y:485, w:700, h:32}
    m.subLevelDescriptionPosition={x:45, y:555, w:1100, h:50}
End Function


Function reset_phantom_level() as void
   m.canvas.clearLayer(38)
   m.canvas.clearLayer(39)
   m.canvas.clearLayer(60)
   m.canvas.clearLayer(61)
   m.canvas.clearLayer(62)
   m.phantomLevelThumbnails = []
   m.phantomLevelBackground = []
   m.phantomLevelPositions={x:45, y: 421, w:176, h: 98}
   m.phantomBGPositions={x:45, y: 421, w:176, h: 98}
End Function


Function reset_topphantom_level() as void
   m.canvas.clearLayer(40)
   m.canvas.clearLayer(41)
   m.canvas.clearLayer(43)
   m.topPhantomLevelThumbnails = []
   m.topPhantomLevelBackground = []
   m.topPhantomLevelPositions={x:45, y: -47, w:269, h: 149}
   m.topPhantomBGPositions={x:45, y: -47, w:269, h: 149}
   m.topPhantomTPositions={x:45, y: 18, w:269, h: 149}
End Function

function player_callback2(params)

    action=params.action
    if(action=1) 'Move Next Video
       m.scrollHorizontal(5)
    endif

end function

function carousel_scroll_horizontal2(index) as void

    if (index=4)
        m.moveLeft()
    else if (index=5)
        m.moveRight()
    endif

end function


function paint_top_shadow() as void
    shadows = []
    xshadow = 0
    For i=1 To 5 Step 1
        topShadow = {x:331 + xshadow, y:120, w:269, h: 149}
        shadows.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect: topShadow})
        xshadow = xshadow + 286
    End For
    m.canvas.setLayer(50, shadows)
end function


function paint_bottom_shadow() as void
    bshadows = []
    xbshadow=0
    For i=1 To m.placesArray.count()-1 Step 1
        bottomShadow = {x:276 + xbshadow, y:286, w:215, h: 119}
        bshadows.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect: bottomShadow})
        xbshadow = xbshadow + 231
    End For
    m.canvas.setLayer(51, bshadows)
end function


function clear_top_shadow() as void
    m.canvas.clearLayer(50)
end function


function clear_bottom_shadow() as void
    m.canvas.clearLayer(51)
end function
