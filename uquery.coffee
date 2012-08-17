class DomDecor

  # E is a member variable defining the elements in a JQuery result, it should be set to the argument passed in.
  # We throw an error if e doesn't have a tagname.
  constructor: (arg)->
    if arg
      if not arg.length
        arg = [arg]
    else
      arg = []
    for i,a of arg
      @[i] = a
    @length = arg.length
    if this.e and not this.e.tagName then throw "e `"+this.e+"`has not tagName."

  #F or each element in this query, execute function f
  each: (f)->
    i = 0
    while @[i]
      f.apply @[i], [i, @[i]]
      i += 1

  # For each element in this query, remote it from this query
  # Empty the element list (E) and caches.
  # return
  remove: ()->
    this.each ()->
      this.parentNode.removeChild this
    this
  
  # For each element in E, if satisfies condition provided by function 'f', return a
  # new JQuery Result consisting of all such elements e
  filter: (f)->
    U (e for e in this.toArray() when f.apply e)
  
  # Return element of E at index n
  get: (n)->
    this.E[n]

  # Return new JQuery result consisting of element of E at index n
  eq: (n)->
    U this.get n

  # We are given an object o that we assume to be an array of JQuery Results
  # or a single JQuery result. 
  # If we are given an array, we look for a match for the first element of that array 
  # to the element of E and return the index of the element of e for which it matches.
  index: (o)->
    o = o.e or o
    i = 0
    while @[i]
      if @[i] is o or matchSelector(e, o)
        return i
      i += 1
    -1
  
  splice: ->

  # We are given an object o that we assume to be an array of DOM elements
  # or a single JQuery object. 
  add: (o)->
    for item in (o.E ? o)
      this.E.push item
    this
  
  #
  match: (selector)->
    matchSelector this.e, selector

  toArray: ->
    arr = []
    i = 0
    while @[i]
      arr.push @[i]
      i+=1
    arr

matchSelector = (e, selector)->
  m = parseSelector selector
  if m[2] is '#' and e.id isnt m[3]
    false
  if m[2] is '.' and (' '+e.className+' ').indexOf(' '+m[3]+' ') is -1
    false
  if m[1] and m[1] isnt e.tagName
    false
  else
    true

parseSelector = (selector)->
  m = selector.match /^(\w+|)([#\.]|)([^#\.\s]+|)(\s.+|)$/
  throw 'Invalid selector ' + selector unless m and (m[1] or (m[2] and m[3])) # !TEST!
  m[1] = m[1].toUpperCase()
  m

querySelector = (selector, context=document)->
  m = parseSelector selector

  # The ID selector
  if m[2] is '#'
    elements = document.getElementById m[3]
    elements = if elements then [elements] else []
  # The class selector
  else if m[2] is '.'
    elements = context.getElementsByClassName m[3]
    elements = (e for e in elements when e.tagName is m[1]) if m[1]
  # The tag selector
  else if m[1]
    elements = context.getElementsByTagName m[1]
  else
    elements = []
  
  # Deal with spaces (descendents) in the selector
  if m[4]
    outputs = []
    for e in elements
      for child in querySelector m[4][1..], e
        outputs.push child
    outputs
  else
    elements

window.uQuery = uQuery = U = (selector, context=document) ->
  if typeof selector is 'string'
    e = querySelector selector, context
  else
    e = selector.E or selector
  new DomDecor e

# merge two or more objects, with preference to attributes in earlier arguments.
U.extend = (a...)->
  i = a.length
  while i
    for k,v of a[i]
      a[0][k] ?= a[i][k]
    i -= 1

U.querySelector = querySelector
