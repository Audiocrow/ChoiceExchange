//
//  ExchangeChoiceViewController.swift
//  ChoiceExchange
//
//  Created by CampusUser on 4/3/17.
//  Copyright © 2017 Alexander Edgar. All rights reserved.
//

import UIKit

class ExchangeChoiceViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var homeChoicePicker: UIPickerView!
    @IBOutlet weak var foreignChoicePicker: UIPickerView!
    var foreignChoices:[Currency] = []
    var homeChoices:[Currency] = []
    //Selected Choices: homeChoice = homeChoices[homeChoicePicker.selectedRowInComponent(0)]
    @IBOutlet weak var homeNumField: UITextField!
    @IBOutlet weak var homeSymLabel: UILabel!
    @IBOutlet weak var foreignNumLabel: UILabel!
    @IBOutlet weak var foreignSymLabel: UILabel!
    //var waiting = false
    
    func sendQuery() {
        //if(waiting == true) { return }
        let selectedHome = homeChoicePicker.selectedRow(inComponent: 0)
        let selectedForeign = foreignChoicePicker.selectedRow(inComponent: 0)
        if(selectedHome < homeChoices.count && selectedForeign < foreignChoices.count) {
            //waiting = true
            self.foreignNumLabel.text = "Waiting..."
            let query = "SELECT * FROM yahoo.finance.xchange WHERE pair in (\"\(homeChoices[selectedHome].symbol)\(foreignChoices[selectedForeign].symbol)\")"
            YQL().query(query) { jsonDict in
                var queryDict = jsonDict["query"] as! [String:Any]
                var resultsDict = queryDict["results"] as! [String:Any]
                var rateDict = resultsDict["rate"] as! [String:Any]
                var rateString = rateDict["Rate"] as? String
                var rate = rateString != nil ? Double(rateString!) : nil
                if(rate == nil) { self.foreignNumLabel.text = "Invalid Results." }
                else {
                    if(rate != 0) {
                        self.foreignNumLabel.text = String(Double(self.homeNumField.text!)! * rate!)
                    }
                    else { self.foreignNumLabel.text = "0" }
                }
                //self.waiting = false
                self.view.setNeedsDisplay()
            };
        }
    }
    @IBAction func updatePressed(_ sender: UIButton) {
        sendQuery()
    }
    
    override func touchesBegan(_: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //var fileManager = FileManager()
        //var userFile = "Library/Application Support/choiceexchange"
        homeChoicePicker.dataSource = self
        homeChoicePicker.delegate = self
        foreignChoicePicker.dataSource = self
        foreignChoicePicker.delegate = self
        homeChoices = CurrenciesHolder.Currencies.getSubset(true)
        foreignChoices = CurrenciesHolder.Currencies.getSubset(false)
        //foreignNumLabel.layer.borderWidth = 1.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeChoices = CurrenciesHolder.Currencies.getSubset(true)
        foreignChoices = CurrenciesHolder.Currencies.getSubset(false)
        homeChoicePicker.reloadAllComponents()
        foreignChoicePicker.reloadAllComponents()
        if(homeChoicePicker.selectedRow(inComponent:0) < homeChoices.count) {
            homeSymLabel.text = homeChoices[homeChoicePicker.selectedRow(inComponent:0)].symbol
        }
        if(foreignChoicePicker.selectedRow(inComponent:0) < foreignChoices.count) {
            foreignSymLabel.text = foreignChoices[foreignChoicePicker.selectedRow(inComponent:0)].symbol
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow: Int, inComponent: Int) {
        if(pickerView == homeChoicePicker && didSelectRow < homeChoices.count) {
            homeSymLabel.text = homeChoices[didSelectRow].symbol
        }
        else if(pickerView == foreignChoicePicker && didSelectRow < foreignChoices.count) {
            foreignSymLabel.text = foreignChoices[didSelectRow].symbol
        }
        sendQuery()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == homeChoicePicker {
            return homeChoices.count
        }
        else if pickerView == foreignChoicePicker {
            return foreignChoices.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == homeChoicePicker {
            return homeChoices[row].symbol
        }
        else if pickerView == foreignChoicePicker {
            return foreignChoices[row].symbol
        }
        return nil
    }
}

