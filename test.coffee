
$ ->
  UnitTest.run ->

    window.Q = uQuery

    console.log "Begin test for real JQuery! -- each function"

    $('div').each (index) -> 
       console.log index

    console.log "Begin test for Clark's bullshit UQuery -- each function"
    
    Q('div').each (index) -> 
       console.log index
     

    console.log "Begin test for real JQuery! -- Output of JQuery"

    console.log $('#mocha p')

    console.log "Begin test for Clark's bullshit UQuery -- Output of UQuery"

    console.log Q('#mocha p')
