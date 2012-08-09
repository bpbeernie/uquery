
$ ->
  UnitTest.run ->

    window.Q = uQuery
    @assertEvalEqual 4, "Q('div').length"
    @assertEvalEqual 0, "Q('dl').length"
    @assertEvalEqual 3, "Q('.desert').length"
    @assertEvalEqual 1, "Q('#pie').length"
    @assertEvalEqual 3, "Q('div.desert').length"
    @assertEvalEqual 'icing', "Q('div.desert .desert').get(0).id"
    @assertEvalEqual 'desert', "Q('div#pie').get(0).className"

    # there are not vegetables
    @assertEvalEqual 0, "Q('#lettuce').length"
    @assertEvalEqual 0, "Q('.vegetable').length"
    
    # remove the vegetables, even though there aren't any.
    Q('.vegetable').remove()

    # remove the pie
    Q('#pie').remove()

    @assertEvalEqual 2, "Q('.desert').length"
    @assertEvalEqual 0, "Q('#pie').length"
    @assertEvalEqual 2, "Q('div.desert').length"
    @assertEvalEqual 0, "Q('div#pie').length"