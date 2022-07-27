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
    func showLoading(_ show:Bool)
}


class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    
    func showLoading(_ show: Bool) {
        switch show {
            case true :
                activityIndicator.startAnimating()
                collectionView.isHidden = true
                
            case false:
                activityIndicator.stopAnimating()
                collectionView.isHidden = false
                
        }
    }
    
    func updateViews() {
        collectionView.reloadData()
    }
    
    func navigateToDetail(with data: HomeCellModel?) {
        let detailStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        
        guard let data = data, let destination = detailStoryboard.instantiateInitialViewController() as? DetailViewController else {return}
        
        destination.viewModel = DetailViewModel(data: data, viewDelegate: destination)
        
        navigationController?.pushViewController(destination, animated: true)
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel?.onSelectedItem(at: indexPath.row)
    }


}
