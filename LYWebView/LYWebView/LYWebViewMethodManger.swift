//
//  LYWebViewMethodManger.swift
//  LYWebView
//
//  Created by 刘洋 on 2020/2/26.
//  Copyright © 2020 佳缘. All rights reserved.
//

import UIKit
import WebKit

class LYWebViewMethodManger: NSObject {
    //存放所有注册的方法
    static var methodDic = [String:(String)->Void]()
    
    static func addMethod(name:String, method:@escaping ((String)->Void)) {
        methodDic[name] = method
    }
}

extension LYWebViewMethodManger:WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        for key in LYWebViewMethodManger.methodDic.keys {
            if key == message.name {
                if let value = (message.body as! Dictionary<String, Any>)["json"] {
                    LYWebViewMethodManger.methodDic[message.name]!(value as! String)
                }
                
            }
        }
    }
}


