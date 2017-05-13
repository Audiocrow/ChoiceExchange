//
//  CurrencyData.swift
//  ChoiceExchange
//
//  Created by CampusUser on 5/1/17.
//  Copyright © 2017 Alexander Edgar. All rights reserved.
//

import Foundation

struct Currency {
    let symbol: String;
    let description: String;
    var home: Bool; //A selected/favorite home currency?
    var foreign: Bool; //A selected/favorite foreign currency?
    init(_ symbol:String, _ desc:String) {
        self.symbol=symbol;
        self.description=desc;
        home = false;
        foreign=false;
    }
}

class CurrenciesHolder {
    var available=[Currency]();
    static let Currencies = CurrenciesHolder()
    
    private init() {
        if(!load()) {
            //Defaults if loading from file failed
            available.append(Currency("USD", "American dollar"));
            available.append(Currency("EUR", "Euro"));
            available.append(Currency("JPY", "Japanese Yen"));
        }
    }
    
    private func load()->Bool {
        if let path = try? FileManager.default.url(for:.documentDirectory, in:.userDomainMask, appropriateFor:nil, create:false).appendingPathComponent("choice_exchange_userdata.json")
        {
                do {
                        let data = try Data(contentsOf: path, options: .mappedIfSafe)
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let currencies = json as? [String: Any] {
                            for (symbol, currencyData) in currencies {
                                if let currencyDict = currencyData as? [String: Any] {
                                    var currency = Currency(symbol, currencyDict["Description"] as! String)
                                    currency.home = currencyDict["Home"] as! Bool
                                    currency.foreign = currencyDict["Foreign"] as! Bool
                                    available.append(currency)
                                }
                            }
                        }
                        return true
                }
                catch let error {
                    print(error.localizedDescription)
                    return false
                }
        }
        return false
    }
    func save() {
        if let path = try? FileManager.default.url(for:.documentDirectory, in:.userDomainMask, appropriateFor:nil, create:true).appendingPathComponent("choice_exchange_userdata.json")
        {
            var data:[String:Any]=[:]
            for currency in available {
                data[currency.symbol] = [
                    "Description": currency.description,
                    "Home": currency.home,
                    "Foreign": currency.foreign
                ]
            }
            do {
                let json = try JSONSerialization.data(withJSONObject: data, options: [])
                try json.write(to: path, options: [])
                print(String(data: json, encoding: String.Encoding.utf8)!)
            }
            catch let error { print(error.localizedDescription) }
        }
    }
}
