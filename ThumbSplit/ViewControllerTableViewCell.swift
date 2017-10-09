//
//  ViewControllerTableViewCell.swift
//  ThumbSplit
//
//  Created by Sierra on 9/26/17.
//  Copyright © 2017 Sierra. All rights reserved.
//

import UIKit
import AlamofireImage



class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var registerField: UITextField!
    
    @IBOutlet weak var icPassword: UIImageView!
    
    @IBOutlet weak var registrationViews: UIView!
    
    override func awakeFromNib() {
    super.awakeFromNib()
        
        
        
        
    }
    



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
