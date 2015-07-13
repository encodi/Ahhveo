Function Thumby(arguments) as object
    
    this = {
        app:arguments.app,
        canvas:arguments.canvas,
        remoteCallback:handle_carousel_keys,
        paint:initThumby
        paintLevel:paint_level
        paintMovedLevel:paint_moved_level
        repaintLevel:repaint_level
        drawSelector:draw_selector
        moveThumbnails:move_thumbnails
        mainThumbs:[]
        allData:[]
        mainThumbnails:[]
        mainThumbnailsTitles:[]
        mainThumbnailsTitlesBackground:[]
        categoryThumbs:[]
        categoryThumbnails:[]
        categoryThumbnailsTitles:[]
        categoryThumbnailsTitlesBackground:[]
        subCategoryThumbs:[]
        subCategoryThumbnails:[]
        subCategoryThumbnailsTitles:[]
        subCategoryThumbnailsTitlesBackground:[]
        elementThumbs:[]
        elementThumbnails:[]
        elementThumbnailsTitles:[]
        elementThumbnailsTitlesBackground:[]
        movedItems:[]
        mainPositions:CreateObject("roAssociativeArray")
        resetMainPositions:reset_main_positions
        mainSelected:0
        clearThumby:clear_thumby
        atLevel:0
        previousLevel:0
        havePlaces:false
        haveSubPlaces:false
        haveVideos:false
    }    
    
    return this
    
End Function

Function initThumby() as void
    
    ' variables
    m.mainPositions = {x:100, y: 120, w:250, h: 150, catPos: 0, subCatPos: 0, subCatW: 230, subCatH: 130, deltaX: 280, deltaY: 200, subDeltaY: 180, titleY:175, titleH:150, bgY:220, bgH:50}
    
    ' clear up
    m.canvas.clearlayer(100)
    m.canvas.clearlayer(101)
    m.canvas.clearlayer(104)
    m.canvas.clearlayer(105)
    
    ' get main thumbnails data (this can be changed to whatever webservice needed)
    m.mainThumbs=m.app.http.getWs("getExplore.php")
    'm.allData = m.app.http.getWs("getNextLevel.php?eid=1")
    
    ' fill the array to paint in screen the thumbnails with a title and a opaque black layer
    for each thumb in m.mainThumbs
        m.mainThumbnails.push({url: thumb.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.y,w:m.mainPositions.w,h:m.mainPositions.h}})
        m.mainThumbnailsTitles.push({text: thumb.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.titleY,w:m.mainPositions.w,h:m.mainPositions.titleH}})
        m.mainThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.bgY,w:m.mainPositions.w,h:m.mainPositions.bgH}})
        m.mainPositions.catPos = m.mainPositions.catPos + m.mainPositions.deltaX
    end for    
    
    ' reset moved items
    m.movedItems = []
    
    ' current focus
    m.atLevel = 0
    
    ' who is first selected (id for relatioship)
    m.mainSelected = m.mainThumbs[0].id
    
    ' show next level of who is selected
    m.paintLevel(1)
    
    ' paint selector
    m.drawSelector(0)
    
    ' painting the array in the canvas
    m.canvas.setlayer(30, m.mainThumbnails)
    m.canvas.setlayer(31, m.mainThumbnailsTitlesBackground)
    m.canvas.setlayer(32, m.mainThumbnailsTitles)
    
End Function

Function paint_level(aLevel) as void
    ' clean up before repaint
    m.resetMainPositions()
    'm.clearThumby()
    m.movedItems = []
    
    if (aLevel=0) then
        ' main level
        m.canvas.clearlayer(30)
        m.canvas.clearlayer(31)
        m.canvas.clearlayer(32)
        m.mainThumbnails = []
        m.mainThumbnailsTitles = []
        m.mainThumbnailsTitlesBackground = []
        m.mainThumbs=m.app.http.getWs("getExplore.php")
        for each thumb in m.mainThumbs
            m.mainThumbnails.push({url: thumb.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.y,w:m.mainPositions.w,h:m.mainPositions.h}})
            m.mainThumbnailsTitles.push({text: thumb.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.titleY,w:m.mainPositions.w,h:m.mainPositions.titleH}})
            m.mainThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.bgY,w:m.mainPositions.w,h:m.mainPositions.bgH}})
            m.mainPositions.catPos = m.mainPositions.catPos + m.mainPositions.deltaX
        end for  
        m.canvas.setlayer(30, m.mainThumbnails)
        m.canvas.setlayer(31, m.mainThumbnailsTitlesBackground)
        m.canvas.setlayer(32, m.mainThumbnailsTitles)
    else if (aLevel=1) then
        ' We paint a category, a subcategory if there is not category, or a videos if there is not subcategory 
        ' obtaining data
        m.canvas.clearlayer(33)
        m.canvas.clearlayer(34)
        m.canvas.clearlayer(35)
        m.categoryThumbnails = []
        m.categoryThumbnailsTitles = []
        m.categoryThumbnailsTitlesBackground = []
        m.subCategoryThumbnails = []
        m.subCategoryThumbnailsTitles = []
        m.subCategoryThumbnailsTitlesBackground = []
        m.elementThumbnails = []
        m.elementThumbnailsTitles = []
        m.elementThumbnailsTitlesBackground = []
        generalData = m.app.http.getWs("getNextLevel.php?eid="+m.mainSelected)
            
            if (generalData[0].hasplaces) then
                if (generalData[0].places.count()>0) then ' check if it has elements on category, we paint this one 
                    print "painting places"
                    m.categoryThumbs = generalData[0].places ' saving data in local var
                    for each category in m.categoryThumbs
                        m.categoryThumbnails.push({url: category.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.y+m.mainPositions.deltaY,w:m.mainPositions.subCatW,h:m.mainPositions.subCatH}})
                        m.categoryThumbnailsTitles.push({text: category.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.titleY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.titleH}})
                        m.categoryThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.bgY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.bgH}})
                        m.mainPositions.subCatPos = m.mainPositions.subCatPos + m.mainPositions.deltaX
                    end for
                    m.canvas.setlayer(33, m.categoryThumbnails)
                    m.canvas.setlayer(34, m.categoryThumbnailsTitlesBackground)
                    m.canvas.setlayer(35, m.categoryThumbnailsTitles)

                end if
            else if (generalData[0].hassubplaces) then
                 if (generalData[0].subplaces.count()>0) then ' check if subcategories are not empty, we paint this one instead
                    print "painting subplaces"
                    m.subCategoryThumbs = generalData[0].subplaces ' saving data in local var
                    for each subCategory in m.subCategoryThumbs
                        m.subCategoryThumbnails.push({url: subCategory.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.y+m.mainPositions.deltaY,w:m.mainPositions.subCatW,h:m.mainPositions.subCatH}})
                        m.subCategoryThumbnailsTitles.push({text: subCategory.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.titleY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.titleH}})
                        m.subCategoryThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.bgY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.bgH}})
                        m.mainPositions.subCatPos = m.mainPositions.subCatPos + m.mainPositions.deltaX
                    end for
                    m.canvas.setlayer(33, m.subCategoryThumbnails)
                    m.canvas.setlayer(34, m.subCategoryThumbnailsTitlesBackground)
                    m.canvas.setlayer(35, m.subCategoryThumbnailsTitles)
                 end if
             else if (generalData[0].hasvideos) then
                if (generalData[0].videos.count()>0) then ' check if elements are not empty, we paint this one instead
                    print "painting videos"
                    m.elementThumbs = generalData[0].videos ' saving data in local var
                    for each element in m.elementThumbs
                        print element
                        m.elementThumbnails.push({url: element.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.y+m.mainPositions.deltaY,w:m.mainPositions.subCatW,h:m.mainPositions.subCatH}})
                        m.elementThumbnailsTitles.push({text: element.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.titleY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.titleH}})
                        m.elementThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.bgY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.bgH}})
                        m.mainPositions.subCatPos = m.mainPositions.subCatPos + m.mainPositions.deltaX
                    end for
                    m.canvas.setlayer(33, m.elementThumbnails)
                    m.canvas.setlayer(34, m.elementThumbnailsTitlesBackground)
                    m.canvas.setlayer(35, m.elementThumbnailsTitles)
                    
                end if
            end if
    else if (aLevel=2) then
        ' We repaint top level and children level here
        m.canvas.clearlayer(30)
        m.canvas.clearlayer(31)
        m.canvas.clearlayer(32)
        m.subCategoryThumbnails = []
        m.subCategoryThumbnailsTitles = []
        m.subCategoryThumbnailsTitlesBackground = []
        m.elementThumbnails = []
        m.elementThumbnailsTitles = []
        m.elementThumbnailsTitlesBackground = []
        
        generalData = m.app.http.getWs("getNextLevel.php?eid="+m.mainSelected)
        
        if (generalData[0].hassubplaces) then
            if (generalData[0].subplaces.count()>0) then ' check if subcategories are not empty, we paint this one instead
                
                m.subCategoryThumbs = generalData[0].subplaces ' saving data in local var
                for each subCategory in m.subCategoryThumbs
                    m.subCategoryThumbnails.push({url: subCategory.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.y,w:m.mainPositions.w,h:m.mainPositions.h}})
                    m.subCategoryThumbnailsTitles.push({text: subCategory.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.titleY,w:m.mainPositions.w,h:m.mainPositions.titleH}})
                    m.subCategoryThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.bgY,w:m.mainPositions.w,h:m.mainPositions.bgH}})
                    m.mainPositions.catPos = m.mainPositions.catPos + m.mainPositions.deltaX
                end for
                m.canvas.setlayer(30, m.subCategoryThumbnails)
                m.canvas.setlayer(31, m.subCategoryThumbnailsTitlesBackground)
                m.canvas.setlayer(32, m.subCategoryThumbnailsTitles)
                
            end if
        else if (generalData[0].hasvideos) then   
            if (generalData[0].videos.count()>0) then ' check if elements are not empty, we paint this one instead
                print "videos"
                print generalData[0].videos
            
                m.elementThumbs = generalData[0].videos ' saving data in local var
                for each element in m.elementThumbs
                    print "video"
                    print element
                    m.elementThumbnails.push({url: element.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.y,w:m.mainPositions.w,h:m.mainPositions.h}})
                    m.elementThumbnailsTitles.push({text: element.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.titleY,w:m.mainPositions.w,h:m.mainPositions.titleH}})
                    m.elementThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.bgY,w:m.mainPositions.w,h:m.mainPositions.bgH}})
                    m.mainPositions.catPos = m.mainPositions.catPos + m.mainPositions.deltaX
                    
                    'm.elementThumbnails.push({url: element.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.y+m.mainPositions.deltaY,w:m.mainPositions.subCatW,h:m.mainPositions.subCatH}})
                    'm.elementThumbnailsTitles.push({text: element.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.titleY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.titleH}})
                    'm.elementThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.bgY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.bgH}})
                    'm.mainPositions.subCatPos = m.mainPositions.subCatPos + m.mainPositions.deltaX
                end for
                m.canvas.setlayer(30, m.elementThumbnails)
                m.canvas.setlayer(31, m.elementThumbnailsTitlesBackground)
                m.canvas.setlayer(32, m.elementThumbnailsTitles)
                
            end if   
        end if
    else if (aLevel=3) then
        m.canvas.clearlayer(33)
        m.canvas.clearlayer(34)
        m.canvas.clearlayer(35)
        m.elementThumbnails = []
        m.elementThumbnailsTitles = []
        m.elementThumbnailsTitlesBackground = []
        ' We paint videos bottom level
        m.canvas.clearlayer(33)
        m.canvas.clearlayer(34)
        m.canvas.clearlayer(35)
        generalData = m.app.http.getWs("getNextLevel.php?eid="+m.mainSelected)
        if (generalData[0].hasvideos) then
            if (generalData[0].videos.count()>0) then ' check if elements are not empty, we paint this one instead
                m.elementThumbs = generalData[0].videos ' saving data in local var
                for each element in m.elementThumbs
                    m.elementThumbnails.push({url: element.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.y+m.mainPositions.deltaY,w:m.mainPositions.subCatW,h:m.mainPositions.subCatH}})
                    m.elementThumbnailsTitles.push({text: element.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.titleY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.titleH}})
                    m.elementThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.bgY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.bgH}})
                    m.mainPositions.subCatPos = m.mainPositions.subCatPos + m.mainPositions.deltaX
                end for
                m.canvas.setlayer(33, m.elementThumbnails)
                m.canvas.setlayer(34, m.elementThumbnailsTitlesBackground)
                m.canvas.setlayer(35, m.elementThumbnailsTitles)
                        
            end if
        end if
    end if
    
End Function

Function paint_moved_level(aLevel) as void
    ' clean up before repaint
    m.resetMainPositions()
    'm.clearThumby()
    m.movedItems = []
    
    if (aLevel=0) then
        ' main level
        m.canvas.clearlayer(30)
        m.canvas.clearlayer(31)
        m.canvas.clearlayer(32)
        m.mainThumbnails = []
        m.mainThumbnailsTitles = []
        m.mainThumbnailsTitlesBackground = []
        
        for each thumb in m.mainThumbs
            m.mainThumbnails.push({url: thumb.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.y,w:m.mainPositions.w,h:m.mainPositions.h}})
            m.mainThumbnailsTitles.push({text: thumb.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.titleY,w:m.mainPositions.w,h:m.mainPositions.titleH}})
            m.mainThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.catPos,y:m.mainPositions.bgY,w:m.mainPositions.w,h:m.mainPositions.bgH}})
            m.mainPositions.catPos = m.mainPositions.catPos + m.mainPositions.deltaX
        end for  
        m.canvas.setlayer(30, m.mainThumbnails)
        m.canvas.setlayer(31, m.mainThumbnailsTitlesBackground)
        m.canvas.setlayer(32, m.mainThumbnailsTitles)
    else if (aLevel=1) then
        ' We paint a category, a subcategory if there is not category, or a videos if there is not subcategory 
        ' obtaining data from the new array of moved elements
        m.canvas.clearlayer(33)
        m.canvas.clearlayer(34)
        m.canvas.clearlayer(35)
        m.categoryThumbnails = []
        m.categoryThumbnailsTitles = []
        m.categoryThumbnailsTitlesBackground = []
        m.subCategoryThumbnails = []
        m.subCategoryThumbnailsTitles = []
        m.subCategoryThumbnailsTitlesBackground = []
        m.elementThumbnails = []
        m.elementThumbnailsTitles = []
        m.elementThumbnailsTitlesBackground = []
        if (m.categoryThumbs.count()>0) then ' check if it has elements on category, we paint this one 
            
            for each category in m.categoryThumbs
                m.categoryThumbnails.push({url: category.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.y+m.mainPositions.deltaY,w:m.mainPositions.subCatW,h:m.mainPositions.subCatH}})
                m.categoryThumbnailsTitles.push({text: category.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.titleY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.titleH}})
                m.categoryThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.bgY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.bgH}})
                m.mainPositions.subCatPos = m.mainPositions.subCatPos + m.mainPositions.deltaX
            end for
            m.canvas.setlayer(33, m.categoryThumbnails)
            m.canvas.setlayer(34, m.categoryThumbnailsTitlesBackground)
            m.canvas.setlayer(35, m.categoryThumbnailsTitles)
            
        else if (m.subCategoryThumbs.count()>0) then ' check if subcategories are not empty, we paint this one instead
            
            for each subCategory in m.subCategoryThumbs
                m.subCategoryThumbnails.push({url: subCategory.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.y+m.mainPositions.deltaY,w:m.mainPositions.subCatW,h:m.mainPositions.subCatH}})
                m.subCategoryThumbnailsTitles.push({text: subCategory.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.titleY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.titleH}})
                m.subCategoryThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.bgY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.bgH}})
                m.mainPositions.subCatPos = m.mainPositions.subCatPos + m.mainPositions.deltaX
            end for
            m.canvas.setlayer(33, m.subCategoryThumbnails)
            m.canvas.setlayer(34, m.subCategoryThumbnailsTitlesBackground)
            m.canvas.setlayer(35, m.subCategoryThumbnailsTitles)
            
        else if (m.elementThumbs.count()>0) then ' check if elements are not empty, we paint this one instead
        
            for each element in m.elementThumbs
                m.elementThumbnails.push({url: element.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.y+m.mainPositions.deltaY,w:m.mainPositions.subCatW,h:m.mainPositions.subCatH}})
                m.elementThumbnailsTitles.push({text: element.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.titleY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.titleH}})
                m.elementThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.bgY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.bgH}})
                m.mainPositions.subCatPos = m.mainPositions.subCatPos + m.mainPositions.deltaX
            end for
            m.canvas.setlayer(33, m.elementThumbnails)
            m.canvas.setlayer(34, m.elementThumbnailsTitlesBackground)
            m.canvas.setlayer(35, m.elementThumbnailsTitles)
                    
        end if
    else if (aLevel=2) then
        ' We repaint top level and children level here
        m.canvas.clearlayer(33)
        m.canvas.clearlayer(34)
        m.canvas.clearlayer(35)
        m.subCategoryThumbnails = []
        m.subCategoryThumbnailsTitles = []
        m.subCategoryThumbnailsTitlesBackground = []
        m.elementThumbnails = []
        m.elementThumbnailsTitles = []
        m.elementThumbnailsTitlesBackground = []
        if (m.subCategoryThumbs.count()>0) then ' check if subcategories are not empty, we paint this one instead
            
            for each subCategory in m.subCategoryThumbs
                m.subCategoryThumbnails.push({url: subCategory.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.y+m.mainPositions.deltaY,w:m.mainPositions.subCatW,h:m.mainPositions.subCatH}})
                m.subCategoryThumbnailsTitles.push({text: subCategory.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.titleY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.titleH}})
                m.subCategoryThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.bgY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.bgH}})
                m.mainPositions.subCatPos = m.mainPositions.subCatPos + m.mainPositions.deltaX
            end for
            m.canvas.setlayer(33, m.subCategoryThumbnails)
            m.canvas.setlayer(34, m.subCategoryThumbnailsTitlesBackground)
            m.canvas.setlayer(35, m.subCategoryThumbnailsTitles)
            
        else if (m.ElementThumbs.count()>0) then ' check if elements are not empty, we paint this one instead
        
            for each element in m.elementThumbs
                m.elementThumbnails.push({url: element.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.y+m.mainPositions.deltaY,w:m.mainPositions.subCatW,h:m.mainPositions.subCatH}})
                m.elementThumbnailsTitles.push({text: element.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.titleY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.titleH}})
                m.elementThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.bgY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.bgH}})
                m.mainPositions.subCatPos = m.mainPositions.subCatPos + m.mainPositions.deltaX
            end for
            m.canvas.setlayer(33, m.elementThumbnails)
            m.canvas.setlayer(34, m.elementThumbnailsTitlesBackground)
            m.canvas.setlayer(35, m.elementThumbnailsTitles)
                            
        end if
    else if (aLevel=3) then
        m.canvas.clearlayer(33)
        m.canvas.clearlayer(34)
        m.canvas.clearlayer(35)
        m.elementThumbnails = []
        m.elementThumbnailsTitles = []
        m.elementThumbnailsTitlesBackground = []
        ' We paint videos bottom level
        if (m.elementThumbs.count()>0) then ' check if elements are not empty, we paint this one instead
        
            for each element in m.elementThumbs
                m.elementThumbnails.push({url: element.thumbnail, targetRect: {x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.y+m.mainPositions.deltaY,w:m.mainPositions.subCatW,h:m.mainPositions.subCatH}})
                m.elementThumbnailsTitles.push({text: element.title, textAttrs: {font: m.app.h2}, targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.titleY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.titleH}})
                m.elementThumbnailsTitlesBackground.push({Color:"#a0000000", compositionMode: "Source_Over", targetRect:{x:m.mainPositions.x+m.mainPositions.subCatPos,y:m.mainPositions.bgY+m.mainPositions.subDeltaY,w:m.mainPositions.subCatW,h:m.mainPositions.bgH}})
                m.mainPositions.subCatPos = m.mainPositions.subCatPos + m.mainPositions.deltaX
            end for
            m.canvas.setlayer(33, m.elementThumbnails)
            m.canvas.setlayer(34, m.elementThumbnailsTitlesBackground)
            m.canvas.setlayer(35, m.elementThumbnailsTitles)
                    
        end if
    end if
    
End Function

Function draw_selector(forLevel=false) as void

    if (forLevel=false) then 
        forLevel=m.atLevel
    end if
    url_rings=[]
    pos_rings=[]
    url_rings.push("pkg:/images/ring_level_1.png")
    url_rings.push("pkg:/images/ring_level_2.png")
    url_rings.push("pkg:/images/ring_level_2.png")
    url_rings.push("pkg:/images/ring_level_2.png")
    
    pos_rings.push({x:95,y:115,w:260,h:160})
    pos_rings.push({x:95,y:315,w:240,h:140})
    pos_rings.push({x:95,y:115,w:260,h:160})
    pos_rings.push({x:95,y:315,w:240,h:140})
    
    print forLevel
    ring={
        url:url_rings[forLevel],
        targetRect:pos_rings[forLevel]
    }
    
    m.canvas.setLayer(29,ring)
    
End Function

Function move_thumbnails(inDirection) as void
    
    if (inDirection = "left") then
    
        if (m.atLevel=0) then
            for i=0 to (m.mainThumbs.count()-1)
                j=i
                if (m.mainThumbs[j-1]<>invalid) then
                    m.movedItems[i] = m.mainThumbs[j-1]
                else
                    m.movedItems[i] = m.mainThumbs[m.mainThumbs.count()-1]
                end if   
            end for
            m.mainThumbs = m.movedItems
            m.paintMovedLevel(m.atLevel)
            m.mainSelected = m.mainThumbs[0].id
            m.paintLevel(1)
        else if (m.atLevel=1) then
            
            if (m.categoryThumbs<>invalid) then
                if (m.categoryThumbs.count()>0) then
                    for i=0 to (m.categoryThumbs.count()-1)
                        j=i
                        if (m.categoryThumbs[j-1]<>invalid) then
                            m.movedItems[i] = m.categoryThumbs[j-1]
                        else
                            m.movedItems[i] = m.categoryThumbs[m.categoryThumbs.count()-1]
                        end if   
                    end for
                    m.categoryThumbs = m.movedItems
                    m.paintMovedLevel(m.atLevel)
                    m.mainSelected = m.categoryThumbs[0].id
                end if
            else if (m.subcategoryThumbs<>invalid) then
                if (m.subCategoryThumbs.count()>0) then
                    for i=0 to (m.subCategoryThumbs.count()-1)
                        j=i
                        if (m.subCategoryThumbs[j-1]<>invalid) then
                            m.movedItems[i] = m.subCategoryThumbs[j-1]
                        else
                            m.movedItems[i] = m.subCategoryThumbs[m.subCategoryThumbs.count()-1]
                        end if   
                    end for
                    m.subCategoryThumbs = m.movedItems
                    m.paintMovedLevel(m.atLevel)
                    m.mainSelected = m.subCategoryThumbs[0].id
                end if
            else if (m.elementThumbs<>invalid) then
                if (m.elementThumbs.count()>0) then
                    for i=0 to (m.elementThumbs.count()-1)
                        j=i
                        if (m.elementThumbs[j-1]<>invalid) then
                            m.movedItems[i] = m.elementThumbs[j-1]
                        else
                            m.movedItems[i] = m.elementThumbs[m.elementThumbs.count()-1]
                        end if   
                    end for
                    m.elementThumbs = m.movedItems
                    m.paintMovedLevel(m.atLevel)
                    m.mainSelected = m.elementThumbs[0].id
                end if
            end if
        end if
        
    else if (inDirection = "right") then
    
        if (m.atLevel=0) then
            for i=0 to (m.mainThumbs.count()-1)
                j=i
                if (m.mainThumbs[j+1]<>invalid) then
                    m.movedItems[i] = m.mainThumbs[j+1]
                else
                    m.movedItems[i] = m.mainThumbs[0]
                end if  
            end for
            m.mainThumbs = m.movedItems
            m.paintMovedLevel(m.atLevel)
            m.mainSelected = m.mainThumbs[0].id
            m.paintLevel(1)
        else if (m.atLevel=1 OR m.atLevel=2 OR m.atLevel=3) then
            if (m.categoryThumbs<>invalid) then
                if (m.categoryThumbs.count()>0) then
                    for i=0 to (m.categoryThumbs.count()-1)
                        j=i
                        if (m.categoryThumbs[j+1]<>invalid) then
                            m.movedItems[i] = m.categoryThumbs[j+1]
                        else
                            m.movedItems[i] = m.categoryThumbs[0]
                        end if  
                    end for
                    m.categoryThumbs = m.movedItems
                    m.paintMovedLevel(m.atLevel)
                    m.mainSelected = m.categoryThumbs[0].id
                end if
            else if (m.subcategoryThumbs<>invalid) then
                if (m.subCategoryThumbs.count()>0) then
                    for i=0 to (m.subCategoryThumbs.count()-1)
                        j=i
                        if (m.subCategoryThumbs[j+1]<>invalid) then
                            m.movedItems[i] = m.subCategoryThumbs[j+1]
                        else
                            m.movedItems[i] = m.subCategoryThumbs[0]
                        end if  
                    end for
                    m.subCategoryThumbs = m.movedItems
                    m.paintMovedLevel(m.atLevel)
                    m.mainSelected = m.subCategoryThumbs[0].id
                end if
            else if (m.elementThumbs<>invalid) then
                if (m.elementThumbs.count()>0) then
                    for i=0 to (m.elementThumbs.count()-1)
                        j=i
                        if (m.elementThumbs[j+1]<>invalid) then
                            m.movedItems[i] = m.elementThumbs[j+1]
                        else
                            m.movedItems[i] = m.elementThumbs[0]
                        end if  
                    end for
                    m.elementThumbs = m.movedItems
                    m.paintMovedLevel(m.atLevel)
                    m.mainSelected = m.elementThumbs[0].id
                end if
            end if
        end if
        
    end if
    
End Function

Function repaint_level() as void

    if (m.atLevel=0) then
        print "do nothing"
    else if (m.atLevel=1) then
        if (m.previousLevel=2)
            print "painting 0 and 1"
            'm.paintOver(0,"top")
            'm.paintOver(1,"bottom")
            m.paintLevel(0)
            m.paintLevel(1)
        else
            print "do nothing"
        end if
    else if (m.atLevel=2) then
        if (m.previousLevel=1)
            print "painting 2 and 3"
            'm.paintOver(2,"top")
            'm.paintOver(3,"bottom")
            m.paintLevel(2)
            m.paintLevel(3)
        else
            print "do nothing"
        endif
    else if (m.atLevel=3) then
        print "do nothing"
    end if

End Function

Function handle_carousel_keys(index) as void
    
    print index
    if (index=2) then ' up
        m.previousLevel = m.atLevel
        if (m.atLevel>0) then
            m.atLevel = m.atLevel - 1
        end if
        m.repaintLevel()
        m.drawSelector(m.atLevel)
    else if (index=3) then ' down
        m.previousLevel = m.atLevel
        if (m.atLevel<3) then
            m.atLevel = m.atLevel + 1
        end if
        m.repaintLevel()
        m.drawSelector(m.atLevel)
    else if (index=4) then ' left
        m.moveThumbnails("left")
    else if (index=5) then ' right
        m.moveThumbnails("right")
    else if (index=7) then
       m.app.setLogo()
       m.app.setBackground()

       menu=CreateMenu(m.app)
       m.app.items=[] 
       m.app.items.push({action:relaxnow_section,label:"Relax Now"})
       m.app.items.push({action:places_section,label:"Relax"})
       m.app.items.push({action:customize_section,label:"Customize"})
       m.app.items.push({action:information_section,label:"Information"})
       menu.setOptions(m.app.items)
        
       m.app.menu=menu
       m.inNews=true
       menu.render(0)
       m.app.menu.unmark()
       m.app.menu.inMain=true
       m.clearThumby()
       m.app.menu.drawLineReference()
       m.app.isPlaces=true
       m.app.section.show(home_section)
       m.app.inNews=true
       m.app.audio.play("Ocean_Waves.wma","Ocean_Waves.wma")
    end if
    
End Function

Function reset_main_positions() as void
    m.mainPositions = {x:100, y: 120, w:250, h: 150, catPos: 0, subCatPos: 0, subCatW: 230, subCatH: 130, deltaX: 280, deltaY: 200, subDeltaY: 180, titleY:175, titleH:150, bgY:220, bgH:50}
End Function

Function clear_thumby() as void
    m.canvas.clearlayer(29)
    m.canvas.clearlayer(30)
    m.canvas.clearlayer(31)
    m.canvas.clearlayer(32)
    m.canvas.clearlayer(33)
    m.canvas.clearlayer(34)
    m.canvas.clearlayer(35)
End Function