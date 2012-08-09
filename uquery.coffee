
class DomDecor
  constructor: (arg)->
    @E = if not arg or arg.length is 0 then [] else (if arg.length then arg else [arg])
    @_recache()
    if @e and not @e.tagName then throw "e `"+@e+"`has not tagName."

  each: (f)->
    for i, e of @E
      f.apply e, [e, i]

  remove: ->
    @each ->
      @parentNode.removeChild @
    @E = []
    @_recache()
    @
  
  filter: (f)->
    U (e for e in @E when f.apply e)
  
  get: (n)->
    @E[n]

  eq: (n)->
    U @get n

  index: (o)->
    o = o.e or o
    for i,e of @E
      if e is o or matchSelector(e, o)
        return i
    -1
  
  _recache: ->
    @e = @E[0]
    @length = @E.length

  add: (o)->
    for item in (o.E ? o)
      @E.push item
    @_recache()
    @

  match: (selector)->
    matchSelector @e, selector

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

U.extend = (a...)->
  i = a.length
  while i
    for k,v of a[i]
      a[0][k] ?= a[i][k]
    i -= 1

U.querySelector = querySelector
