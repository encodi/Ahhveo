' ********************************************************************
' ********************************************************************
' **  Roku Custom Video player2 Channel (BrightScript)
' **
' **  May 2010
' **  Copyright (c) 2010 Roku Inc. All Rights Reserved.
' ********************************************************************
' ********************************************************************


Function VideoSetup(s) As Object
    this = {
        app:s
        port2:      CreateObject("roMessageport")
        progress:  0 'buffering progress
        position:  0 'playback position (in seconds)
        paused:    false 'is the video currently paused?
        fonts:     CreateObject("roFontRegistry") 'global font registry
        canvas2:    CreateObject("roImagecanvas") 'user interface
        player2:    CreateObject("roVideoplayer")
        setup:     SetupFramedcanvas2
        paint:     PaintFramedcanvas2
        eventloop: EventLoop2
    }

    
    'Setup image canvas2:
    this.canvas2.SetMessageport(this.port2)
    this.canvas2.SetLayer(100, { Color: "#000000" })
    
    

    'Resolution-specific settings:
    mode = CreateObject("roDeviceInfo").GetDisplayMode()
    if mode = "720p"
        this.layout2 = {
            full:   this.canvas2.GetcanvasRect()
            top:    { x:   0, y:   0, w:1280, h: 130 }
            left:   { x: 200, y: 100, w: 900, h: 500 }
            right:  { x: 700, y: 177, w: 350, h: 291 }
            bottom: { x: 249, y: 500, w: 780, h: 300 }
        }
    
    else
        this.layout2 = {
            full:   this.canvas2.GetcanvasRect()
            top:    { x:   0, y:   0, w: 720, h:  80 }
            left:   { x: 113, y: 67, w: 506, h: 333 }
            right:  { x: 400, y: 100, w: 220, h: 210 }
            bottom: { x: 100, y: 340, w: 520, h: 140 }
        }
    
    end if
    
    this.canvas2.Show()
    
    this.player2.SetMessageport(this.port2)
    this.player2.SetLoop(true)
    this.player2.SetPositionNotificationPeriod(1)
    this.player2.SetDestinationRect(this.layout2.left)
    this.player2.SetMaxVideoDecodeResolution(1280,720)
    this.player2.SetContentList([{
        Stream: { url: "http://wpc.b624.edgecastcdn.net/00B624/videos/roku/Roku_IntroVid_149v6_no_XMAS/Roku_IntroVid_149v6_no_XMAS.m3u8" }
        StreamFormat: "hls"
    }])
    this.app.audio.player.stop()
    this.player2.Play()'this start to play the video tutorial

    return this
End Function

Sub EventLoop2()
    while true
        msg = wait(320, m.port2)
        if msg <> invalid
            'If this is a startup progress status message, record progress
            'and update the UI accordingly:
            if msg.isStatusMessage() and msg.GetMessage() = "startup progress"
                m.paused = false
                progress% = msg.GetIndex() / 10
                if m.progress <> progress%
                    m.progress = progress%
                    m.paint()
                    
                end if

            'Playback progress (in seconds):
            else if msg.isPlaybackPosition()
                'm.player2.GetPlaybackDuration() 'duration of video 
                m.position = msg.GetIndex()
                'print m.position
                'if (m.position MOD 2 = 0)
                    dr = m.app.http.getWs("logState.php?userID="+m.app.getRegistry()+"&leftAt=video_tutorial&videoPosition="+m.position.tostr())
                'endif
                m.paint() '                
                if (m.position>=(m.player2.GetPlaybackDuration()-1)) ' end of video
                    m.player2.stop()
                    m.canvas2.Clear()
                    m.canvas2.clearLayer(100)
                    m.canvas2.clearLayer(199)
                    m.player2.ClearContent()
                    m.canvas2.close()
                    return
                endif
            'If the <UP> key is pressed, jump out of this context:
            else if msg.isRemoteKeyPressed()
                if(m.app.deviceinfo.getLinkStatus()=false) m.app.dialog.alert2("Your connection to the server was lost. Try checking your network settings. Thank you.")
                index = msg.GetIndex()
                print index
                'if index = 2  '<UP>
                   m.player2.stop()
                   m.canvas2.Clear()
                   m.canvas2.clearLayer(100)
                   m.canvas2.clearLayer(199)
                   '
                   m.player2.ClearContent()
                   m.canvas2.close()
                  return
                'else if index = 3 '<DOWN> (toggle fullscreen)
                '    m.player2.stop()
                '    m.canvas2.Clear()
                '    m.canvas2.clearLayer(100)
                '    m.canvas2.clearLayer(199)
                    
                '    m.player2.ClearContent()
                '    m.canvas2.close()
                '    return
                'else if index = 4 or index = 8  '<LEFT> or <REV>
                '    m.player2.stop()
                '    m.canvas2.Clear()
                '    m.canvas2.clearLayer(100)
                '    m.canvas2.clearLayer(199)
                    
                '    m.player2.ClearContent()
                '    m.canvas2.close()
                '    return
                'else if index = 5 or index = 9  '<RIGHT> or <FWD>
                '  m.player2.stop()
                '    m.canvas2.Clear()
                '    m.canvas2.clearLayer(100)
                '    m.canvas2.clearLayer(199)
                '    m.player2.ClearContent()
                '    m.canvas2.close()
                '    return
                'else if index = 13  '<PAUSE/PLAY>
                '    if m.paused m.player2.Resume() else m.player2.Pause()
                'end if

            else if msg.isPaused()
                m.paused = true
                m.paint()

            else if msg.isResumed()
                m.paused = false
                m.paint()

            end if
            'Output events for debug
            
            'if msg.GetInfo() <> invalid print msg.GetInfo();
        end if
    end while
End Sub

Sub SetupFullscreencanvas2()
    m.canvas2.AllowUpdates(false)
    m.paint()
    m.canvas2.AllowUpdates(true)
End Sub

Sub PaintFullscreencanvas2()
    'list = []

    'if m.progress < 100
    '    color = "#000000" 'opaque black
    '    list.Push({
    '        Text: "Loading..." + m.progress.tostr() + "%"
    '        TextAttrs: { font: "huge" }
    '        TargetRect: m.layout2.full
    '    })
    'else if m.paused
    '    color = "#80000000" 'semi-transparent black
    '    list.Push({
    '        Text: "Paused"
    '        TextAttrs: { font: "huge" }
    '        TargetRect: m.layout2.full
    '    })
    'else
    '    color = "#00000000" 'fully transparent
    'end if

    'm.canvas2.SetLayer(100, { Color: color, CompositionMode: "Source" })
   ' m.canvas2.SetLayer(199, list)
End Sub

Sub SetupFramedcanvas2()
    m.canvas2.AllowUpdates(false)
    m.canvas2.Clear()
    m.paint()
    m.canvas2.AllowUpdates(true)
    
End Sub

Sub PaintFramedcanvas2()
    list = []
    if m.progress < 100  'Video is currently buffering
        list.Push({
            Color: "#80000000"
            TargetRect: m.layout2.left
        })
        list.Push({
            Text: "Loading..."' + m.progress.tostr() + "%"
            TargetRect: m.layout2.left
        })
    else  'Video is currently playing
        if m.paused
            list.Push({
                Color: "#80000000"
                TargetRect: m.layout2.left
                CompositionMode: "Source"
            })
            list.Push({
                Text: "Paused"
                TargetRect: m.layout2.left
            })
        else  'not paused
            list.Push({
                Color: "#00000000"
                TargetRect: m.layout2.left
                CompositionMode: "Source"
            })
        end if
    end if
    m.canvas2.SetLayer(199, list)
End Sub
