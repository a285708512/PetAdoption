//
//  BottomBarButton.swift
//  Pet
//
//  Created by yihuang on 2022/8/8.
//

import Foundation
import UIKit

class BottomBarButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        defaultSetup()
    }
            	
    var buttonTouchupAction:(()->())?
    
    func defaultSetup() {
        self.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    static func search(action:(()->())?) -> BottomBarButton {
        let button = BottomBarButton()
        button.buttonTouchupAction = action
        button.setTitle("搜尋", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .white
        return button
    }
    
    static func confirm(action:(()->())?) -> BottomBarButton {
        let button = BottomBarButton()
        button.buttonTouchupAction = action
        button.setTitle("確定", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .white
        return button
    }
    
    @objc func buttonAction() {
        if let buttonTouchupAction = self.buttonTouchupAction {
            buttonTouchupAction()
        }
    }
}
