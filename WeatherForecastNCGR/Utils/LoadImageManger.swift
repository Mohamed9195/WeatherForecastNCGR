//
//  LoadImageManger.swift
//  WeatherForecastNCGR
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import UIKit
import SDWebImage

protocol InputSource {
    /**
     Load image from the source to image view.
     - parameter imageView: Image view to load the image into.
     - parameter callback: Callback called after image was set to the image view.
     - parameter image: Image that was set to the image view.
     */
    func load(the urlString: String, placeholderImage: UIImage?, completionBlock: @escaping (() -> Void))
    
    func configuration_sd_image(maxDiskSize: UInt, maxMemoryCost: UInt, maxDiskAge: Double)
    
    /**
     Cancel image load on the image view
     - parameter imageView: Image view that is loading the image
     */
    func cancelLoad(on imageView: UIImageView)
}

// MARK: - add functionality of InputSource
extension UIImageView: InputSource {

    func configuration_sd_image(maxDiskSize: UInt = 1048576 * 300, maxMemoryCost: UInt = 1048576 * 300, maxDiskAge: Double = 0.0) {
        SDImageCache.shared.config.maxDiskSize = maxDiskSize
        SDImageCache.shared.config.maxMemoryCost = maxMemoryCost
        SDImageCache.shared.config.maxDiskAge = maxDiskAge
    }
    
    func load(the urlString: String, placeholderImage: UIImage? = nil, completionBlock: @escaping (() -> Void)  = {  }) {
        var correctUrl = urlString
        if correctUrl.contains(" ") {
            correctUrl = correctUrl.replacingOccurrences(of: " ", with: "%20")
        }
        let url = URL(string: correctUrl)
        
        if let cachedImage = SDImageCache.shared.imageFromCache(forKey: correctUrl) {
            image = cachedImage
            completionBlock()
        } else {
            self.sd_setImage(with: url,
                                  placeholderImage: placeholderImage,
                                  options: [.retryFailed],
                                  context: [:],
                                  progress: .none) { (_, error, _, _) in
                if error != nil {
                   // handel error
                } else {
                  completionBlock()
                }
            }
        }
    }
    
    func cancelLoad(on imageView: UIImageView) {
        imageView.sd_cancelCurrentImageLoad()
    }
}

