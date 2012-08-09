
class DomDecor
  constructor: (arg)->
    @els = if not arg or arg.length is 0 then [] else (if arg.length then arg else [arg])
    @el = @els[0]
    @length = @els.length

  each: (f)->
    for i, el of @els
      f.apply el, [el, i]

  remove: ->
    @each ->
      @parentNode.removeChild @
    @els = []
    @el = undefined
    @
  
  filter: (f)->
    U (el for el in @els when f.apply el)
  
  get: (n)->
    @els[n]

  eq: (n)->
    U @get n

  index: (o)->
    o = o.el or o
    @els.indexOf o
  
  add: (o)->
    console.log @els.length, o.els.length
    @els = @els.concat (o.els ? o)
    @el = @els[0]
    @length = @els.length


window.uQuery = uQuery = U = (a, n=document) ->
  if typeof a is 'string'
    m = a.match /^(\w+|)([#\.]\w+|)(.*)$/
    m[1] = m[1].toUpperCase()
    console.log m, 'in', n.className, n.id
    e = []
    if m[2]
      if m[2][0] is '#'
        e = [document.getElementById m[2][1..]]
      else if m[2][0] is '.'
        e = n.getElementsByClassName m[2][1..]
    if m[1]
      if m[2]
        if e
          e = (el for el in e when el.tagName is m[1])
      else
        e = n.getElementsByTagName m[1]
    if m[3]
      u = U []
      console.log e
      for el in e
        console.log 'getting children of', el.className, el.id
        console.log (U m[3][1..], el).length
        u.add U m[3][1..], el
      console.log u.length
      return u
  else
    e = a.els or a
  new DomDecor e

U.extend = (a...)->
  i = a.length
  while i
    for k,v of a[i]
      a[0][k] ?= a[i][k]
    i -= 1

