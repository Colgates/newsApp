//
//  HomeViewControllerViewModel.swift
//  NewsApp
//
//  Created by Evgenii Kolgin on 23.08.2021.
//

import UIKit

class HomeViewControllerViewModel {
    
    var dataSource: UITableViewDiffableDataSource<Int, Article>?
    
    func fetchTopStories() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):

                self?.updateSnapshot(with: articles)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchQueryData(_ text: String) {
        APICaller.shared.search(with: text) { [weak self] result in
            switch result {
            case .success(let articles):

                self?.updateSnapshot(with: articles)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateSnapshot(with items: [Article]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Article>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}
