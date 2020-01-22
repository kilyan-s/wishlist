//
//  ViewController.swift
//  wishlist
//
//  Created by Kilyan SOCKALINGUM on 22/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

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
        print("textfieldValueDidChange")
        if wageTextfield.text != "" && priceTextfield.text != "" {
            updateCalcBtn(isEnabled: true)
        } else {
            updateCalcBtn(isEnabled: false)
        }
        
        updateClearBtnState(isHidden: false)
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    //MARK: IBActions
    @IBAction func calculateBtnPressed(_ sender: Any) {
        print("calculateBtnPressed")
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
    }
    
}
