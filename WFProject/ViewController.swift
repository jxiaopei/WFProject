//
//  ViewController.swift
//  WFProject
//
//  Created by hello on 2018/6/30.
//  Copyright © 2018年 WF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackNavigationItem()


    }
    
    func setupBackNavigationItem() {
        
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "bar_back"), for: .normal)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
    }
    
    @objc func leftBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }

}

