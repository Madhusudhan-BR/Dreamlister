//
//  ItemCell.swift
//  DreamsCenter
//
//  Created by Madhusudhan B.R on 6/7/17.
//  Copyright © 2017 Madhusudhan. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var itemName: UILabel!
 
    func configureCell(item: Item){
        itemPrice.text = "$\(item.price)"
        details.text = item.details
        itemName.text = item.title
        itemImage.image = item.toImage?.image as? UIImage
        
    }
}
