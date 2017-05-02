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
    var favorite: Bool;
    init(_ symbol:String, _ desc:String) {
        self.symbol=symbol;
        self.description=desc;
        favorite=false;
    }
}

class CurrenciesHolder {
    var available=[Currency]();
    private init() {
        available.append(Currency("USD", "American dollar"));
        available.append(Currency("EUR", "Euro"));
        available.append(Currency("JPY", "Japanese Yen"));
    }
    static let Currencies = CurrenciesHolder()
}
