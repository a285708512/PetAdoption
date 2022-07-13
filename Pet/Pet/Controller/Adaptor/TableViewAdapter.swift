//
//  TableViewAdapter.swift
//  Pet
//
//  Created by Kai on 2022/7/13.
//

import Foundation
import UIKit

protocol CellViewBase {
    func setupCellView(rowModel: CellRowModel)
}

protocol CellRowModelBase {
    func cellID() -> String
}

class CellRowModel: CellRowModelBase {
    
    func cellID() -> String {
        return "cellID"
    }
    
    var cellAction: ((CellRowModel)->())?

}

class TableViewAdapter: NSObject {
    
    weak var tableView: UITableView?
    
    var rowModels: [CellRowModel] = []
    
    init(
        _ tableView: UITableView
    ) {
        super.init()
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    func updateData(rowModels: [CellRowModel] = [] ){
        self.rowModels = rowModels
        self.tableView?.reloadData()
    }
    
}
extension TableViewAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowModels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: rowModels[indexPath.row].cellID(), for: indexPath)
        
        if let cell = cell as? CellViewBase {
            cell.setupCellView(rowModel: rowModels[indexPath.row])
        }
        
        return cell
    }
}
extension TableViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let action = rowModels[indexPath.row].cellAction {
            action(rowModels[indexPath.row])
        }
    }
}
