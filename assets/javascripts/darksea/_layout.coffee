ready = ->

  fix_main_content_height = ->
    sidenavHeight      = $('.navbar-side').height()
    mainContentHeight  = $('#mainContentContainer').height()
    navbarHeightAdjust = 0
    footerHeightAdjust = 0
    mainContentPadding = 15

    if $('.navbar-default').length
      navbarHeightAdjust = $('.navbar-default').outerHeight(true)

    if $('.site-footer').length
      footerHeightAdjust = $('.site-footer').outerHeight(true)

    if sidenavHeight > mainContentHeight
      $('#mainContent').css("min-height": (sidenavHeight - navbarHeightAdjust - footerHeightAdjust - mainContentPadding) + "px")

    if sidenavHeight < $(window).height() && $('body').height() < $(window).height()
      $('#mainContent').css("min-height": ($(window).height() - navbarHeightAdjust - footerHeightAdjust - mainContentPadding) + "px")

  fix_main_content_height()

  $(window).resize ->
    # Adjust the main content height
    fix_main_content_height()

$(document).ready(ready)
$(document).on('page:load', ready)
