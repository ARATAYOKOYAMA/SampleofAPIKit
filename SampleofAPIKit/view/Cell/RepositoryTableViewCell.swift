//
//  RepositoryTableViewCell.swift
//  SampleofAPIKit
//
//  Created by 横山新 on 2019/02/24.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    typealias Value = Repository
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private var value: Value? {
        didSet {
            if let id = value?.id {
                idLabel.text = "\(id)"
            } else {
                idLabel.text = "-"
            }
            nameLabel.text = value?.name
        }
    }
    
    func configure(_ value: Value) {
        self.value = value
    }
    
}
