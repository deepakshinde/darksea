# Create Utils namespace
window.Utils = {}

Utils.elementExists = (e) ->
  true if $(e).length > 0
