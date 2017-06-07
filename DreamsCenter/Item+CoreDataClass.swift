//
//  Item+CoreDataClass.swift
//  DreamsCenter
//
//  Created by Madhusudhan B.R on 6/7/17.
//  Copyright © 2017 Madhusudhan. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
    
}
