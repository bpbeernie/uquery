class DomDecor

  # E is a global variable defining the elements in a JQuery result, it should be set to the argument passed in.
  # recache is a helper method defined below that initialized a few more global variables, e and length
  # We throw an error if e doesn't have a tagname.
  constructor: (arg)->
    this.E = if not arg or arg.length is 0 then [] else (if arg.length then arg else [arg])
    this._recache()
    if this.e and not this.e.tagName then throw "e `"+this.e+"`has not tagName."

  #For each element in this query, execute function f
  each: (f)->
    for i, e of this.E
      f.apply e, [e, i]

  # For each element in this query, remote it from this query
  # Empty the element list (E) and caches.
  # return
  remove: ()->
    this.each ()->
      this.parentNode.removeChild this
    this.E = []
    this._recache()
    this
  
  # For each element in E, if satisfies condition provided by function 'f', return a
  # new JQuery Result consisting of all such elements e
  filter: (f)->
    U (e for e in this.E when f.apply e)
  
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
    for i,e of @E
      if e is o or matchSelector(e, o)
        return i
    -1
  
  # Set member variables e and length to first element of E and the
  # length of E respectively
  _recache: ->
    this.e = this.E[0]
    this.length = this.E.length

  # We are given an object o that we assume to be an array of DOM elements
  # or a single JQuery object. 
  # We add it to E then call recache to readjust member variables e and length.
  add: (o)->
    for item in (o.E ? o)
      this.E.push item
    this._recache()
    this

  match: (selector)->
    matchSelector this.e, selector


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
