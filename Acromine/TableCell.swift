//
//  TableCell.swift
//  Acromine
//
//  Created by YC on 3/23/17.
//
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var longFormResult: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(value:String){
        self.longFormResult.text = value
    }
}
