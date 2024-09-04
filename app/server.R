server <- function(input, output, session) {
  
  secret_values <- Sys.getenv("MY_SECRET")
  
  output$var <- renderText({
    if (secret_values == '') {
      paste0("No secret value captured")
    }else{
      paste0("The secret is: ", secret_values)
    }
  })
  
  observeEvent(input$jsPlaceAutocomplete, {
    print(input$jsPlaceAutocomplete)
    
    res <- input$jsPlaceAutocomplete
    
    df <- data.frame(
      lng = res$geometry$location$lng
      , lat = res$geometry$location$lat
    )
    
    
    googleway::google_map_update(map_id = "my_map") %>%
      googleway::add_markers(
        data = df,
        lat = "lat",
        lon = "lng",
        update_map_view = T
      )
  })
  
  observeEvent(input$btn, {
    print(input$jsPlaceAutocomplete)
  })
  
  output$my_map <- renderGoogle_map({
    google_map(
      location = c(-27.481080541187133, 153.0122871294947),
      zoom = 16,
      map_type_control = FALSE,
      zoom_control = FALSE,
      street_view_control = FALSE
    )
  })
  
}
