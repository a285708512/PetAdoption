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
    
    var buttonAction: (()->())?
    
    private var cellIDs: Any?
    
    var adapter: TableViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adapter = .init(self.defaultTableView)
        self.setDefaultTableView()
        self.setBottomButton()
        self.regisCell()
    }
    
    func setCellIDs<celltype>(cellIDs: celltype){
        self.cellIDs = cellIDs
    }
    
    private func regisCell(){
        if let cellIDs = cellIDs as? [String]{
            for cellID in cellIDs {
                self.defaultTableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
            }
        }
        
        if let cellIDs = cellIDs as? [UITableViewCell.Type] {
            for cellID in cellIDs {
                self.defaultTableView.register(cellID, forCellReuseIdentifier: cellID.description())
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
    
    func setBottomButton() {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("搜尋", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.darkGray, for: .normal)
        self.view.addSubview(button)
        button.topAnchor.constraint(equalTo: self.defaultTableView.bottomAnchor,constant: 10).isActive = true
        button.centerXAnchor.constraint(equalTo: self.defaultTableView.centerXAnchor).isActive = true
        
        button.addTarget(self, action: #selector(bottomButtonAction), for: .touchUpInside)
    }
    
    @objc func bottomButtonAction() {
        if let buttonAction = buttonAction {
            buttonAction()
        }
    }
    
    
}
