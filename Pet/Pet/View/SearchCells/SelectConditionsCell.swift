//
//  ImageTitleCell.swift
//  Pet
//
//  Created by yihuang on 2022/7/29.
//

import Foundation
import UIKit


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
    
    func drawCell(){
        
        self.selectImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.selectImageView)
        self.selectImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.selectImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.selectImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.selectImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.selectImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
        self.titleLabel.centerYAnchor.constraint(equalTo: self.selectImageView.centerYAnchor).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.selectImageView.trailingAnchor).isActive = true
    }
    override func awakeFromNib() {
        self.selectionStyle = .none
        self.selectImageView.contentMode = .center
    }
    
}

extension SelectConditionsCell: CellViewBase {
    func setupCellView(rowModel: CellRowModel) {
        guard let rowModel = rowModel as? SelectConditionsCellRowModel else { return }
        
        self.titleLabel.text = rowModel.text
        
        let selectImage: UIImage? = rowModel.isSelect ? UIImage(named: "MeAvatar") : UIImage()
        self.selectImageView.image = selectImage
    }
}
