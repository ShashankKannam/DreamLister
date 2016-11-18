//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Shashank Kannam on 10/24/16.
//  Copyright © 2016 Shashank Kannam. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
