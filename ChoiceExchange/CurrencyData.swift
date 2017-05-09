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
    init?(json: [String: Any]) {
        guard let symbol = json["Symbol"] as? String,
        let description = json["Description"] as? String,
        let home = json["Home"] as? Bool,
        let foreign = json["Foreign"] as? Bool
            else { return nil }
        self.symbol = symbol;
        self.description = description;
        self.home = home;
        self.foreign = foreign;
    }
}

class CurrenciesHolder {
    var available=[Currency]();
    private init() {
        if(!load()) {
            available.append(Currency("USD", "American dollar"));
            available.append(Currency("EUR", "Euro"));
            available.append(Currency("JPY", "Japanese Yen"));
        }
    }
    func load()->Bool {
        if let path = Bundle.main.path(forResource:"userdata", ofType:"json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let currencies = json as? [String: Any] {
                    for (_, currencyData) in currencies {
                        if let dict = currencyData as? [String: Any] {
                            if let currency = Currency(json: dict) {
                                available.append(currency)
                            }
                        }
                    }
                }
                return true
            }
            catch let error {
                print("CurrenciesHolder failed to load:" + error.localizedDescription)
                return false
            }
        }
        return false
    }
    func save() {
        
    }
    static let Currencies = CurrenciesHolder()
}
