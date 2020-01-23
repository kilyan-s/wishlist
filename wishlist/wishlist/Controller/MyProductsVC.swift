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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, bool) in
            self.deleteProduct(atIndexPath: indexPath)
            self.fetchProductData()
        }
        deleteAction.backgroundColor = UIColor(hexString: "#eb4d4b")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        
        return swipeConfiguration
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
    
    func deleteProduct(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(products[indexPath.row])
        
        do {
            try managedContext.save()
            print("Successfully save data")
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
