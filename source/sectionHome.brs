Function home_section(s) as void


this={
     app:s.app
     canvas:s.app.canvas
     remoteCallback:home_remote_callback
     timer:CreateObject("roTimespan")
     last_time_menu:0
     expire_menu:3000
     tindex:0
     restartLastTime:home_restart_last_time
     randomize:home_randomize
     randomize2:home_randomize2
     renderThumbs:home_render_thumbs
     clearLoading:home_clear_loading
     temp_thumbs:[]
     thumb_copy:[]
     }


'Getting the news
'Grab in the app the json to avoid loading again 
    if(type(this.app.json)<>"Invalid")
        if this.app.trial
            json=s.http.getWs("getNews.php?trial=0")
        else
            json=s.http.getWs("getNews.php?trial=1")
        endif
        this.app.json = json
        
        ws_thumbs=this.app.thumbs
    else
        'print "is trial?"
        'print this.app.trial
        if this.app.trial
            json=s.http.getWs("getNews.php?trial=0")
        else
            json=s.http.getWs("getNews.php?trial=1")
        endif
        this.app.json=json
          ws_thumbs=json.thumbs
          aux_thumbs=[]
          count_thumbs=ws_thumbs.count()-1
          
          'if(count_thumbs>32)count_thumbs=32
          for i=0 to count_thumbs
              DownloadFile(ws_thumbs[i],"th_"+Stri(i).trim()+".jpg")
              aux_thumbs.push("tmp:/th_"+Stri(i).trim()+".jpg")
          endfor
          
          ws_thumbs=aux_thumbs
          this.app.thumbs=ws_thumbs
        
    endif



 items=[]
if(type(json)<>"roInvalid")

cols=4
rows=4
if (IsHD())
    size={margin_bottom:10,margin_right:10}
else    
    size={margin_bottom:6,margin_right:5}
endif

total=(rows*cols)-1 '15

sb_w=s.app.sidebar_width

if (IsHD())
    free_width=s.app.size.w-sb_w-135
    free_height=s.app.size.h-250
else
    free_width=s.app.size.w-sb_w-75
    free_height=s.app.size.h-165
endif

item_width=Fix(free_width/cols)
item_height=Fix(free_height/rows)

if (IsHD())
    start_x=sb_w+size.margin_right+50
else
    start_x=sb_w+size.margin_right+25
endif
x_=start_x
if (IsHD())
    start_y=s.app.edge_top+size.margin_bottom-10
    items.push({
            color:"#242424"
            targetRect:{w:free_width+200,h:free_height+90,x:start_x-40,y:start_y-40}
           })           


else
    start_y=s.app.edge_top+size.margin_bottom-8
    items.push({
            color:"#242424"
            targetRect:{w:free_width+113,h:free_height+60,x:start_x-10,y:start_y-25}
           })           
endif

y_=start_y
positions=[]
existents=[]

layers=[]
start_layer=58
urls=[]
thumbs=[]

for i=0 to total

    target_rect={w:item_width,h:item_height,x:x_,y:y_}
    positions[i]=target_rect
    thumbs.push({url:ws_thumbs[i],targetRect:target_rect})
    layers.push({tr:target_rect,layer:(start_layer)}) 'i+
    existents.push(ws_thumbs[i])
    
    x_=x_+item_width+size.margin_right
    if(((i+1) mod cols)=0)
        x_=start_x
        y_=y_+item_height+size.margin_bottom
    end if
                    
end for



'this.tindex = total+1
this.layers=layers

if (IsHD())
    items.push({text:json.title,
                textAttrs:{HAlign:"left",font:this.app.h1,color:"#cccccc"},
               targetRect:{x:start_x,y:this.app.size.h-(s.app.edge_top+120),w:840,h:50}})
    
    items.push({text:json.content,
                textAttrs:{HAlign:"left",font:this.app.h4},
               targetRect:{x:start_x,y:this.app.size.h-(s.app.edge_top+80),w:540,h:50}})
else
    items.push({text:json.title,
                textAttrs:{HAlign:"left",font:this.app.h1,color:"#cccccc"},
               targetRect:{x:start_x,y:this.app.size.h-(s.app.edge_top+73),w:473,h:33}})
    
    items.push({text:json.content,
                textAttrs:{HAlign:"left",font:this.app.h4},
               targetRect:{x:start_x,y:this.app.size.h-(s.app.edge_top+53),w:304,h:33}})
endif

thumbs_width=Fix(item_width/1.5)
thumbs_height=Fix(item_height/1.5)

if (IsHD())
    thumbs_y=this.app.size.h-(this.app.edge_top+thumbs_height+20)
    items.push({url:json.thumb2,
               targetRect:{x:this.app.size.w-(this.app.edge_left+thumbs_width-15),y:thumbs_y,w:thumbs_width,h:thumbs_height}})
    
    items.push({url:json.thumb1,
               targetRect:{x:this.app.size.w-(this.app.edge_left+(thumbs_width*2)-5),y:thumbs_y,w:thumbs_width,h:thumbs_height}})
else
    thumbs_y=this.app.size.h-(this.app.edge_top+thumbs_height+13)
    items.push({url:json.thumb2,
           targetRect:{x:this.app.size.w-(this.app.edge_left+thumbs_width-8),y:thumbs_y,w:thumbs_width,h:thumbs_height}})
    items.push({url:json.thumb1,
           targetRect:{x:this.app.size.w-(this.app.edge_left+(thumbs_width*2)-3),y:thumbs_y,w:thumbs_width,h:thumbs_height}})
endif


'line_div={url:"pkg:/images/line.png", targetRect:{x:s.app.size.center_x-365, y:540, w:860, h:3}}
'items.Push(line_div)


this.ws_thumbs=ws_thumbs
this.thumbs=thumbs
this.positions=positions
this.cols=cols
this.rows=rows
this.existents=existents
s.app.chronListener=this

s.canvas.setLayer(49,items)
this.renderThumbs(52,thumbs)
this.app.hidePreloader()

end if
end Function

function home_clear_loading() as void
   m.canvas.clearLayer(51)
end function



function home_render_thumbs(layer,items) as void

    m.clearLoading()
    preloader=[]
        
    'Strange, assign p=item.targetRect takes the later properties form left side
    'Mandatory create a new object for loading thumbnail and copies the
    'Target Rect from item
    for each item in items
        target=item.targetRect
        p={url:"pkg:/images/loading.png",targetRect:{w:target.w,h:target.h,x:target.x,y:target.y}}
        preloader.push(p)
    end for


'm.canvas.setLayer(layer-1,preloader)

'layers=m.layers
'j=0
'for each item in items
'    trct=layers[j].tr
'    layer=layers[j].layer
'    rnditem={url:item.url,targetRect:trct}
'    m.canvas.setLayer(layer,rnditem)
'    j=j+1
'end for
m.canvas.setLayer(layer,items)

end function



function home_remote_callback(index) as void

                if m.timer.TotalMilliseconds() > m.last_time_menu then
                    m.randomize2()
                    m.restartLastTime()
                end if
end function

function home_randomize2() as void

thumb_array = [] ' starts the array empty
random_position = rnd(15) - 1 ' random position 0 to 15

existents = m.existents ' the actual thumbnails in the grid
ws_thumbs = m.ws_thumbs ' all the thumbnails to be used , around 25
ws_total = ws_thumbs.count() - 1 ' total number of elements in the thumbnails array , around 25
grid_total = 15 ' total number of elements in the grid, 16 possible possitions from 0 to 15
positions = m.positions ' all the positions in the grid

random_thumb = rnd(ws_total) - 1 ' random number for thumbnails from all thumbnails that can be used 0 to 25

thumb_array.push({url:ws_thumbs[random_thumb],targetRect:m.positions[random_position]}) ' array to send to randomize

temp_i = 0
bandera = false

for i=0 to existents.count()-1
    if (existents[i]<>thumb_array[0].url)
        
        temp_i = i
    else
        bandera = true
    endif
endfor



if (bandera=false)
    new_render = []
    existents[temp_i] = thumb_array[0].url
    for i=0 to 15
        new_render.push({url:existents[i],targetRect:positions[i]})
    end for
    new_render[temp_i].targetRect = thumb_array[0].targetRect
    layer = 58
    m.app.canvas.setLayer(layer, new_render)
endif 

end function

function home_randomize() as void


existents=m.existents
ws_thumbs=m.ws_thumbs
positions=m.positions

ws_total=ws_thumbs.count()
ws_count=ws_total-1
grid_total=(m.cols*m.rows)
grid_count=grid_total-1


if(ws_total>grid_total)
        exists=true
        while(exists=true)
                exists=false
                rand=rnd(ws_count)
                r_url=ws_thumbs[rand]
                posrand=rnd(grid_count)
                    for i=0 to grid_count
                           if(existents[i]=r_url)
                             exists=true
                             m.restartLastTime()
                             exit for
                           endif
                    end for
        end while
        
        
        existents.pop()
        
        existents.push(r_url)
        
        
        thumbs=m.thumbs
        rand_th={url:r_url,targetRect:positions[posrand]}
        m.existents=existents
        
        m.thumbs=thumbs
        
        layers=m.layers
        rndv=rnd(15)
        rndtrgt=layers[rndv].tr
        layer=layers[rndv].layer

        rand_th.targetRect=rndtrgt
        m.app.canvas.setLayer(layer,rand_th)
else



end if


end function




function home_restart_last_time()

m.last_time_menu=m.timer.TotalMilliseconds()+m.expire_menu

end function




