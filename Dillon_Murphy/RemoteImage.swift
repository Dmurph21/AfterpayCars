//
//  RemoteImage.swift
//  Dillon_Murphy
//
//  Created by Dillon Murphy on 2/10/21.
//

import SwiftUI

/// Image View that loads image asynchronously.
struct RemoteImage: View {
    
    /// Image's state of loading.
    ///
    /// Corresponds to one of three possible states for image loading.
    private enum LoadState {
        
        /// Image currently loading state.
        case loading
        
        /// Image successfully loaded state.
        case success
        
        /// Image failed to  load state.
        case failure
    }
    
    /// An observable object class that announces the state of the image loading.
    private class Loader: ObservableObject {
        
        /// Image data.
        var data = Data()
        
        /// Image's state of loading.
        var state = LoadState.loading

        
        /// Initialization of `Loader`.
        ///
        /// - Parameters:
        ///    - url: The URL to retrieve the car image data from.
        ///
        init(url: String) {
            
            //Check if URL is valid
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }
            
            //Initialize a URLSessionDataTask with the url and a completion handler to call when the data task completes
            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                //Check if image data exists
                if let data = data, data.count > 0 {
                    /// Set  `data` to the returned image data and `state` to success.
                    self.data = data
                    self.state = .success
                } else {
                    /// Set  `state` to failure
                    self.state = .failure
                }

                // Refresh observing views by sending state update manually
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }
    
    /// Image loading object.
    @StateObject private var loader: Loader
    
    /// Image when in `LoadState.loading` state.
    let loading: Image = Image("LoadingImage")
    
    /// Image when in `LoadState.failure` state.
    let failure: Image = Image("ImageNotFound")

    var body: some View {
        selectImage()
            .resizable()
            .frame(width: 160.0, height: 120.0)
            .aspectRatio(contentMode: .fill)
            .border(Color.black)
    }
    
   //MARK: Initialization
    init(url: String) {
        _loader = StateObject(wrappedValue: Loader(url: url))
    }
    
    
    // MARK: - Handling Image State
    
    /// Retrieves the Image view for the current loading state.
    ///
    /// - Returns: A view that displays an image.
    ///
    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: "https://afterpay-mobile-interview.s3.amazonaws.com/images/honda_civic_1.jpg")
    }
}
