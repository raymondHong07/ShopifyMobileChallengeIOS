//
//  ProductsViewController.swift
//  ShopifyMobileChallenge
//
//  Created by Raymond Hong on 2018-09-17.
//  Copyright © 2018 Raymond Hong. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var filteredProducts: [Product] = []
    private let shopifyManager = ShopifyManager.sharedInstance
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpTableView()
    }

    init(with tag: String) {
        
        super.init(nibName: nil, bundle: nil)
        title = String(format: "%@ Products", tag)
        
        filterProductsBy(tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction private func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true) {}
    }
    
    private func filterProductsBy(_ tag: String) {
        
        // Sort products by filter tag
        for product in shopifyManager.allProducts {
            
            if product.tags.contains(tag) {
                
                filteredProducts.append(product)
            }
        }
    }
    
    private func setUpTableView() {
        
        ProductTableViewCell.register(with: tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.reloadData()
    }
}

extension ProductsViewController: UITableViewDelegate {
    
}

extension ProductsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier)
            as? ProductTableViewCell else {
                
                fatalError("cellForRowAt error")
        }
        
        let product = filteredProducts[indexPath.row]
        
        // Configure cell with product info
        cell.title = product.title
        cell.vendor = product.vendor
        cell.totalQuantity = product.totalAvail
        cell.productImage = product.productImage
        
        cell.selectionStyle = .none
        
        return cell
    }
}
