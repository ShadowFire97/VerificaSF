//
//  UserCell.swift
//  Verifica_Luca_Bonin
//
//  Created by Leo Luca Bonin on 20/11/2018.
//  Copyright © 2018 developer.llb. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet var labes: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(user : User) {
        for label in labes {
            switch label.tag {
            case 0 : label.text = user.name
                
            case 1 : label.text = user.surname
                
            case 2 : label.text = user.email
            default: break
            }
        }
    }

}
