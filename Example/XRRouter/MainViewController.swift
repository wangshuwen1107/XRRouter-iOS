//
//  MainViewController.swift
//  XRRouter_Example
//
//  Created by 王书文 on 2020/10/13.
//  Copyright © 2020 wnwn7375@outlook.com. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {


    override func viewDidLoad() {
        self.title = "XRRouter"
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        self.view.addSubview(btn3)
        self.view.addSubview(btn4)
        self.view.addSubview(btn5)
    }


    lazy var btn1: UIButton = {
        let frame = CGRect.init(x: 40, y: 100, width: 160, height: 40)
        let btn = UIButton.init(frame: frame)
        btn.setTitle("方法调用:url传入", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor  = .blue
        btn.addTarget(self, action: #selector(labelClick1), for: .touchUpInside)
        return btn
    }()

    lazy var btn2: UIButton = {
        let frame = CGRect.init(x: 40, y: 160, width: 160, height: 40)
        let btn = UIButton.init(frame: frame)
        btn.setTitle("方法调用:本地传入", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor  = .blue
        btn.addTarget(self, action: #selector(labelClick2), for: .touchUpInside)
        return btn
    }()


    lazy var btn3: UIButton = {
        let frame = CGRect.init(x: 40, y: 220, width: 160, height: 40)
        let btn = UIButton.init(frame: frame)
        btn.setTitle("异步调用方法", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor  = .blue
        btn.addTarget(self, action: #selector(labelClick3), for: .touchUpInside)
        return btn
    }()

    lazy var btn4: UIButton = {
        let frame = CGRect.init(x: 40, y: 280, width: 160, height: 40)
        let btn = UIButton.init(frame: frame)
        btn.setTitle("打开界面", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor  = .blue
        btn.addTarget(self, action: #selector(labelClick4), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var btn5: UIButton = {
        let frame = CGRect.init(x: 40, y: 340, width: 160, height: 40)
        let btn = UIButton.init(frame: frame)
        btn.setTitle("打开界面回传", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor  = .blue
        btn.addTarget(self, action: #selector(labelClick5), for: .touchUpInside)
        return btn
    }()


    @objc func labelClick1() {
        let returnValue = XRRouter
                .share()
                .url("dc://test/getBookName?name=http%3a%2f%2fwww.baidu.com&pageNum=299999.220202&listParam=%5b%22111%22%5d&mapParam=%7b%22key%22%3a%22value%22%7d")?
                .start()
        showResultAlert(msg: String(describing: returnValue))
    }


    @objc func labelClick2() {
        let returnValue = XRRouter
                .share()
                .url("test/getBookName")?
                .param("pageNum", 2)
                .param("name", "swift")
                .param("listParam", ["123"])
                .start()
        showResultAlert(msg: String(describing: returnValue))
    }

    @objc func labelClick3() {
        XRRouter.share()
                .url("dc://test/getAsyncBook")?
                .param("name", "swift")
                .startAsync { result in
                    self.showResultAlert(msg: String(describing: result))
                }
    }

    @objc func labelClick4() {
        XRRouter.share()
                .url("dc://page/open")?
                .param("title", "普通传参")
                .start()
    }
    
    
    @objc func labelClick5() {
        XRRouter.share()
                .url("dc://page/open")?
                .param("title", "回参")
                .startAsync {result in
                    self.showResultAlert(msg: String(describing: result))
                }
    }
    
    
    func showResultAlert(msg:String){
        let alert = UIAlertController(title: "结果", message: msg, preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
