nyMarker = null
laMarker = null
map = null


# Template for div to show checkboxes
getCheckboxDivHtml = ->
   [
      '<div id="checboxDiv">',
         '<input type="checkbox" id="ny" checked>New York'
         '<input type="checkbox" id="la">Los Angeles'
      '</div>'
   ].join("")

addMarkerToMap = (lat, lng, opacity) -> 
   marker = new google.maps.Marker
      position: new google.maps.LatLng(lat, lng)
      map: map
      opacity: opacity
      opacities: []
   marker
   
addMarkerClickHandler = (checkbox, marker) ->
   checkbox.click( ->
      if $(this).is(":checked")
         marker.opacities = marker.opacities.concat([.2, .4, .6, .8, 1])
      else
         marker.opacities = marker.opacities.concat([.8, .6, .4, .2, 0])
   )

# Background thread to fade markers in/out
animateMarkers = () ->
   for marker in [nyMarker, laMarker]
      if marker.opacities.length > 0
         marker.setOpacity(marker.opacities[0])
         marker.opacities.shift()
   setTimeout( ->
      animateMarkers()
    50)

   
init = () ->
   options =
      center: new google.maps.LatLng(39.8111444,-88.5569364)
      zoom: 4
      mapTypeControl: false
      panControl: false
      zoomControl: false
      streetViewControl: false
      
   map = new google.maps.Map(document.getElementById("map"), options)      
         
   nyMarker = addMarkerToMap(40.7127, -74.0059, 1)
   laMarker = addMarkerToMap(34.0500, -118.25, 0)
             
   map.controls[google.maps.ControlPosition.TOP_RIGHT].push($(getCheckboxDivHtml())[0])
   animateMarkers()

   # Add checkbox click handlers
   setTimeout( =>
      addMarkerClickHandler($("#ny"), nyMarker)
      addMarkerClickHandler($("#la"), laMarker)
    1000)


 
$(document).ready init

