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
    var homeChoices = ["Red", "Green", "Blue"]
    @IBOutlet weak var foreignChoicePicker: UIPickerView!
    var foreignChoices = ["Orange", "Teal", "Purple"]
    //Selected Choices: homeChoice = homeChoices[homeChoicePicker.selectedRowInComponent(0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //var fileManager = FileManager()
        //var userFile = "Library/Application Support/choiceexchange"
        homeChoicePicker.dataSource = self
        homeChoicePicker.delegate = self
        foreignChoicePicker.dataSource = self
        foreignChoicePicker.delegate = self
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
            return homeChoices[row]
        }
        else if pickerView == foreignChoicePicker {
            return foreignChoices[row]
        }
        return nil
    }
}

