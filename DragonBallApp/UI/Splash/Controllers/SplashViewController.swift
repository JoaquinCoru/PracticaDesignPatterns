//
//  ViewController.swift
//  DragonBallApp
//
//  Created by Joaquín Corugedo Rodríguez on 24/7/22.
//

import UIKit

protocol SplashViewProtocol: AnyObject{
    
    func showLoading(_ show:Bool)
    
    func navigateToHome()
}

class SplashViewController: UIViewController {
    
    private let homeIdentifier = "Home"

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: SplashViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsLoaded()
    }


}

extension SplashViewController:SplashViewProtocol{
    func showLoading(_ show: Bool) {
        switch show {
            case true where !activityIndicator.isAnimating:
                activityIndicator.startAnimating()

            case false:
                activityIndicator.stopAnimating()

            default: break
        }
    }
    
    func navigateToHome() {
        let homeStoryboard = UIStoryboard(name: homeIdentifier, bundle: nil)
         
         guard let destinationViewController  = homeStoryboard.instantiateInitialViewController() as? HomeViewController else {return}
        
         self.navigationController?.setViewControllers([destinationViewController], animated: true)
    }
    
    
}

