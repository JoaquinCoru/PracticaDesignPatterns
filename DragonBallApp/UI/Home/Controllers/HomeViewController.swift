//
//  HomeViewController.swift
//  DragonBallApp
//
//  Created by Joaquín Corugedo Rodríguez on 24/7/22.
//

import UIKit

protocol HomeViewProtocol: AnyObject{
    func updateViews()
    func navigateToDetail(with data:HomeCellModel?)
}


class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel:HomeViewModelProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        viewModel?.onViewsLoaded()
    }
    
    private func configureViews(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

}

extension HomeViewController:HomeViewProtocol{
    
    func updateViews() {
        collectionView.reloadData()
    }
    
    func navigateToDetail(with data: HomeCellModel?) {
        
    }
        
}


extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sampleCharactersData.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width/2) - 8, height: 190.0)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellView.cellIdentifier, for: indexPath) as? CellView

        if let data = viewModel?.data(for: indexPath.row) {
            cell?.updateViews(data: data)
        }

        return cell ?? UICollectionViewCell()
    }


}
