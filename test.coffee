
$ ->
  UnitTest.run ->

    window.Q = uQuery
    #@assertEvalEqual 4, "Q('div').length"
    #@assertEvalEqual 0, "Q('dl').length"
    #@assertEvalEqual 3, "Q('.desert').length"
    #@assertEvalEqual 1, "Q('#pie').length"
    #@assertEvalEqual 3, "Q('div.desert').length"
    @assertEvalEqual 1, "Q('div.desert .desert').length"
    #@assertEvalEqual 1, "Q('div#pie').length"
    #@assertEvalEqual 0, "Q('#lettuce').length"
    #@assertEvalEqual 0, "Q('.vegetable').length"

    #Q('.vegetable').remove()
    #Q('#pie').remove()

    #@assertEvalEqual 1, "Q('.desert').length"
    #@assertEvalEqual 0, "Q('#pie').length"
    #@assertEvalEqual 1, "Q('div.desert').length"
    #@assertEvalEqual 0, "Q('div#pie').length"