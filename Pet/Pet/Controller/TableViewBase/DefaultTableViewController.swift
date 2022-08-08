//
//  DefaultTableView.swift
//  Pet
//
//  Created by yihuang on 2022/7/29.
//

import Foundation
import UIKit

class DefaultTableViewController: UIViewController {
    
    let defaultTableView = UITableView()
            
    var adapter: TableViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adapter = .init(self.defaultTableView)
        self.setDefaultTableView()
        self.setBottomBar()
    }
    
    func regisCell<celltype>(cellIDs: celltype){
        if let cellIDs = cellIDs as? [String]{
            for cellID in cellIDs {
                self.defaultTableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
            }
        }
        
        if let cellIDs = cellIDs as? [UITableViewCell.Type] {
            for cellID in cellIDs {
                self.defaultTableView.register(cellID, forCellReuseIdentifier: "\(cellID.self)")
            }
        }
        
    }
    
    func setDefaultTableView() {
        self.defaultTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.defaultTableView)
        self.defaultTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.defaultTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.defaultTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.defaultTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -80.0).isActive = true
        self.defaultTableView.backgroundColor = .red
    }
    
    func creatBottomBarButton() -> [BottomBarButton] {
        return []
    }
    
    func setBottomBar() {
        
        let bottomBarStackView = BottomBarView(buttons: self.creatBottomBarButton())
        bottomBarStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomBarStackView)
        bottomBarStackView.topAnchor.constraint(equalTo: self.defaultTableView.bottomAnchor).isActive = true
        bottomBarStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomBarStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomBarStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
    }

    
    
}
