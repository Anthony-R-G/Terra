//
//  NewsViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/2/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import SafariServices

final class NewsViewController: UIViewController {
    
    //MARK: -- UI Element Initialization
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .lightGray
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching News Data ...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(NewsArticleTableViewCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        tv.scrollsToTop = true
        tv.backgroundColor = .clear
        tv.refreshControl = refreshControl
        tv.separatorColor = .white
        tv.dataSource = self
        tv.delegate = self
        tv.prefetchDataSource = self
        tv.indicatorStyle = .white
        return tv
    }()
    
    //MARK: -- Properties
    
    private var viewModel: NewsViewModel!
    
    
    //MARK: -- Methods
    
    @objc private func handleRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
        }
    }
    
    private func showModally(_ viewController: UIViewController) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let rootViewController = window?.rootViewController
        rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    private func presentWebBrowser(link: URL){
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false
        let safariVC = SFSafariViewController(url: link, configuration: config)
        showModally(safariVC)
    }
    
    
    //MARK: -- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel = NewsViewModel(delegate: self)
        viewModel.fetchNews()
        addSubviews()
        setConstraints()
    }
}

extension NewsViewController: NewsViewModelDelegate {
    func fetchCompleted() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalNewsArticlesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newsCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath) as! NewsArticleTableViewCell
        let specificArticle = viewModel.specificArticle(at: indexPath.row)
        newsCell.configureCell(from: specificArticle)
        return newsCell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.deviceAdjusted
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let specificArticle = viewModel.specificArticle(at: indexPath.row)
        Utilities.generator.impactOccurred()
        presentWebBrowser(link: URL(string: specificArticle.url)!)
    }
}

extension NewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row > viewModel.totalNewsArticlesCount - 3 && !viewModel.newsFetchIsUnderway {
                viewModel.fetchNews()
                break
            }
        }
    }
}


//MARK: -- Add Subviews & Constraints

fileprivate extension NewsViewController {
    
    func addSubviews() {
       [tableView].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        setTableViewConstraints()
    }
    
    func setTableViewConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
    }
}



