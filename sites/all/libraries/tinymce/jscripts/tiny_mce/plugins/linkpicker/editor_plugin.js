

(function() {
  // Load plugin specific language pack
  tinymce.PluginManager.requireLangPack('linkpicker');

  tinymce.create('tinymce.plugins.LinkpickerPlugin', {
    /**
     * Initializes the plugin, this will be executed after the plugin has been created.
     * This call is done before the editor instance has finished it's initialization so use the onInit event
     * of the editor instance to intercept that event.
     *
     * @param {tinymce.Editor} ed Editor instance that the plugin is initialized in.
     * @param {string} url Absolute URL to where the plugin is located.
     */
     init : function(ed, url) {
        // Register the command so that it can be invoked by using tinyMCE.activeEditor.execCommand('mceExample');
        ed.addCommand('mceOpenLinkpicker', linkpicker_open);

    function linkpicker_open(field_name, url, type, win) {
      ed.windowManager.open({
      file : '/tinymce_linkpicker',
      width : 400 + parseInt(ed.getLang('example.delta_width', 0)),
      height : 550 + parseInt(ed.getLang('example.delta_height', 0)),
      inline : 1,
    }, {
      window : tinyMCE.selectedInstance,
      input : tinyMCE.selectedInstance.editorId,
      plugin_url : url, // Plugin absolute URL
      some_custom_arg : 'custom arg' // Custom argument
      });
    };

	// Register example button
	ed.addButton('linkpicker', {
	  title : 'linkpicker.desc',
	  cmd : 'mceOpenLinkpicker',
	  image : url + '/img/linkpicker.gif'
	});
	
	// Add a node change handler, selects the button in the UI when a image is selected
	ed.onNodeChange.add(function(ed, cm, n) {
	  cm.setActive('linkpicker', n.nodeName == 'IMG');
	});

},
	
  createControl : function(n, cm) {
      return null;
  },

  /**
   * Returns information about the plugin as a name/value array.
   * The current keys are longname, author, authorurl, infourl and version.
   *
   * @return {Object} Name/value array containing information about the plugin.
   */
    getInfo : function() {
      return {
        longname : 'Drupal Link Picker Plugin',
        author : 'Jonathan Yankovich',
        authorurl : 'http://bucketworks.org',
        infourl : 'http://bucketworks.org',
        version : "0.1"
      };
    }
  });

  // Register plugin
  tinymce.PluginManager.add('linkpicker', tinymce.plugins.LinkpickerPlugin);
})();
