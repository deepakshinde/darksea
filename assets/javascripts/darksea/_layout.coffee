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

# Adjust the height of the main column. Flexbox would cure this as well, but
# waiting on better Bootstrap support
Layout.fixMainContentHeight = ->

  collapsedSubmenuHeight = 0

  # Add up the height of all collapsed submenus
  $('.dropdown').children('ul').each (i, e) ->
    if $(e).attr("aria-expanded") == "false"
      collapsedSubmenuHeight += $(e).height()

  # Calculate the height of the side nav
  sidenavHeight = $('.navbar-side').height() - collapsedSubmenuHeight

  # Get the height of potentially known static elements on the page
  navbarHeight = Layout.elementHeight('.navbar-default')
  footerHeight = Layout.elementHeight('.site-footer')

  # Get the sum of the excluded elements
  excludedElements = navbarHeight + footerHeight + Layout.spacerHeight

  if sidenavHeight > $(window).height()
    $('#mainContent').css("min-height": (sidenavHeight - excludedElements) + "px")

  if sidenavHeight < $(window).height()
    $('#mainContent').css("min-height": ($(window).height() - excludedElements) + "px")


ready = ->

  Layout.fixMainContentHeight() unless Layout.mediaBreakpointDown('sm')


$(document).ready(ready)
$(document).on('page:load', ready)

# Adjust the height of the main content section the best we can
$(window).on "resize scroll", (e) ->
  Layout.fixMainContentHeight() unless Layout.mediaBreakpointDown('sm')
