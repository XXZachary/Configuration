//
//  XZTableViewCell.swift
//  Swift_5.1_Learning
//
//  Created by Slife on 2019/8/16.
//  Copyright © 2019 Zachary. All rights reserved.
//

import UIKit

class XZTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildSuperLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ------ Zachary - <#delegate#> ------
    
    
    //MARK: - ------ Zachary - action ------
    
    
    //MARK: - ------ Zachary - build layout ------
    func buildSuperLayout() {
        loadRightArrow()
    }
    
    //MARK: - ------ Zachary - loading ------
    let right = UIImageView.init(frame: .init(x: 0, y: 0, width: 25, height: 25))
    func loadRightArrow() {
//        right.backgroundColor = cyanColor
        right.contentMode = .center
        right.image = UIImage.init(named: "arrow_right_black")
    }
    
    //MARK: - ------ Zachary - method ------
    
    
    //MARK: - ------ Zachary - server ------
    
    
    //MARK: - ------ Zachary - setter & getter ------
    override var accessoryType: UITableViewCell.AccessoryType {
        willSet {
            if newValue==UITableViewCell.AccessoryType.disclosureIndicator {
                self.accessoryView = right
            }
            else {
                self.accessoryView = nil
            }
        }
        
        didSet {
            XZLog(oldValue)
        }
    }
    
    //MARK: - ------ Zachary - system ------
    
    
    //MARK: - ------ Zachary - deinit ------
    deinit {
        //coding...
        
    }
    
    //MARK: - ------ Zachary - other ------
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
