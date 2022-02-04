//
//  PriceViewController.swift
//  asd
//
//  Created by Vasiliy Samuilik on 4/22/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import UIKit
   
class PriceViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var services: [Services] = []
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "ItemCollectionViewCell"
    let viewSegueIdentifier = "viewSegueIdentifier"
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        fetchServices()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupCollectionViewItemSize()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    //MARK: - Private funcs
    
    private func fetchServices() {
        FirebaseManager.shared.fetchServices { [weak self] result in
            switch result {
            case .value(let response):
                self?.services = response.array
                self?.collectionView.reloadData()
            case .error(_): ()
            }
        }
    }
    
    //MARK: - SetupCollectionViewItemSize
    
    private func setupCollectionViewItemSize() {
        if collectionViewFlowLayout == nil {
            
            let numberOfItemPerRow: CGFloat = 3
            let lineSpacing: CGFloat = 30
            let interItemSpacing: CGFloat = 10
            
            let width = (collectionView.frame.width - (numberOfItemPerRow - 1) * interItemSpacing) / numberOfItemPerRow
            
            let height = width
             
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 80, left: 40, bottom: 0, right: 40)
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSegueIdentifier" {
            let display = segue.destination as! ServiceViewController
            display.services = sender as? Services
        }
    }
}

//MARK: - UICollectionViewDataSource

extension PriceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let service = services[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        cell.setup(urlString: service.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let service = services[indexPath.row]
        performSegue(withIdentifier: viewSegueIdentifier, sender: service)
        
    }
    
}

