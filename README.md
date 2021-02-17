<p align="center"><img src="https://github.com/Dmurph21/AfterpayCars/blob/main/AppIcon.png?raw=true" width="150"></p>

# Afterpay Cars App

![afterpaycarscreenshots](https://github.com/Dmurph21/AfterpayCars/blob/main/Afterpay%20Screenshots.png?raw=true)

<p align="center"><img src="https://github.com/Dmurph21/AfterpayCars/blob/main/LoadingCars.gif?raw=true" width="250"></p>

## Focused Areas:

- UI
    - This was my first SwiftUI app. I wanted to showcase how quickly I could pick up and adapt to a new way of designing an app. I also like to keep up to date on current development practices and take advantage of any opportunity to learn something new and improve as a developer. I particularly loved how easy it was to build the user interface with the declarative syntax of SwiftUI.
    - Since this was meant to be a single-screen app that loads car data from the network, I focused on all the things you could do on a single screen with the given car data: 
        - Adding a NavigationView with the app logo.
        - Adding a MenuPicker to the NavigationView that sorts the cars based on the Make/Model, Price, Or Year.
        - Adding a SearchBar to the List that filters the car's list based on the Make, Model, Body, Or Year.
        - Adding a UIRefreshControl to the List in order to allow you to reload the data.
        - Adding a loading animation while waiting for the URLSessionDataTask to complete.
        - Adding additional car data (body type, engine configuration, MPG) to the car data item. 
        - Adding a placeholder view when there the cars list is empty.
        - Adding a placeholder view when retrieving the cars list returns an error.
        - Adding a placeholder view when retrieving the car's image from url.
        - Adding a placeholder view when retrieving the car's image from url fails.

- Architecture (MVVM design pattern)
    - Car functions as the Model.
    - CarListView function as the View.
    - FetchCars functions as the ViewModel.

## Other Areas:

- For testing the different endpoints, you will need to set the 'endpointType' property in the 'FetchCars' class to the case you would like to test. The options are '.normal' for the plain cars list, '.empty' for the empty cars list, and '.error' to cause an error.

```Swift
var endpointType: EndpointType = .normal
```

- You can set the 'testLoading' property in the 'FetchCars' class to 'true' and you will add a 2 second delay when data task completes to allow the 'Loading Cars...' animation to play.

```Swift
let testLoading: Bool = true
```
