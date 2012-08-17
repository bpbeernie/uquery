(function() {
  var DomDecor, U, matchSelector, parseSelector, querySelector, uQuery;
  var __slice = Array.prototype.slice;

  DomDecor = (function() {

    function DomDecor(arg) {
      this.E = !arg || arg.length === 0 ? [] : (arg.length ? arg : [arg]);
      this._recache();
      if (this.e && !this.e.tagName) throw "e `" + this.e + "`has not tagName.";
    }

    DomDecor.prototype.each = function(f) {
      var e, i, _ref, _results;
      _ref = this.E;
      _results = [];
      for (i in _ref) {
        e = _ref[i];
        _results.push(f.apply(e, [i, e]));
      }
      return _results;
    };

    DomDecor.prototype.remove = function() {
      this.each(function() {
        return this.parentNode.removeChild(this);
      });
      this.E = [];
      this._recache();
      return this;
    };

    DomDecor.prototype.filter = function(f) {
      var e;
      return U((function() {
        var _i, _len, _ref, _results;
        _ref = this.E;
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
      var e, i, _ref;
      o = o.e || o;
      _ref = this.E;
      for (i in _ref) {
        e = _ref[i];
        if (e === o || matchSelector(e, o)) return i;
      }
      return -1;
    };

    DomDecor.prototype._recache = function() {
      this.e = this.E[0];
      return this.length = this.E.length;
    };

    DomDecor.prototype.add = function(o) {
      var item, _i, _len, _ref, _ref2;
      _ref2 = (_ref = o.E) != null ? _ref : o;
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        item = _ref2[_i];
        this.E.push(item);
      }
      this._recache();
      return this;
    };

    DomDecor.prototype.match = function(selector) {
      return matchSelector(this.e, selector);
    };

    DomDecor.prototype.toString = function() {
      return this.E;
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
