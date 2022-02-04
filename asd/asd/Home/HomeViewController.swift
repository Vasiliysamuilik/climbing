//
//  HomeViewController.swift
//  asd
//
//  Created by Vasiliy Samuilik on 4/24/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet private weak var myTable: UITableView!
    
    var news: [News] = []
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.dataSource = self
        myTable.delegate = self
        
        fetchNews()
    }
    
    //MARK: - Private funcs
    
    private func fetchNews() {
        FirebaseManager.shared.fetchNews { [weak self] result in
            switch result {
            case .value(let response):
                self?.news = response.array
                self?.myTable.reloadData()
            case .error(_): ()
            }
        }
    }
    
    //MARK: - UITableViewDataSource
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        cell.textLabel?.text = news[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleVC = ArticleViewController()
        articleVC.setup(article: news[indexPath.row])
        self.present(articleVC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
