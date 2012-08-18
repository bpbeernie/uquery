$ ->
  UnitTest.run ->

    window.Q = uQuery

    actual = () ->
        Q('div').length

    expected = () ->
        $('div').length

    @verify actual, expected, "Verify basic output : $('div').length"
     
#========================================================

    actual = () ->
        Q('dl').length

    expected = () ->
        $('dl').length

    @verify actual, expected, "Verify basic output : $('dl').length"
     
#========================================================

    actual = () ->
        Q('.desert').length

    expected = () ->
        $('.desert').length

    @verify actual, expected, "Verify basic output : $('.desert').length"
     
#========================================================

    actual = () ->
        Q('#pie').length

    expected = () ->
        $('#pie').length

    @verify actual, expected, "Verify basic output : $('#pie').length"
     
#========================================================

    actual = () ->
        Q('div.desert').length

    expected = () ->
        $('div.desert').length

    @verify actual, expected, "Verify basic output : $('div.desert').length"
     
#========================================================

    actual = () ->
        Q('div.desert .desert').get(0).id

    expected = () ->
        $('div.desert .desert').get(0).id

    @verify actual, expected, "Verify basic output : $('div.desert .desert').get(0).id"
     
#========================================================

    actual = () ->
        Q('div#pie').get(0).className

    expected = () ->
        $('div#pie').get(0).className


    @verify actual, expected, "Verify basic output : $('div#pie').get(0).className"
     
#========there are not vegetables=========================

    actual = () ->
        Q('#lettuce').length

    expected = () ->
        $('#lettuce').length

    @verify actual, expected, "Verify basic output : $('#lettuce').length"

#========there are not vegetables=========================

    actual = () ->
        Q('.vegetable').length

    expected = () ->
        $('.vegetable').length

    @verify actual, expected, "Verify basic output : $('.vegetable').length"

#==remove the vegetables, even though there aren't any=====

    actual = () ->
        Q('.vegetable').remove()

    expected = () ->
        $('.vegetable').remove()

    @verify actual, expected, "Verify basic output : $('.vegetable').remove()"


#=========================================================

    actual = () ->
        Q('.desert').length

    expected = () ->
        $('.desert').length

    @verify actual, expected, "Verify basic output : $('.desert').length"


#=========================================================

    actual = () ->
        Q('#pie').length

    expected = () ->
        $('#pie').length

    @verify actual, expected, "Verify basic output : $('#pie').length"
    

#=========================================================

    actual = () ->
        Q('div.desert').length

    expected = () ->
        $('div.desert').length

    @verify actual, expected, "Verify basic output : $('div.desert').length"

#=========================================================

    actual = () ->
        Q('div#pie').length

    expected = () ->
        $('div#pie').length

    @verify actual, expected, "Verify basic output : $('div#pie').length"
    



