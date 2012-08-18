$ ->
  UnitTest.run ->

    window.Q = uQuery


    actual = () ->
        $('div').each (index) -> 
            index

    expected = () ->
        Q('div').each (index) -> 
            index

    @verify actual, expected, "Verify basic output : Q('div')"

     
#========================================================

    actual = () ->
        $('#mocha p')

    expected = () ->
        Q('#mocha p')

    @verify actual, expected, "Verify basic output : Q('#mocha p')"

#========================================================

    actual = () ->
        $("bacon").remove()

    expected = () ->
        Q("bacon").remove()

    @verify actual, expected, "Verify basic remove : bacon"

#========================================================

    actual = () ->
        $('div.hello').remove()
        $('div.hello').length

    $('div.goodbye').addClass('hello')

    expected = () ->
        Q('div.hello').remove()
        Q('div.hello').length

    @verify actual, expected, "Verify basic get remove : div.hello length"

#========================================================

    actual = () ->
        $('li').filter(':even')

    expected = () ->
        Q('li').filter(':even')

    @verify actual, expected, "Verify basic get : filter :even"

#========================================================

    actual = () ->
        $('li').filter (index) ->
        $("strong", this).length is 1

    expected = () ->
        Q('li').filter (index) ->
        Q("strong", this).length is 1

    @verify actual, expected, "Verify basic get : filter li index"

# #========================================================

    actual = () ->
        $('li').get(0)

    expected = () ->
        Q('li').get(0)

    @verify actual, expected, "Verify basic get : li(0)"

#========================================================

    actual = () ->
        $('li').get(1)

    expected = () ->
        Q('li').get(1)

    @verify actual, expected, "Verify basic get : li(1)"

#========================================================

    actual = () ->
        $('div').eq(1)

    expected = () ->
        Q('div').eq(1)

    @verify actual, expected, "Verify basic get : div"
