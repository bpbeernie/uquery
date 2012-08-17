(function() {
  var DomDecor, U, matchSelector, parseSelector, querySelector, uQuery;
  var __slice = Array.prototype.slice;

  DomDecor = (function() {

    function DomDecor(arg) {
      var a, i;
      if (arg) {
        if (!arg.length) arg = [arg];
      } else {
        arg = [];
      }
      for (i in arg) {
        a = arg[i];
        this[i] = a;
      }
      this.length = arg.length;
      if (this.e && !this.e.tagName) throw "e `" + this.e + "`has not tagName.";
    }

    DomDecor.prototype.each = function(f) {
      var i, _results;
      i = 0;
      _results = [];
      while (this[i]) {
        f.apply(this[i], [i, this[i]]);
        _results.push(i += 1);
      }
      return _results;
    };

    DomDecor.prototype.remove = function() {
      this.each(function() {
        return this.parentNode.removeChild(this);
      });
      return this;
    };

    DomDecor.prototype.filter = function(f) {
      var e;
      return U((function() {
        var _i, _len, _ref, _results;
        _ref = this.toArray();
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          e = _ref[_i];
          if (f.apply(e)) _results.push(e);
        }
        return _results;
      }).call(this));
    };

    DomDecor.prototype.get = function(n) {
      return this.E[n];
    };

    DomDecor.prototype.eq = function(n) {
      return U(this.get(n));
    };

    DomDecor.prototype.index = function(o) {
      var i;
      o = o.e || o;
      i = 0;
      while (this[i]) {
        if (this[i] === o || matchSelector(e, o)) return i;
        i += 1;
      }
      return -1;
    };

    DomDecor.prototype.splice = function() {};

    DomDecor.prototype.add = function(o) {
      var item, _i, _len, _ref, _ref2;
      _ref2 = (_ref = o.E) != null ? _ref : o;
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        item = _ref2[_i];
        this.E.push(item);
      }
      return this;
    };

    DomDecor.prototype.match = function(selector) {
      return matchSelector(this.e, selector);
    };

    DomDecor.prototype.toArray = function() {
      var arr, i;
      arr = [];
      i = 0;
      while (this[i]) {
        arr.push(this[i]);
        i += 1;
      }
      return arr;
    };

    return DomDecor;

  })();

  matchSelector = function(e, selector) {
    var m;
    m = parseSelector(selector);
    if (m[2] === '#' && e.id !== m[3]) false;
    if (m[2] === '.' && (' ' + e.className + ' ').indexOf(' ' + m[3] + ' ') === -1) {
      false;
    }
    if (m[1] && m[1] !== e.tagName) {
      return false;
    } else {
      return true;
    }
  };

  parseSelector = function(selector) {
    var m;
    m = selector.match(/^(\w+|)([#\.]|)([^#\.\s]+|)(\s.+|)$/);
    if (!(m && (m[1] || (m[2] && m[3])))) throw 'Invalid selector ' + selector;
    m[1] = m[1].toUpperCase();
    return m;
  };

  querySelector = function(selector, context) {
    var child, e, elements, m, outputs, _i, _j, _len, _len2, _ref;
    if (context == null) context = document;
    m = parseSelector(selector);
    if (m[2] === '#') {
      elements = document.getElementById(m[3]);
      elements = elements ? [elements] : [];
    } else if (m[2] === '.') {
      elements = context.getElementsByClassName(m[3]);
      if (m[1]) {
        elements = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = elements.length; _i < _len; _i++) {
            e = elements[_i];
            if (e.tagName === m[1]) _results.push(e);
          }
          return _results;
        })();
      }
    } else if (m[1]) {
      elements = context.getElementsByTagName(m[1]);
    } else {
      elements = [];
    }
    if (m[4]) {
      outputs = [];
      for (_i = 0, _len = elements.length; _i < _len; _i++) {
        e = elements[_i];
        _ref = querySelector(m[4].slice(1), e);
        for (_j = 0, _len2 = _ref.length; _j < _len2; _j++) {
          child = _ref[_j];
          outputs.push(child);
        }
      }
      return outputs;
    } else {
      return elements;
    }
  };

  window.uQuery = uQuery = U = function(selector, context) {
    var e;
    if (context == null) context = document;
    if (typeof selector === 'string') {
      e = querySelector(selector, context);
    } else {
      e = selector.E || selector;
    }
    return new DomDecor(e);
  };

  U.extend = function() {
    var a, i, k, v, _base, _ref, _ref2, _results;
    a = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    i = a.length;
    _results = [];
    while (i) {
      _ref = a[i];
      for (k in _ref) {
        v = _ref[k];
        if ((_ref2 = (_base = a[0])[k]) == null) _base[k] = a[i][k];
      }
      _results.push(i -= 1);
    }
    return _results;
  };

  U.querySelector = querySelector;

}).call(this);
