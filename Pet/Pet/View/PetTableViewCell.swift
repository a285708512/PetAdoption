//
//  PetTableViewCell.swift
//  Pet
//
//  Created by Kai on 2022/7/11.
//

import UIKit


//MARK: - 這一段是cellRowModel預計會出現的東西&功能
class PetTableViewCellRowModel: CellRowModel {
    
    override func cellID() -> String {
        return "PetTableViewCell"
    }
    
    var title: String? = ""
    
    var imageURLStr: String? = ""
    
    var sex:String? = ""
    
    var isLove: Bool = false
    
    var shareButtonAtion: ((UIImage)->())?
    
    var loveButtonAction: ((PetModel)->())?
    //不太懂
    
    var petModel: PetModel?
    
    init(
        title: String? = "",
        petModel: PetModel?,
        imageURLStr: String? = "",
        sex:String? = "",
        isLove: Bool = false,
        //isLove->用布林值 一開始設定為false
        shareButtonAtion: ((UIImage)->())?,
        loveButtonAction: ((PetModel)->())?,
        cellAction: ((CellRowModel)->())? = nil
    ){
        super.init()
        self.title = title
        self.petModel = petModel
        self.sex = sex
        self.isLove = isLove
        self.imageURLStr = imageURLStr
        self.shareButtonAtion = shareButtonAtion
        self.loveButtonAction = loveButtonAction
        self.cellAction = cellAction
    }
    
}


//MARK: - 這些程式碼可設定圖片.分享.最愛按鈕的功能
class PetTableViewCell: UITableViewCell {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var lovebutton: UIButton!
    
    var shareAtion: ((UIImage)->())?
    var loveAction: ((PetModel)->())?
    var rowModel: PetTableViewCellRowModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
        lovebutton.addTarget(self, action: #selector(loveButtonAction), for: .touchUpInside)

        self.myImageView.contentMode = .scaleToFill
        self.lovebutton.setTitle("🤍", for: .normal)
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
    @objc func loveButtonAction() {
        if let loveAction = loveAction ,let petModel = self.rowModel?.petModel{
            loveAction(petModel)
        }
    }
    
}

//MARK: - cell顯示所需的資料，有title & 性別 & 分享按鈕 & 照片
extension PetTableViewCell: CellViewBase{
    
    func setupCellView(rowModel: CellRowModel) {
        
        guard let rowModel = rowModel as? PetTableViewCellRowModel else { return }
        
        self.myLabel.text = rowModel.title
        
        self.sexLabel.text = rowModel.sex
        
        self.shareAtion = rowModel.shareButtonAtion
        
        self.loveAction = rowModel.loveButtonAction
        
        self.rowModel = rowModel
                
        self.lovebutton.setTitle(rowModel.isLove ? "❤️" : "🤍", for: .normal)
        
        self.myImageView.sd_setImage(with: URL(string: rowModel.imageURLStr ?? ""),
                                     placeholderImage:UIImage(named:"LoadingImage"),
                                     options:[.allowInvalidSSLCertificates],
                                     completed:{(image, error, cacheTRype, url)in
            print(error?.localizedDescription ?? "")
        })
        
    
    }
    
}
