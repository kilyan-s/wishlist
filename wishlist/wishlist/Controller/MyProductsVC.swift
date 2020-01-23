//
//  MyProductsVC.swift
//  wishlist
//
//  Created by Kilyan SOCKALINGUM on 23/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

class MyProductsVC: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var tableview: UITableView!
    
    //MARK: Variables
    var products = [Product]()
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        return cell
    }
}
