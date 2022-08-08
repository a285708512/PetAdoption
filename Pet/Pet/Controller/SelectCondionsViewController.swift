//
//  SelectCondionsViewController.swift
//  Pet
//
//  Created by yihuang on 2022/7/29.
//

import Foundation
import UIKit

class SelectCondionsViewController: DefaultTableViewController {
    
    var dataSource: [ String ] = []
    
    var selectedArray: [ String ] = []
    
    var confirmAction: (([String])->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.regisCell(cellIDs: [
            SelectConditionsCell.self
        ])
        self.setupRow()
    }
    
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
    
    override func creatBottomBarButton() -> [BottomBarButton] {
        let confirm: BottomBarButton = .confirm {
            if let confirmAction = self.confirmAction {
                confirmAction(self.selectedArray)
            }
            self.navigationController?.popViewController(animated: true)
        }
        return [ confirm ]
    }
 
}
