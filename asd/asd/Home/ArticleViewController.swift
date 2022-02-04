//
//  ArticleViewController.swift
//  asd
//
//  Created by Vasiliy Samuilik on 5/22/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var articleTableView: UITableView!
    
    var article: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupArticleTableView()
    }
    
    private func setupArticleTableView() {
        articleTableView.delegate = self
        articleTableView.dataSource = self
        
        articleTableView.rowHeight = UITableView.automaticDimension
        
        let nib = UINib(nibName: "TitleTableViewCell", bundle: nil)
        articleTableView.register(nib, forCellReuseIdentifier: "TitleTableViewCell")
        
        let nib2 = UINib(nibName: "BodyTableViewCell", bundle: nil)
        articleTableView.register(nib2, forCellReuseIdentifier: "BodyTableViewCell")
        
        let nib3 = UINib(nibName: "HeaderTableViewCell", bundle: nil)
        articleTableView.register(nib3, forCellReuseIdentifier: "HeaderTableViewCell")
    }
    
    func setup(article: News) {
        self.article = article
        articleTableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            cell.set(imageUrls: article?.images ?? [])
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
            cell.textLabel?.text = article?.title
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BodyTableViewCell", for: indexPath) as! BodyTableViewCell
            cell.textLabel?.text = article?.body
            cell.textLabel?.numberOfLines = 0
            return cell
        }

        return UITableViewCell()
    }
}
