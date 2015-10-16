// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require js-routes
//= require_tree .

$.fn.spectrum=function(arrayOfColors){
  return this.each(function(){
    var self=$(this);
    (function spectrum(){
      var hue=arrayOfColors.shift()
      arrayOfColors.push(hue)
      self.animate({ borderColor: hue }, 1000,spectrum)
    })();
  })
}

$(document).on('ready page:load', function(event) {
  if ($('.Typeahead').length) {
    $('.Typeahead').spectrum(["#8A2BE2", "#4E0096"])
  }

  if ($('.main-search').length) {
    template = Handlebars.compile($("#result-template").html());
    empty = Handlebars.compile($("#empty-template").html());

    $('.main-search').typeahead({
      hint: $('.Typeahead-hint'),
      menu: $('.Typeahead-menu'),
      highlight: true,
      hint: true,
      minLength: 0,
      classNames: {
        open: 'is-open',
        empty: 'is-empty',
        cursor: 'is-active',
        suggestion: 'Typeahead-suggestion',
        selectable: 'Typeahead-selectable'
      }
    }, {
      name: 'media-search',
      display: 'title',
      source: function(query, syncResults, asyncResults) {
        console.log(query);
        $.get('/search?query=' + encodeURIComponent(query), function(data) {
          asyncResults(data);
        });
      },
      templates: {
        suggestion: template,
        empty: empty
      }
    })
    .on('typeahead:asyncrequest', function() {
      $('.Typeahead-spinner').show();
    })
    .on('typeahead:asynccancel typeahead:asyncreceive', function() {
      $('.Typeahead-spinner').hide();
    })
    .on('typeahead:select', function(object, suggestion) { // Call when clicking on a suggestion
      window.location.href = "/movies/" + suggestion.slug;
    })
    .on('typeahead:autocomplete', function(object, suggestion) {
      window.location.href = "/movies/" + suggestion.slug;
    });
  }
});
