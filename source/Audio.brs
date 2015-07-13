function NewAudio(o) as Object

    this={
         app:o
         player:CreateObject("roAudioPlayer")
         play:audio_play
         stop:audio_stop
         setTrack:audio_set_track
         port:o.port
         port2:CreateObject("roMessagePort")
         track:""
         }


        this.player.setMessagePort(o.port)


    return this
end function



function audio_set_track(track_url) as void
    song = CreateObject("roAssociativeArray")
    song.url = track_url
    m.player.clearContent()
    m.player.addcontent(song)
    m.player.SetNext(0)
    m.player.SetLoop(true)
    m.track=track_url

end function


Function audio_stop() as void
    m.player.Stop()
End Function

'Function audio_play2() as void
'End Function

Function audio_play(url,filename) as void

    'Still Until VideoPlayer waste the streaming segment
    sleep(2000)
 
    filename=filename
    tmp_dir=ListDir("tmp:/")
    drive="tmp:/"
    
    
    isdownloaded=false
    for each l in tmp_dir
        if(l=filename)
            isdownloaded=true
            exit for
        endif
    end for
    
    sounds_dir=ListDir("pkg:/sounds/")
    islocal=false
    for each s in sounds_dir
        if(s=url)
            islocal=true
            drive="pkg:/sounds/"
            exit for
        endif
    endfor
        
    if(isdownloaded=false and islocal=false)DownloadFile(url,filename)
    
    m.setTrack(drive+filename)  
    m.player.play()
       ' while true
         '   msg = wait(0, m.port2)
         '   if type(msg) = "roAudioPlayerEvent"
         '           if msg.isStatusMessage() then
         ''               if msg.getmessage() = "end of playlist" return
         '               if msg.getmessage() = "end of stream"
         '                   m.player.play()
        '                end if
        '            endif
        '    else
        '        if event.isRemoteKeyPressed()
        '            exit while
        '        end if            
        '    endif
        '    
        'end while
        
    return

end function

