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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeChoices = CurrenciesHolder.Currencies.getSubset(true)
        foreignChoices = CurrenciesHolder.Currencies.getSubset(false)
        homeChoicePicker.reloadAllComponents()
        foreignChoicePicker.reloadAllComponents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UIPickerViewDelegate
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

