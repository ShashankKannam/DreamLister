//
//  tableViewTableViewCell.swift
//  DreamLister
//
//  Created by Shashank Kannam on 10/23/16.
//  Copyright © 2016 Shashank Kannam. All rights reserved.
//

import UIKit

class tableViewTableViewCell: UITableViewCell {
   
    @IBOutlet weak var thumb: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var details: UILabel!
    
    
    func configureCell(item:Item){
        title.text = item.title
        price.text = "\(item.price)"
        details.text = item.details
        thumb.image=item.toImage?.image as? UIImage
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
