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
    
    var sex:String? = ""
    
    var shareButtonAtion: ((UIImage)->())?
    
    var petModel: PetModel?
    
    init(
        title: String? = "",
        petModel: PetModel?,
        imageURLStr: String? = "",
        sex:String? = "",
        shareButtonAtion: ((UIImage)->())?,
        cellAction: ((CellRowModel)->())? = nil
    ){
        super.init()
        self.title = title
        self.petModel = petModel
        self.sex = sex
        self.imageURLStr = imageURLStr
        self.shareButtonAtion = shareButtonAtion
        self.cellAction = cellAction
    }
    
}

class PetTableViewCell: UITableViewCell {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    var shareAtion: ((UIImage)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
        self.myImageView.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func shareButtonAction() {
        if let shareAction = shareAtion {
            shareAction(self.myImageView.image ?? UIImage())
        }
    }
    
}

extension PetTableViewCell: CellViewBase{
    
    func setupCellView(rowModel: CellRowModel) {
        
        guard let rowModel = rowModel as? PetTableViewCellRowModel else { return }
        
        self.myLabel.text = rowModel.title
        
        self.sexLabel.text = rowModel.sex
        
        self.shareAtion = rowModel.shareButtonAtion
        
        self.myImageView.sd_setImage(with: URL(string: rowModel.imageURLStr ?? ""),
                                     placeholderImage:UIImage(named:"LoadingImage"),
                                     options:[.allowInvalidSSLCertificates],
                                     completed:{(image, error, cacheTRype, url)in
            print(error?.localizedDescription ?? "")
        })
        
    
    }
    
}
