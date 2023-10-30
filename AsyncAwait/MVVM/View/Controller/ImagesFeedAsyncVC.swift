//
//  ImagesFeedAsyncVC.swift
//  Learning-Examples
//
//  Created by Karthi Rasu on 23/07/23.
//

import UIKit

class ImagesFeedAsyncVC: UIViewController {
    
    @IBOutlet weak var imageView1 : UIImageView!
    @IBOutlet weak var imageView2 : UIImageView!
    @IBOutlet weak var imageView3 : UIImageView!
    @IBOutlet weak var imageView4 : UIImageView!
    @IBOutlet weak var imageView5 : UIImageView!
    @IBOutlet weak var imageView6 : UIImageView!
    
    let viewModel = ImagesFetchViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        viewModel.imageViews.append(contentsOf:[imageView1,imageView2,imageView3,imageView4,imageView5,imageView6])
        viewModel.makeViews()
        viewModel.loadImages()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(moveToImagesListVC))
        self.view.addGestureRecognizer(tapGesture)
        NetworkManager.shared.makePostAPICall(type: [PhotosModel].self, parameters: [:]) { data, error in
            if error == nil {
                
            }
        }
    }
    
    @objc func moveToImagesListVC(){
        let dashboardVC = ImagesFetchListVC(nibName: "ImagesFetchListVC", bundle: nil)
        dashboardVC.modalTransitionStyle = .flipHorizontal
        dashboardVC.modalPresentationStyle = .overCurrentContext
        self.navigationController?.pushViewController(dashboardVC, animated: true)
    }
}
