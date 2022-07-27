//
//  HomeViewModel.swift
//  DragonBallApp
//
//  Created by Joaquín Corugedo Rodríguez on 24/7/22.
//

import Foundation


protocol HomeViewModelProtocol{
    var dataCount:Int{get}
    
    func onViewsLoaded()
    
    func data(for index: Int) -> HomeCellModel?
    
    func onSelectedItem(at index: Int)
}

final class HomeViewModel {
  
    private weak var viewDelegate:HomeViewProtocol?
    private var viewData = [HomeCellModel]()
    
    init(viewDelegate:HomeViewProtocol?){
        self.viewDelegate = viewDelegate
    }
    
    func loadData(){
        
        //Solución sin llamada a API
        viewData = sampleCharactersData.compactMap {
            HomeCellModel(image: $0.photo, title: ($0.name), description: $0.description)
         }
        viewDelegate?.showLoading(false)
        viewDelegate?.updateViews()
        
        //Solución con llamada a API
//        viewDelegate?.showLoading(true)
//        let networkModel = NetworkModel()
//
//        networkModel.getCharacters { [weak self] characters, _ in
//            guard let self = self else { return }
//
//            self.viewData = characters.compactMap {
//                HomeCellModel(image: $0.photo, title: ($0.name), description: $0.description)
//             }
//
//            DispatchQueue.main.async {
//
//                self.viewDelegate?.updateViews()
//                self.viewDelegate?.showLoading(false)
//            }
//        }
        
    }
    
}

extension HomeViewModel: HomeViewModelProtocol{
    var dataCount: Int {
        viewData.count
    }
    
    func onViewsLoaded() {
        loadData()
    }
    
    func data(for index: Int) -> HomeCellModel? {
        guard index < dataCount else { return nil }
        return viewData[index]
    }
    
    func onSelectedItem(at index: Int) {
        guard let data = data(for: index) else { return }
        
        viewDelegate?.navigateToDetail(with: data)
    }
    
    
}
