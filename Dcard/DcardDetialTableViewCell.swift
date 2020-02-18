//
//  DcardDetialTableViewCell.swift
//  Dcard
//
//  Created by 梁嘉峻 on 2020/2/7.
//  Copyright © 2020 梁嘉峻. All rights reserved.
//

import UIKit

class DcardDetialTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImagevView: UIImageView!
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
