//
//  MyProductsVC.swift
//  wishlist
//
//  Created by Kilyan SOCKALINGUM on 23/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit
import CoreData


class MyProductsVC: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var tableview: UITableView!
    
    //MARK: Variables
    var products: [Product] = []
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProductData()
    }
    
    func fetchProductData() {
        self.fetchData { (success) in
            if success {
                if self.products.count > 0 {
                    self.tableview.isHidden = false
                } else {
                    self.tableview.isHidden = true
                }
            }
        }
        
        self.tableview.reloadData()
    }
    
}

extension MyProductsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as? ProductCell else { return UITableViewCell() }
        let product = products[indexPath.row]
        cell.configureView(withName: product.name!, andWage: product.wage, forPrice: product.price, andResultHours: product.hours)
        return cell
    }
}

//CoreData functions
extension MyProductsVC {
    
    func fetchData(_ completion: @escaping CompletionHandler) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<Product>(entityName: "Product")
        
        do {
            products = try managedContext.fetch(fetchRequest)
            print("Successfully fetch data")
            completion(true)
        } catch {
            debugPrint(error.localizedDescription)
            completion(false)
        }
    }
}
