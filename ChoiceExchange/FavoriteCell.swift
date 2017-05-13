//
//  FavoriteCellTableViewCell.swift
//  ChoiceExchange
//
//  Created by CampusUser on 5/1/17.
//  Copyright © 2017 Alexander Edgar. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var SymbolLabel: UILabel!
    @IBOutlet weak var HomeSwitch: UISwitch!
    @IBOutlet weak var ForeignSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        var view = self.superview
        while(view != nil) {
            if let table = view as? UITableView {
                if let indexPath = table.indexPath(for: self) {
                    let data = CurrenciesHolder.Currencies;
                    if(sender == HomeSwitch) {
                        data.available[indexPath.row].home = HomeSwitch.isOn;
                        if HomeSwitch.isOn { data.available[indexPath.row].foreign = false; }
                        data.save()
                    }
                    else if(sender == ForeignSwitch) {
                        data.available[indexPath.row].foreign = ForeignSwitch.isOn;
                        if ForeignSwitch.isOn { data.available[indexPath.row].home = false; }
                        data.save()
                    }
                }
                break;
            }
            else { view = view?.superview ?? nil }
        }
        if(sender == HomeSwitch && HomeSwitch.isOn && ForeignSwitch.isOn) {
            ForeignSwitch.setOn(false,animated: true);
        }
        else if(sender == ForeignSwitch && ForeignSwitch.isOn && HomeSwitch.isOn) {
            HomeSwitch.setOn(false, animated: true);
        }
    }

}
