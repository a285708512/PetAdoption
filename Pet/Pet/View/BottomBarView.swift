//
//  BottomBarView.swift
//  Pet
//
//  Created by yihuang on 2022/8/8.
//

import Foundation
import UIKit

class BottomBarView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(buttons: [BottomBarButton]){
        self.init(frame: .zero)
        self.setupView(buttons: buttons)
    }
    
    func setupView(buttons: [BottomBarButton]) {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        for button in buttons {
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
        }

    }
    
}

