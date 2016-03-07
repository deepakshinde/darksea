# Create Layout namespace
window.Layout = {}

# If the element is present, return it's height and margin
Layout.elementHeight = (element) ->
  if Utils.elementExists(element)
    $(element).outerHeight(true)
  else
    0

# Set the spacer height as defined by Bootstrap. Note: this isn't bulletproof.
# A user can alter the $spacer variable in sass away from 1rem. If they do that
# the html font-size is no longer the baseline.
Layout.spacerHeight = parseInt( $('html').css('font-size'), 10 )

# Our breakpoints from an unaltered Bootstrap install.
Layout.breakpoints =
  'xs' : 0
  'sm' : 544
  'md' : 768
  'lg' : 992
  'xl' : 1200

# Returns true if the current window size is less than the passed breakpoint
Layout.mediaBreakpointDown = (breakpoint) ->
  true if $(window).width() < Layout.breakpoints[breakpoint]

# Returns true if the current window size is greater than the passed breakpoint
Layout.mediaBreakpointup = (breakpoint) ->
  true if $(window).width() > Layout.breakpoints[breakpoint]


ready = ->

  fixMainContentHeight = ->
    sidenavHeight      = $('.navbar-side').height()
    mainContentHeight  = $('#mainContentContainer').outerHeight()

    navbarHeightAdjust = Layout.elementHeight('.navbar-default')
    footerHeightAdjust = Layout.elementHeight('.site-footer')

    adjustedHeightSum = navbarHeightAdjust + footerHeightAdjust + Layout.spacerHeight

    if sidenavHeight > mainContentHeight
      $('#mainContent').css("min-height": (sidenavHeight - adjustedHeightSum) + "px")

    if sidenavHeight < $(window).height() && $('body').height() < $(window).height()
      $('#mainContent').css("min-height": ($(window).height() - adjustedHeightSum) + "px")

  # Adjust the height of the main content section the best we can
  $(window).on "load resize scroll", (e) ->
    fixMainContentHeight() unless Layout.mediaBreakpointDown('sm')



$(document).ready(ready)
$(document).on('page:load', ready)
