//
//  ViewController.swift
//  News
//
//  Created by VladVarsotski on 1.02.23.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self,forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        return table
    }()
    
    private let searchVC = UISearchController(searchResultsController: nil )
    
    private var articles = [Article]()
    private var viewModels = [NewsTableViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        view.backgroundColor = .systemBackground
        
        fetchTopStories()
        createSearchBar()
    }
    
    @objc private func refresh() {
        fetchTopStories()
    }
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    private func fetchTopStories() {
        
        if tableView.refreshControl?.isRefreshing == true {
            print("refreshing data")
        } else {
            print("fetching data")
        }
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title,
                                               description: $0.description ?? "No Description",
                                               pubDate: $0.pubDate,
                                               content: $0.content ?? "No Content",
                                               image_url: URL(string: $0.image_url ?? ""))
                })
                DispatchQueue.main.async {
                    self?.tableView.refreshControl?.endRefreshing()
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let degree: Double = 90
        let rotationAngel = CGFloat(degree * M_PI / 180)
        let rotationTrasform = CATransform3DMakeRotation(rotationAngel, 1, 0, 0)
        cell.layer.transform = rotationTrasform
        
        UIView.animate(withDuration: 1, delay: 0.05 * Double(indexPath.row), options: .curveEaseInOut) {
            cell.layer.transform = CATransform3DIdentity
        }
        
        
        //        let translationTranform = CATransform3DTranslate(CATransform3DIdentity, -500, 400, 0)
        //        cell.layer.transform = translationTranform
        //
        //        UIView.animate(withDuration: 1, delay: 0.2 * Double(indexPath.row), options: .curveEaseInOut) {
        //            cell.layer.transform = CATransform3DIdentity
        //        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.link ?? "") else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: NewsViewController.self)) as! NewsViewController
        
        vc.urlString = "\(url)"
        vc.configure(with: viewModels[indexPath.row])
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    //    Search
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        APICaller.shared.search(with: text) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title,
                                               description: $0.description ?? "No Description",
                                               pubDate: $0.pubDate,
                                               content: $0.content ?? "No Content",
                                               image_url: URL(string: $0.image_url ?? ""))
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
