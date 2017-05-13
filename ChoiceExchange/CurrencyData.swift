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
    init(_ symbol:String, _ desc:String, _ home:Bool?, _ foreign:Bool?) {
        self.symbol=symbol;
        self.description=desc;
        self.home = home ?? false;
        self.foreign = foreign ?? false;
    }
}

class CurrenciesHolder {
    var available=[Currency]();
    static let Currencies = CurrenciesHolder()
    
    //Get array of Home or Foreign currencies only
    func getSubset(_ home:Bool)->[Currency] {
        var result:[Currency] = []
        for currency in available {
            if home && currency.home { result.append(currency) }
            else if !home && currency.foreign { result.append(currency) }
        }
        return result
    }
    private init() {
        if(!load()) {
            //Defaults if loading from file failed
            print("Loading of currencies failed, using defaults instead.")
            available.append(Currency("USD", "American dollar", true, false));
            available.append(Currency("AUD", "Australian dollar", false, true))
            available.append(Currency("EUR", "Euro", true, true));
            available.append(Currency("JPY", "Japanese Yen", false, true));
            available.append(Currency("BRL", "Brazil Real", false, true))
            available.append(Currency("MXN", "Mexican Peso", false, true))
            available.append(Currency("RUB", "Russia Ruble", false, true))
            available.append(Currency("GBP", "United Kingdom Pound", true, true))
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
                                    let currency = Currency(symbol, currencyDict["Description"] as! String, currencyDict["Home"] as? Bool, currencyDict["Foreign"] as? Bool)
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
                //print(String(data: json, encoding: String.Encoding.utf8)!)
            }
            catch let error { print(error.localizedDescription) }
        }
    }
}
