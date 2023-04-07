//
//  TopStoriesNewsViewController.swift
//  StocksApp
//
//  Created by 정준영 on 2023/04/04.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {
    
    enum `Type` {
        case topStories
        case compan(symbol: String)
        
        var title: String {
            switch self {
            case .topStories:
                return "Top Stotris"
                
            case .compan(symbol: let symbol):
                return symbol.uppercased()
            }
        }
    }
    
    // MARK: - Properties
    
    private var stories = [NewsStory]()
    
    private let type: Type
    
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsStoryTableViewCell.self,
                       forCellReuseIdentifier: NewsStoryTableViewCell.identifier)
        table.register(NewsHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: NewsHeaderView.identifier)
        table.backgroundColor = .clear
        
        return table
    }()
    
    // MARK: - Init

    init(type: Type) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        fetchNews()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Method

    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchNews() {
        APICaller.shared.news(for: type) { [weak self] results in
            switch results {
            case .success(let stories):
                DispatchQueue.main.async {
                    self?.stories = stories
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func open(url: URL) {
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

}


// MARK: - TableView Extension

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsStoryTableViewCell.identifier,
            for: indexPath
        ) as? NewsStoryTableViewCell else {
            fatalError()
        }
        cell.configure(with: .init(model: stories[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsHeaderView.identifier) as? NewsHeaderView else {
            return nil
        }
        header.configure(
            with: NewsHeaderView.ViewModel(
                title: self.type.title,
                shouldShowAddButton: false
            )
        )
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsStoryTableViewCell.preferredHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewsHeaderView.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Open NewsStory
         let story = stories[indexPath.row]
        guard let url = URL(string: story.url) else {
            presentFailedToOpenAlert()
            return
        }
        open(url: url)
    }
    
    private func presentFailedToOpenAlert() {
        let alert = UIAlertController(
            title: "열기 실패",
            message: "기사를 여는데 실패했습니다.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        present(alert, animated: true)
    }
}
