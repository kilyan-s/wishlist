//
//  ViewController.swift
//  wishlist
//
//  Created by Kilyan SOCKALINGUM on 22/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit
import CoreData

//For CoreData
let appDelegate = UIApplication.shared.delegate as? AppDelegate

class HomeVC: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var wageTextfield: UITextField!
    @IBOutlet weak var priceTextfield: UITextField!
    @IBOutlet weak var calculateBtn: RoundedButton!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var saveBtn: RoundedButton!
    @IBOutlet weak var clearBtn: UIButton!
    
    //MARK: Variables
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //Monitor changes on textfields values
        wageTextfield.addTarget(self, action: #selector(textfieldValueDidChange), for: .editingChanged)
        priceTextfield.addTarget(self, action: #selector(textfieldValueDidChange), for: .editingChanged)
        
        //Disable btn when app starts
        updateCalcBtn(isEnabled: false)
        updateSaveBtn(isHidden: true)
        updateClearBtnState(isHidden: true)
        
        //Tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    func updateClearBtnState(isHidden: Bool) {
        clearBtn.isHidden = isHidden
        clearBtn.isEnabled = !isHidden
    }
    
    func updateCalcBtn(isEnabled: Bool) {
        if isEnabled {
            calculateBtn.backgroundColor = UIColor(red: 0.059, green: 0.047, blue: 0.196, alpha: 1.0)
            calculateBtn.isEnabled = true
        } else {
            calculateBtn.backgroundColor = UIColor.darkGray
            calculateBtn.isEnabled = false
        }
    }
    
    func updateSaveBtn(isHidden: Bool) {
        saveBtn.isHidden = isHidden
        saveBtn.isEnabled = !isHidden
    }
    
    @objc func textfieldValueDidChange() {
        if wageTextfield.text != "" && priceTextfield.text != "" {
            updateCalcBtn(isEnabled: true)
        } else {
            updateCalcBtn(isEnabled: false)
        }
        
        updateClearBtnState(isHidden: false)
    }
    
    @objc func viewTapped() {
        endEditing()
    }
    
    func endEditing() {
        view.endEditing(true)
    }
    
    func clearFields() {
        wageTextfield.text = ""
        priceTextfield.text = ""
        updateCalcBtn(isEnabled: false)
        
        hoursLabel.text = "0"
        updateSaveBtn(isHidden: true)
        
        updateClearBtnState(isHidden: true)
        
        endEditing()
    }
    
    func saveProduct(withName name: String, forPrice price: String, andWage wage: String, resultHour hours: String, completion: @escaping CompletionHandler) {
        guard let productWage = Int32(wage) else { return }
        guard let productPrice = Int32(price) else { return }
        guard let productHours = Int32(hours) else { return }
        let productName = name
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        
        let newProduct = Product(context: context)
        newProduct.name = productName
        newProduct.wage = productWage
        newProduct.price = productPrice
        newProduct.hours = productHours
        
        do {
            try context.save()
            print("Succefully saved")
            completion(true)
            
        } catch {
            debugPrint(error.localizedDescription)
            completion(false)
        }
    }
    
    //MARK: IBActions
    @IBAction func calculateBtnPressed(_ sender: Any) {
        endEditing()
        
        if let wage = wageTextfield.text, let price = priceTextfield.text {
            let result = Calculator.getHours(forWage: wage, andPrice: price)
            hoursLabel.text = result
            updateSaveBtn(isHidden: false)
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Save this product", message: "Give a name to your product", preferredStyle: .alert)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Product's name"
            //textfield.textColor = UIColor.white
        }
        
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            guard let textfield = alertController.textFields?[0] else { return }
            
            if textfield.text != "" {
                self.saveProduct(withName: textfield.text!, forPrice: self.priceTextfield.text!, andWage: self.wageTextfield.text!, resultHour: self.hoursLabel.text!) { (success) in
                    if success {
                        self.clearFields()
                    }
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in }
        
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func listProductPressed(_ sender: Any) {
        performSegue(withIdentifier: "wishlistToProduct", sender: self)
        
//        guard let myProductsVC = storyboard?.instantiateViewController(withIdentifier: "MyProductsVC") else { return }
//        myProductsVC.modalPresentationStyle = .currentContext
//        navigationController?.pushViewController(myProductsVC, animated: true)
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        clearFields()
    }
}
