//
//  AllTagsViewController.swift
//  ShopifyMobileChallenge
//
//  Created by Raymond Hong on 2018-09-17.
//  Copyright © 2018 Raymond Hong. All rights reserved.
//

import UIKit

final class AllTagsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated:true)
        title = "All Tags"
        
        setUpTableView()
    }
    
    private func setUpTableView() {
        
        TagTableViewCell.register(with: tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension AllTagsViewController: UITableViewDelegate {
    
}

extension AllTagsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ShopifyManager.sharedInstance.allTags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TagTableViewCell.identifier)
            as? TagTableViewCell else {
                
                fatalError("cellForRowAt error")
        }
        
        cell.title = ShopifyManager.sharedInstance.allTags[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let productsVc = ProductsViewController(with: ShopifyManager.sharedInstance.allTags[indexPath.row])
        navigationController?.pushViewController(productsVc, animated: true)
    }
}
