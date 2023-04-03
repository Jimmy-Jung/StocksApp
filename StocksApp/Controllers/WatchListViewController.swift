//
//  ViewController.swift
//  StocksApp
//
//  Created by 정준영 on 2023/03/30.
//

import UIKit

final class WatchListViewController: UIViewController {
    
    private var searchTimer: Timer?

    // MARK: - 라이프사이클

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSearchController()
        setUpTittleView()
    }

    // MARK: - 메서드

    private func setUpSearchController() {
        let resultVC = SearchResultViewController()
        resultVC.delegate = self
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }
    
    // MARK: - 뷰

    private func setUpTittleView() {
        let titleView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.with,
                height: navigationController?.navigationBar.height ?? 100
            )
        )
        let label = UILabel(
            frame: CGRect(
                x: 10,
                y: 0,
                width: titleView.with - 20,
                height: titleView.height
            )
        )
        label.text = "Stocks"
        label.font = .systemFont(ofSize: 40, weight: .medium)
        titleView.addSubview(label)
        
        navigationItem.titleView = titleView
    }

}
// MARK: - UISearchResultsUpdating

extension WatchListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultVC = searchController.searchResultsController as? SearchResultViewController else {
            return
        }
        //Reset timer
        searchTimer?.invalidate()
        
        // 타이핑할 때마다 검색해주는 빈도를 줄여줌
        // Kick off new timer
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            APICaller.shared.search(query: query) { result in
                print(query)
                switch result {
                case .success(let response):
                    DispatchQueue.main.sync {
                        resultVC.update(with: response.result)
                    }
                case .failure(let error):
                    DispatchQueue.main.sync {
                        resultVC.update(with: [])
                    }
                    print(error)
                }
            }
        })
        
    }
}

// MARK: - SearchResultsViewControolerDelegate

extension WatchListViewController: SearchResultsViewControllerDelegate {
    func SearchResultsViewControllerDidSelect(searchResult: SearchResult) {
        //선택
        print("Did select: \(searchResult.displaySymbol)")
    }
}
