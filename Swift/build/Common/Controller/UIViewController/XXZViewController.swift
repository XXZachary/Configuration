//
//  XXZViewController.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/5/13.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit

class XXZViewController: UIViewController {
    
    //MARK: ------ Zachary - constant & variable ------
    var needHiddenBackButton:Bool = false //默认不隐藏自定义的返回按钮
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = whiteColor
        
        if #available(iOS 11, *) {
            UITableView.appearance().contentInsetAdjustmentBehavior = .never
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    
        buildSuperLayout()
    }
    
    //MARK: ------ Zachary - <#delegate#> ------
    
    
    //MARK: ------ Zachary - action ------
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: ------ Zachary - build layout ------
    func buildSuperLayout() {
        customBackButton()
    }
    
    //MARK: ------ Zachary - loading ------
    private func customBackButton() {
        
        if !needHiddenBackButton {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(backAction))
        }
        else {
            let back = UIBarButtonItem.init()
            back.title = ""
            self.navigationItem.leftBarButtonItem = back
        }
    }
    
    //MARK: ------ Zachary - method ------
    
    
    //MARK: ------ Zachary - server ------
    
    
    //MARK: ------ Zachary - setter & getter ------
    
    
    //MARK: ------ Zachary - system ------
    
    
    //MARK: ------ Zachary - deinit ------
    deinit {
        //coding...
        
    }
    
    //MARK: ------ Zachary - other ------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
