'**********************************************************
'**  Video Player Example Application - URL Utilities 
'**  November 2009
'**  Copyright (c) 2009 Roku Inc. All Rights Reserved.
'**********************************************************

REM ******************************************************
REM Constucts a URL Transfer object
REM ******************************************************




Function CreateURLTransferObject() as Object
    obj = CreateObject("roUrlTransfer")
    obj.SetPort(CreateObject("roMessagePort"))
  '  obj.AddHeader("Content-Type", "application/x-www-form-urlencoded")
    'obj.AddHeader("X-Roku-Reserved-Dev-Id", "")
    'obj.InitClientCertificates()
    obj.EnableEncodings(true)
    return obj
End Function

function set_header(txtheader)
m.Http.addHeader("Content-Type",txtheader)
end function


function set_url(url)
m.Http.setUrl(url)
end function

REM ******************************************************
REM Url Query builder
REM so this is a quick and dirty name/value encoder/accumulator
REM ******************************************************

Function NewHttp(app) as Object



    obj = CreateObject("roAssociativeArray")
    obj.Http                        = CreateURLTransferObject()
    obj.base_url                    = app.base_url
    obj.base_ws                     = app.base_ws
    obj.base_pp_ws                  = app.base_pp_ws
    obj.FirstParam                  = true
    obj.AddParam                    = http_add_param
    obj.AddRawQuery                 = http_add_raw_query
    obj.GetToStringWithRetry        = http_get_to_string_with_retry
    obj.PrepareUrlForQuery          = http_prepare_url_for_query
    obj.GetToStringWithTimeout      = http_get_to_string_with_timeout
    obj.PostFromStringWithTimeout   = http_post_from_string_with_timeout
    obj.GetToFileWithTimeout        = http_get_to_file_with_timeout
    obj.GetWs                       = get_ws
    obj.getPPWs                     = get_pp_ws
    obj.getJSON                     = http_get_json
    obj.setHeader                   = set_header
    obj.setUrl                      = set_url
    'obj.callalert                   = app.callalert()
    obj.dialogs                     = CreateDialog(app)

  ' if Instr(1, url, "?") > 0 then obj.FirstParam = false

    return obj
End Function


Function get_ws(scrpt) as object

base=m.base_ws
theurl=base+scrpt
json=m.getJSON(theurl)
'if type(json)="roInvalid"
'    m.app.dialog.alert2("Your connection to the server was lost. Try checking your network settings or contact our support team at hello@ahhveo.com, Thank you.")
'    return false
'else
return json
'endif
end function

function get_pp_ws(scrpt) as object

base=m.base_pp_ws
theurl=base+scrpt
json=m.getJSON(theurl)
return json

end function


function http_get_json(turl) as object
        json=m.Http
        json.setUrl(turl)
        
        
        port=CreateObject("roMessagePort")
        json.setMessagePort(port)
         
               
        if(json.AsyncGetToString())
        while true
            msg = wait(0, port)
            if (type(msg) = "roUrlEvent")
                code = msg.GetResponseCode()
                if (code = 200)
                    json = ParseJSON(msg.GetString())
                    return json           
                   ' exit while
                else
                    m.dialogs.alert2("Your connection to our server was lost. Try restarting your Roku and checking your network settings, or contact to support hello@ahhveo.com")
                    
                endif
            else if (event = invalid)
                request.AsyncCancel()
            endif
    
        
        end while
        
        end if 

end function



REM ******************************************************
REM Constucts a URL Transfer object 2
REM ******************************************************

Function CreateURLTransferObject2(url As String, contentHeader As String) as Object
    obj = CreateObject("roUrlTransfer")
    obj.SetPort(CreateObject("roMessagePort"))
    obj.SetUrl(url)
        obj.AddHeader("Content-Type", contentHeader)
    obj.EnableEncodings(true)
    return obj
End Function

REM ******************************************************
REM Url Query builder 2
REM so this is a quick and dirty name/value encoder/accumulator
REM ******************************************************

Function NewHttp2(url As String, contentHeader As String) as Object

    obj = CreateObject("roAssociativeArray")
    obj.Http                        = CreateURLTransferObject2(url, contentHeader)
    obj.FirstParam                  = true
    obj.AddParam                    = http_add_param
    obj.AddRawQuery                 = http_add_raw_query
    obj.GetToStringWithRetry        = http_get_to_string_with_retry
    obj.PrepareUrlForQuery          = http_prepare_url_for_query
    obj.GetToStringWithTimeout      = http_get_to_string_with_timeout
    obj.PostFromStringWithTimeout   = http_post_from_string_with_timeout
    obj.GetToFileWithTimeout        = http_get_to_file_with_timeout
    obj.GetJSON                     = http_get_json

    if Instr(1, url, "?") > 0 then obj.FirstParam = false

    return obj
End Function


REM ******************************************************
REM HttpEncode - just encode a string
REM ******************************************************

Function HttpEncode(str As String) As String
    o = CreateObject("roUrlTransfer")
    return o.Escape(str)
End Function

REM ******************************************************
REM Prepare the current url for adding query parameters
REM Automatically add a '?' or '&' as necessary
REM ******************************************************

Function http_prepare_url_for_query() As String
    url = m.Http.GetUrl()
    if m.FirstParam then
        url = url + "?"
        m.FirstParam = false
    else
        url = url + "&"
    endif
    m.Http.SetUrl(url)
    return url
End Function

REM ******************************************************
REM Percent encode a name/value parameter pair and add the
REM the query portion of the current url
REM Automatically add a '?' or '&' as necessary
REM Prevent duplicate parameters
REM ******************************************************

Function http_add_param(name As String, val As String) as Void
    q = m.Http.Escape(name)
    q = q + "="
    url = m.Http.GetUrl()
    if Instr(1, url, q) > 0 return    'Parameter already present
    q = q + m.Http.Escape(val)
    m.AddRawQuery(q)
End Function

REM ******************************************************
REM Tack a raw query string onto the end of the current url
REM Automatically add a '?' or '&' as necessary
REM ******************************************************

Function http_add_raw_query(query As String) as Void
    url = m.PrepareUrlForQuery()
    url = url + query
    m.Http.SetUrl(url)
End Function

REM ******************************************************
REM Performs Http.AsyncGetToString() in a retry loop
REM with exponential backoff. To the outside
REM world this appears as a synchronous API.
REM ******************************************************

Function http_get_to_string_with_retry() as Object
    timeout%         = 1500
    num_retries%     = 5

    resHeaders = CreateObject("roAssociativeArray")
    resArray = CreateObject("roArray", 5, false)
    while num_retries% > 0
        if (m.Http.AsyncGetToString())
            event = wait(timeout%, m.Http.GetPort())
            if type(event) = "roUrlEvent"
                ''print "***";event.GetInt();"***";event.GetResponseCode();"***";event.GetFailureReason();"***";event.GetSourceIdentity()
                resArray.push(event.GetString())
                resArray.push(event.GetResponseHeadersArray())
                exit while        
            else if event = invalid
                m.Http.AsyncCancel()
                REM reset the connection on timeouts
                m.Http = CreateURLTransferObject(m.Http.GetUrl())
                timeout% = 2 * timeout%
            else
               ' 'print "roUrlTransfer::AsyncGetToString(): unknown event"
'               m.dialogs.alert2("Your connection to the our server was lost. Try restarting your Roku and checking your network settings, or contact support at hello@ahhveo.com")
            endif
        endif

        num_retries% = num_retries% - 1
    end while
    
    return resArray
End Function

REM ******************************************************
REM Performs Http.AsyncGetToString() with a single timeout in seconds
REM To the outside world this appears as a synchronous API.
REM ******************************************************

Function http_get_to_file_with_timeout(filename as String, seconds as Integer) as Boolean
    timeout% = 1000 * seconds

   ' 'print "http_get_to_file_with_timeout"
    
    str = ""
    m.Http.EnableFreshConnection(true) 'Don't reuse existing connections
    if (m.Http.AsyncGetToFile(filename))
        event = wait(timeout%, m.Http.GetPort())
        if type(event) = "roUrlEvent"
           ' 'print "***";event.GetInt();"***";event.GetResponseCode();"***";event.GetFailureReason();"***";event.GetSourceIdentity()
        else if event = invalid
           ' 'print "AsyncGetToFile timeout"
            m.Http.AsyncCancel()
        else
           ' 'print "AsyncGetToFile unknown event: "; event
        endif
    endif

    return true
End Function


REM ******************************************************
REM Performs Http.AsyncGetToString() with a single timeout in seconds
REM To the outside world this appears as a synchronous API.
REM ******************************************************

Function http_get_to_string_with_timeout(seconds as Integer) as String
    timeout% = 1000 * seconds

    str = ""
    m.Http.EnableFreshConnection(true) 'Don't reuse existing connections
    if (m.Http.AsyncGetToString())
        event = wait(timeout%, m.Http.GetPort())
        if type(event) = "roUrlEvent"
            str = event.GetString()
        else if event = invalid
            Dbg("AsyncGetToString timeout")
            m.Http.AsyncCancel()
        else
            Dbg("AsyncGetToString unknown event", event)
        endif
    endif

    return str
End Function


REM ******************************************************
REM Performs Http.AsyncPostFromString() with a single timeout in seconds
REM To the outside world this appears as a synchronous API.
REM ******************************************************

Function http_post_from_string_with_timeout(val As String, seconds as Integer) as Object
    timeout% = 1000 * seconds

    resArray = CreateObject("roArray", 5, false)
'    m.Http.EnableFreshConnection(true) 'Don't reuse existing connections
    if (m.Http.AsyncPostFromString(val))
        event = wait(timeout%, m.Http.GetPort())
        if type(event) = "roUrlEvent"
                        ''print "***";event.GetInt();"***";event.GetResponseCode();"***";event.GetFailureReason();"***";event.GetSourceIdentity()
                        resArray.push(event.GetString())
                        resArray.push(event.GetResponseHeadersArray())
        else if event = invalid
            Dbg("AsyncPostFromString timeout")
            m.Http.AsyncCancel()
        else
            Dbg("AsyncPostFromString unknown event", event)
        endif
    endif

    return resArray
End Function



Function GetRelaxNowMenuOptions_() as object
        
        json=CreateObject("roUrlTransfer")
        json.setUrl("http://ahhveo.com/_dev/test/roku/getRandomVideos.php")
        port=CreateObject("roMessagePort")
        json.setMessagePort(port)
               
        if(json.AsyncGetToString())
        while true
            msg = wait(0, port)
            if (type(msg) = "roUrlEvent")
                code = msg.GetResponseCode()
                
                if (code = 200)
                
                    
                    options = CreateObject("roArray", 10, true)
                    
                    json = ParseJSON(msg.GetString())
                    for each kind in json
                        
                        thetitle=CreateObject("roString")
                        thetitle.setString(kind.title)
                        theurl=CreateObject("roString")
                        regex=CreateObject("roRegex","\|+COMPONENT=HLS","i")
                        theurl.setString("http://wpc.b624.edgecastcdn.net/00B624/"+kind.url+"/"+regex.replaceAll(kind.filename,""))
                        thedesc=CreateObject("roString")
                        thedesc.setString(kind.description)
                        option = {
                            ID: kind.id
                            Title: thetitle
                            Description:thedesc
                            HDPosterUrl:"http://ahhveo.com/_dev/"+kind.thumbnail
                            SDPosterUrl:"http://ahhveo.com/_dev/"+kind.thumbnail
                            Url:theurl
                        }
                        options.push(option)
                    end for
                    return options
                    exit while
                endif
            else if (event = invalid)
                request.AsyncCancel()
            endif
    
        
        end while
        end if 
        
End Function



function getNews() as object


end function



