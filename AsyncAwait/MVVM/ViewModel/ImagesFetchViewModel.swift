//
//  ImagesFetchViewModel.swift
//  Learning-Examples
//
//  Created by Karthi Rasu on 23/07/23.
//

import UIKit


class ImagesFetchViewModel {
    
    static let shared = ImagesFetchViewModel()
    let imagesFetcher = ImagesFetchHandler.shared
    
    var newPhotosAdded : (()->())?
    
    var urls = [String]()
    var imageViews = [UIImageView]()
    
    var photosModel : [PhotosModel]?
    
    var pageCount = 1
    
    private init(){
        urls = [
            "https://ecobnb.com/blog/app/uploads/sites/3/2020/01/nature-1170x490.jpg",
            "https://hips.hearstapps.com/hmg-prod/images/nature-quotes-landscape-1648265299.jpg?crop=1.00xw:0.760xh;0,0.0587xh&resize=1200:*",
            "https://wallpapers.com/images/featured-full/hd-a5u9zq0a0ymy2dug.jpg",
            "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg?w=2000&t=st=1687688143~exp=1687688743~hmac=5b881a45ef0bbb304670a730ffe6fe032a1eb8c51c053352272474b6b09126bb",
            "https://wallpapers.com/images/hd/hd-close-up-of-lion-xk00jcsvh1occ0pw.jpg",
            "https://wallpapers.com/images/hd/hd-country-life-at-night-vvxmbqzkr4uumuni.jpg"]
    }
    
    func loadImages(){
        if urls.count != imageViews.count {return}
        
        imageViews.enumerated().forEach({ index,view in
            view.loadImage(url: urls[index])
        })
    }
    
    func makeViews(){
        imageViews.forEach { view in
            view.makeRoudedCorners()
        }
    }
    
    func fetchPhotosWithAsync() async{
        Task {
            let data = try await imagesFetcher.unsplashPhotosFetch(page: 1, type: [PhotosModel].self)
            if photosModel == nil{
                photosModel = data
            }else{
                photosModel?.append(contentsOf: data)
            }
            newPhotosAdded?()
        }
    }
}
