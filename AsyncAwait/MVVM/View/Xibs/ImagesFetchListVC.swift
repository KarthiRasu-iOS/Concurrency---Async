//
//  ImagesFetchListVC.swift
//  Learning-Examples
//
//  Created by Karthi Rasu on 23/07/23.
//

import UIKit

class ImagesFetchListVC: UIViewController {
    
    @IBOutlet weak var imagesList : UITableView!
    
    let viewModel = ImagesFetchViewModel.shared
    let cellId = "ImageFeedCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesList.delegate = self
        imagesList.dataSource = self
        imagesList.registerCell(cellId: cellId)
        dataReloadClosures()
        if #available(iOS 15.0, *) {
            imagesList.sectionHeaderTopPadding = 0
        }
        Task {
            let _ = await viewModel.fetchPhotosWithAsync()
        }
    }
    
    func dataReloadClosures(){
        viewModel.newPhotosAdded = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imagesList.reloadData()
            }
        }
    }
}

extension ImagesFetchListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let photos = viewModel.photosModel else { return 0}
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let imageFeedCell = tableView.dequeueReusableCell(withIdentifier: cellId) as? ImageFeedCell , let photos = viewModel.photosModel else {
            return UITableViewCell()
        }
        imageFeedCell.feedImage.loadImage(url: photos[indexPath.row].urls?.regular ?? "")
        return imageFeedCell
    }
}

extension ImagesFetchListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height * 0.8
    }
}
