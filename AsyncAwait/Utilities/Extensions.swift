//
//  Extensions.swift
//  Learning-Examples
//
//  Created by Karthi Rasu on 23/07/23.
//

import UIKit


extension UITableView {
    func registerCell(cellId:String){
        self.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
}

extension UIView {
    
    class func loadNib<T:UIView>()->T{
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: self).first as! T
    }

    func showActivityIndicator(){
        let activity = UIActivityIndicatorView(style: .medium)
        activity.hidesWhenStopped = true
        self.addSubview(activity)
        activity.center = CGPoint(x: CGRectGetMidX(self.bounds), y: CGRectGetMidY(self.bounds))
        activity.startAnimating()
    }
    
    func hideActivityIndicator(){
        self.subviews.forEach { view in //for removing activity indicators
            view.removeFromSuperview()
        }
    }
    
    func makeRoudedCorners(){
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.contentMode = .scaleAspectFill
    }
}

extension UIImageView {
    func loadImage(url:String){
        Task{
            self.showActivityIndicator()
            let image = try await ImagesFetchHandler.shared.fetchImage(imageURL: url)
            self.image = image
            self.hideActivityIndicator()
        }
    }
}

extension URL {

    mutating func appendQueryItem(name: String, value: String?) {

        guard var urlComponents = URLComponents(string: absoluteString) else { return }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: name, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        self = urlComponents.url!
    }
}
