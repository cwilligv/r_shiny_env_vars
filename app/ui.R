ui <- shiny::basicPage(
  
  div(
    textInput(inputId = "my_address", label = "Type An Address")
    , textOutput("var")
    , actionButton(inputId = "btn", "Search")
    , shiny::tags$head(
      shiny::tags$script(
        '
        var mapExists = setInterval(function() {

          if(typeof google !== "undefined") {
            
            if(typeof google.maps !== "undefined") {
              
              clearInterval(mapExists);
  
              var autocomplete = new google.maps.places.Autocomplete(document.getElementById("my_address"));
              
              autocomplete.addListener("place_changed", function() {
                 autocomplete.setFields(["place_id", "geometry", "name"]);
                 var place = autocomplete.getPlace();
  
                 Shiny.setInputValue("jsPlaceAutocomplete", place);
               });
            }
          }

        }, 100);
        '
      )
    )
    ,google_mapOutput(outputId = "my_map")
  )
)
