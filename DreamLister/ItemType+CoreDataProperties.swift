//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Shashank Kannam on 10/24/16.
//  Copyright © 2016 Shashank Kannam. All rights reserved.
//

import Foundation
import CoreData
//import

extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var itemType: String?
    @NSManaged public var toItem: Item?

}
