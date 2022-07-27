//
//  DetailViewController.swift
//  DragonBallApp
//
//  Created by Joaquín Corugedo Rodríguez on 25/7/22.
//

import UIKit

private enum Constants {
  static let normalImageHeight = 200.0
}

protocol DetailViewProtocol:AnyObject {
    func update(image:URL)
    func update(title:String?)
    func update(description:String?)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDescription: UITextView!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel:DetailViewModelProtocol?
    
    override func viewDidLoad() {
        
        scrollView.delegate = self
        
        super.viewDidLoad()
        viewModel?.onViewsLoaded()
    }
    


}

extension DetailViewController:DetailViewProtocol{
    func update(image:URL){
        detailImage.setImage(url: image)
    }
    
    func update(title:String?){
        detailTitle.text = title
    }
    
    func update(description: String?) {
        detailDescription.text = description
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let correctedOffset = scrollView.contentOffset.y
        imageHeight.constant = Constants.normalImageHeight - correctedOffset
    }
}
