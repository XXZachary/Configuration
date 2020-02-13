//
//  LoginViewController.swift
//  车愿
//
//  Created by Zachary on 2018/11/20.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

class LoginViewController: XXZViewController {
    
    var loginSuccessBlock:(()->Void)?
    let login = UIButton.init(type: .custom)

    //MARK: ------ Zachary - init ------
    init() {
        super.init(nibName: nil, bundle: nil)
        //coding...
        self.needHiddenBackButton = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ------ Zachary - view will appear & disappear ------
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //coding...
        self.navigationController?.alphaImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //coding...
        self.navigationController?.shadowImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //coding...
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //coding...
        
    }
    
    //MARK: ------ Zachary - view did load ------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = whiteColor
        self.navigationItem.title = ""
        
        buildLayout()
    }
    
    //MARK: ------ Zachary - <#delegate#> ------
    
    
    //MARK: ------ Zachary - action ------
    @objc func loginAction() {
        XCurrentUserInfo.shareInstance.cmUserId = "xxz"
        XCurrentUserInfo.shareInstance.cmUserName = "Xavier Zachary"
        XCurrentUserInfo.shareInstance.saveUserInfo()
        
        let hint = XXZHintView.showInView("", self.view)
        DispatchQueue.global().async {
            
            sleep(2)
            
            DispatchQueue.main.async {
                hint.hideAfter()
                
                XXZHintView.showNoInView("登录成功", self.view)
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    self.loginSuccess()
                }
                
            }
            
        }
    }
    
    @objc func loginSuccess() {
        
        if loginSuccessBlock != nil {
            loginSuccessBlock!()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func leftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: ------ Zachary - build layout ------
    func buildLayout() {
        loadLeftItem()
        loadLogin()
    }
    
    //MARK: ------ Zachary - loading ------
    func loadLeftItem() {
        let left = UIButton.init(type: .custom)
        left.frame = CGRect.init(x: 0, y: 0, width: 25, height: 44)
        left.contentHorizontalAlignment = .left
        left.setImage(UIImage.init(named: "close_black"), for: .normal)
        left.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        //        left.backgroundColor = cyanColor
        
        let leftItem = UIBarButtonItem.init(customView: left)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func loadLogin() {
        login.titleLabel?.font = FONT_M(18)
        login.setTitle("登 录", for: .normal)
        login.setTitleColor(DARK_COLOR, for: .normal)
        login.setBackgroundImage(UIImage.init(named: "bottom_back"), for: .normal)
        login.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.view.addSubview(login)
        
        login.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
            make.size.equalTo(CGSize.init(width: SCREEN_WIDTH-15*2, height: 51))
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
