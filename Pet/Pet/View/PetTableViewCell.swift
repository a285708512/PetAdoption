//
//  PetTableViewCell.swift
//  Pet
//
//  Created by Kai on 2022/7/11.
//

import UIKit

class PetTableViewCellRowModel: CellRowModel {
    
    override func cellID() -> String {
        return "PetTableViewCell"
    }
    
    var title: String? = ""
    
    var imageURLStr: String? = ""
    
    var petModel: PetModel?
    
    init(
        title: String? = "",
        petModel: PetModel?,
        imageURLStr: String? = "",
        cellAction: ((CellRowModel)->())? = nil
    ){
        super.init()
        self.title = title
        self.petModel = petModel
        self.imageURLStr = imageURLStr
        self.cellAction = cellAction
    }
    
}

class PetTableViewCell: UITableViewCell {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PetTableViewCell: CellViewBase{
    
    func setupCellView(rowModel: CellRowModel) {
        
        guard let rowModel = rowModel as? PetTableViewCellRowModel else { return }
        
        self.myLabel.text = rowModel.title
        
        self.myImageView.sd_setImage(with: URL(string: rowModel.imageURLStr ?? ""),
                                     placeholderImage:UIImage(named:"LoadingImage"),
                                     options:[.allowInvalidSSLCertificates],
                                     completed:{(image, error, cacheTRype, url)in
            print(error?.localizedDescription ?? "")
        })
        
    
    }
    
}
