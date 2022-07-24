//
//  SplashViewModel.swift
//  DragonBallApp
//
//  Created by Joaquín Corugedo Rodríguez on 24/7/22.
//

import Foundation

protocol SplashViewModelProtocol:AnyObject{
    func onViewsLoaded()
}

final class SplashViewModel {
    
    weak var viewDelegate: SplashViewProtocol?
    
    // MARK: - Lifecycle
    init(viewDelegate: SplashViewProtocol?) {
        self.viewDelegate = viewDelegate
    }
    
    
    private func loadData(){
        viewDelegate?.showLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){ [viewDelegate] in
            viewDelegate?.showLoading(false)
            viewDelegate?.navigateToHome()
        }
    }
}

extension SplashViewModel:SplashViewModelProtocol{
    func onViewsLoaded() {
        loadData()
    }
    
    

}
