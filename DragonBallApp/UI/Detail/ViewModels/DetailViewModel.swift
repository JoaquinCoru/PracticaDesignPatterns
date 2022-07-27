//
//  DetailViewModel.swift
//  DragonBallApp
//
//  Created by Joaquín Corugedo Rodríguez on 25/7/22.
//

import Foundation

protocol DetailViewModelProtocol{
    func onViewsLoaded()
}


class DetailViewModel{
    
    private weak var viewDelegate:DetailViewProtocol?
    private var viewData: HomeCellModel
    
    init(data:HomeCellModel,
         viewDelegate:DetailViewProtocol) {
        viewData = data
        self.viewDelegate = viewDelegate
    }
        
}

extension DetailViewModel:DetailViewModelProtocol{
    func onViewsLoaded() {
        viewDelegate?.update(title: viewData.title)
        viewDelegate?.update(image: viewData.image)
        viewDelegate?.update(description: viewData.description)
    }
        
}
