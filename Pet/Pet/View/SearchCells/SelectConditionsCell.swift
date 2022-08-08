//
//  ImageTitleCell.swift
//  Pet
//
//  Created by Kai on 2022/8/04.
//

import Foundation
import UIKit

//狗貓的cell

class SelectConditionsCellRowModel: CellRowModel {
    
    override func cellID() -> String {
        return "SelectConditionsCell"
    }
    
    var text: String = ""
    
    var selectData: Any?
    
    var isSelect: Bool = false
    
    init(
        text: String = "",
        selectData: Any? = nil,
        isSelect: Bool = false,
        cellAction: ((CellRowModel)->())? = nil
    ) {
        super.init()
        self.text = text
        self.selectData = selectData
        self.isSelect = isSelect
        self.cellAction = cellAction
    }
}

class SelectConditionsCell: UITableViewCell {
    
    let titleLabel = UILabel()
    
    let selectImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.drawCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("我想要overried")
    }
    
    
    //MARK: - 手刻畫面，第55~71-> ImageView手刻 第73~77是Label手刻範例
    
    func drawCell(){
        
        self.selectImageView.translatesAutoresizingMaskIntoConstraints = false
        //務必要加這個，否則會有問題
        self.addSubview(self.selectImageView)
        self.selectImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //高度的佈局錨點
        self.selectImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        //寬度的佈局錨點
        self.selectImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        //一個佈局錨點，代表視圖框架的頂部邊緣。
        self.selectImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        //代表視圖框架前緣的佈局錨點。
        
        self.selectImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        //佈局錨點代表視圖框架的底部邊緣。
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
        self.titleLabel.centerYAnchor.constraint(equalTo: self.selectImageView.centerYAnchor).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.selectImageView.trailingAnchor).isActive = true
    }
    override func awakeFromNib() {
        self.selectionStyle = .none
        self.selectImageView.contentMode = .center
    }
    //controller  viewdidload的時候
    
}

//MARK: - rowModeltest 狗/貓的

extension SelectConditionsCell: CellViewBase {
    func setupCellView(rowModel: CellRowModel) {
        guard let rowModel = rowModel as? SelectConditionsCellRowModel else { return }
        
        self.titleLabel.text = rowModel.text
        
        let selectImage: UIImage? = rowModel.isSelect ? UIImage(named: "feet") : UIImage()
        self.selectImageView.image = selectImage
    }
}
