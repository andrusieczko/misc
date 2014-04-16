window.templatesEngine = {
  _getValueFromPath: function(obj, path) {
    var pathLevels = path.split('.');
    var index;
    var currentObj = obj;
    for (index in pathLevels) {
      var level = pathLevels[index];
      if (!currentObj[level]) {
        throw new Error(level + " doesn't exist in " + JSON.stringify(currentObj));
      }
      currentObj = currentObj[level];
    }
    return currentObj;
  },

  compile: function(element, data) {
    Array.prototype.forEach.call(element.querySelectorAll('[tpl]'), function(el) {
      var templateId = el.getAttribute('tpl');
      var dataSource = el.getAttribute('source');
      var templateSource = document.querySelector('#' + templateId).innerHTML;
      var template = Handlebars.compile(templateSource);
      el.innerHTML = template({data: dataSource ? this._getValueFromPath(data, dataSource) : data} );
      this.compile(el, data);
    }.bind(this));
  },
  compileOnRun: function(data) {
    document.addEventListener('DOMContentLoaded', function() {
      this.compile(document, data);
    }.bind(this), false);
  }
};