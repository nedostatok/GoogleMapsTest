//
//  LocationTableViewCell.swift
//  MapKitTest
//
//  Created by User on 20.01.2021.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func customizeCell(place: Place) {
        nameLabel.text = place.name
        numberLabel.text = String(place.id)
    }
}
