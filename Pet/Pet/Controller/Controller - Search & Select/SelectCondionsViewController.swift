//
//  SelectCondionsViewController.swift
//  Pet
//
//  Created by Kai on 2022/8/04.
//

import Foundation
import UIKit

class SelectCondionsViewController: DefaultTableViewController {
    
    var dataSource: [ String ] = []
    
    var selectedArray: [ String ] = []
    
    var confirmAction: (([String])->())?
    
    override func viewDidLoad() {
        
        self.setCellIDs(cellIDs: [
            SelectConditionsCell.self
        ])
        
        super.viewDidLoad()
        self.setupRow()
    }
    
    //MARK: - setupRow是(點篩選的row-性別.地區.種類)
    
    func setupRow() {
        var rowModels: [CellRowModel] = []
        for data in self.dataSource {
            let conditionsRow = SelectConditionsCellRowModel(text: data,
                                                             isSelect: self.selectedArray.contains(data)) { rowModel in
                guard let rowModel = rowModel as? SelectConditionsCellRowModel else { return }
                
//                if self.selectedArray.contains(rowModel.text) {
//                    self.selectedArray = self.selectedArray.filter({ str in
//                        str != rowModel.text
//                    })
//                } else {
//                    self.selectedArray.append(rowModel.text)
//                }
                self.selectedArray.removeAll()
                self.selectedArray.append(rowModel.text)
                
                self.setupRow()
            }
            rowModels.append(conditionsRow)
        }
        self.adapter?.updateData(rowModels: rowModels)
    }
    
    
    //MARK: - 設定篩選的下面button-OK(點篩選的button)
    override func setBottomButton() {
            
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("確認", for: .normal)
            button.backgroundColor = .green
            button.setTitleColor(.black, for: .normal)
            self.view.addSubview(button)
            button.topAnchor.constraint(equalTo: self.defaultTableView.bottomAnchor,constant: 10).isActive = true
            button.centerXAnchor.constraint(equalTo: self.defaultTableView.centerXAnchor).isActive = true
            
            button.addTarget(self, action: #selector(bottomButtonAction), for: .touchUpInside)
    }
    
    //MARK: - 不太懂
    @objc override func bottomButtonAction() {
        if let confirmAction = self.confirmAction {
            confirmAction(self.selectedArray)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}
