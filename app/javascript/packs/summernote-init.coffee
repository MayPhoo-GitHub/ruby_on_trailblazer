$ ->
  ready= ->
    $('[data-provider="summernote"]').each ->
      $(this).summernote
        height: 300
$(document).ready(ready)
$(document).on('page:load',ready)