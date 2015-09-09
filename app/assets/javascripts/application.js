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



$(document).ready(function(){
  console.log(Routes.search_path({query: '%QUERY'}))
  $('.main-search').spectrum(["#8A2BE2", "#4E0096"])

  var mediaSearch = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: Routes.search_path(),
      replace: function(url, query) {
        return url + "?query=" + query;
      }
    }
  });

  $('.main-search').typeahead({
    hint: true,
    highlight: true,
    minLength: 1
  }, {
    name: 'media-search',
    display: 'title',
    source: mediaSearch,
    templates: {
      empty: [
        '<div class="empty-message">',
        '<p>unable to find any items that match your query</p>',
        '</div>'
      ].join('\n')
    }
  });

});
