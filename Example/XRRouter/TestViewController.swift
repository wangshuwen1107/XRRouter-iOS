//
//  TestViewController.swift
//  XRRouter_Example
//
//  Created by 王书文 on 2020/10/10.
//  Copyright © 2020 wnwn7375@outlook.com. All rights reserved.
//

import Foundation
import UIKit

class TestViewController :UIViewController{
    
    var mTitle:String?
    var mRequestId:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.mTitle
        self.view.backgroundColor = .white
        let frame = CGRect.init(x: 20, y: 100, width: 100, height: 50)
        let centerLable = UILabel(frame: frame);
        centerLable.backgroundColor = .blue
        centerLable.text = "Test"
        centerLable.font = UIFont.systemFont(ofSize: 20)
        centerLable.textColor  = .white
        centerLable.textAlignment = .center
        self.view.addSubview(centerLable)
        
    }
       
    
    override func viewDidDisappear(_ animated: Bool) {
        print("TestViewController viewDidDisappear ")
        XRRouter.share().callback(mRequestId, ["name":"123"])
    }
    
    
}

extension TestViewController : XRRouterProtocol {
    
    static func moduleName() -> String {
        return "page"
    }
    
    static func registerMethod(_ module: XRRouterModule) {
        module.newPage { (method) in
            method.params { (param) in
                param.requestId()
                param.newParam("title", .string)
            }
            method.selector = #selector(open(requestId:title:))
        }
    }
    
    @objc func open(requestId:String,title:String) ->UIViewController{
        let vc = TestViewController()
        vc.mTitle = title
        vc.mRequestId = requestId
        return vc;
    }
}
