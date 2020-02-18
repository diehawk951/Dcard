//
//  DecardTableViewCell.swift
//  Dcard
//
//  Created by 梁嘉峻 on 2020/2/5.
//  Copyright © 2020 梁嘉峻. All rights reserved.
//

import UIKit

class DecardTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userTitalLabel: UILabel!
    @IBOutlet weak var titalLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var excerptLabel: UILabel!
    @IBOutlet weak var excerptImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
