jQuery(function($) {
  $('#edit-syntaxhighlighter-use-autoloader').click(function() {
    if (this.checked) {
      $('input[name^="syntaxhighlighter_enabled_languages"]').each(function() { this.checked = true; });
    }
  });
});