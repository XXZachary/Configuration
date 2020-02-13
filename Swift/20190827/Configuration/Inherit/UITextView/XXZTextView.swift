//
//  XXZTextView.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/7/18.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit

class XXZTextView: UITextView, UITextViewDelegate {

    var placeholder: XXZLabel?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        buildSuperLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //will set
    override var text: String! {
        willSet {
            if newValue.isBlank() {
                placeholder?.isHidden = false
            }
            else {
                placeholder?.isHidden = true
            }
        }
        
        didSet {
            XXZLog("oldValue = \(String(describing: oldValue))")
        }
    }
    
    override var font: UIFont? {
        willSet {
            placeholder?.font = newValue
        }
    }
    
    override var textColor: UIColor? {
        willSet {
            placeholder?.textColor = newValue?.withAlphaComponent(0.5)
        }
    }
    
    //MARK: ------ Zachary - UITextViewDelegate ------
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isBlank() {
           placeholder?.isHidden = false
        }
        else {
            placeholder?.isHidden = true
        }
    }
    
    //MARK: ------ Zachary - action ------
    
    
    //MARK: ------ Zachary - build layout ------
    func buildSuperLayout() {
        loadPlaceholder()
    }
    
    //MARK: ------ Zachary - loading ------
    func loadPlaceholder() {
        placeholder = XXZLabel.init(frame: CGRect.init(x: 5, y: 8, width: self.width-5*2, height: self.height-8*2))
        placeholder?.backgroundColor = clearColor
        placeholder?.textAlignmentType = .leftTop
        placeholder?.text = "请填写..."
        placeholder?.numberOfLines = 0
        self.addSubview(placeholder!)
    }
    
    //MARK: ------ Zachary - method ------
    
    
    //MARK: ------ Zachary - deinit ------
    deinit {
        //coding...
        
    }
    
    //MARK: ------ Zachary - other ------
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
