//
//  TitleDetailCell.swift
//  Pet
//
//  Created by Kai on 2022/8/04.
//

import Foundation
import UIKit

class TitleDetailCellRowModel : CellRowModel {
    
    override func cellID() -> String {
        return "TitleDetailCell"
    }
    
    var title: String? = ""
    var detail: String? = ""
    
    init(
        title : String? = "",
        detail :String? = "",
        cellAction:((CellRowModel)->())?
        ){
            super.init()
            self.title = title
            self.detail = detail
            self.cellAction = cellAction
        }
}


//MARK: - TitleDetailCell的兩個Label
    class TitleDetailCell : UITableViewCell{
        @IBOutlet weak var titleLabel: UILabel!
        
        @IBOutlet weak var detailLabel: UILabel!
        
    }

//MARK: - 第一個畫面可篩選初始化的畫面
extension TitleDetailCell: CellViewBase {
    func setupCellView(rowModel: CellRowModel) {
        guard let rowModel = rowModel as? TitleDetailCellRowModel else { return }
        self.titleLabel.text = rowModel.title
        self.detailLabel.text = rowModel.detail
    }
}

