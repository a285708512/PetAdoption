//
//  PetTableViewController.swift
//  Pet
//
//  Created by Kai on 2022/7/11.
//

import UIKit
import SDWebImage

class PetTableViewController: DefaultTableViewController {
    
    var conditions: SearchConditions?
    
    var petList:[ PetModel ] = []
    
    var petType: PetType = .dog
    
    
    var loveList: [ PetModel ] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.regisCell(cellIDs: [
            "PetTableViewCell"
        ])
        
        NetworkService.downloadJson() { result in
            switch result {
            case .success(let data):
                self.petList = data
                self.setupRow()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func filterList(list: [ PetModel ] = []) -> [PetModel] {
        guard let conditions = conditions else {
            return list
        }

        var filterList = list.filter { model in
            let address = model.shelterAddress ?? ""
            let area = address.prefix(3)
            return String(area) == conditions.area
        }
        
        filterList = filterList.filter({ model in
            model.animalSex == conditions.sex
        })
        
        filterList = filterList.filter({ model in
            model.animalKind == conditions.kind
        })
        
        return filterList
    }
    
    //MARK: - 分享的按鈕寫法

    func showShareVC(petVariety: String = "",petImage: UIImage = UIImage()) {
        let activityVC = UIActivityViewController(activityItems: [petVariety,petImage],
                                                  applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }




    //MARK: - 一個cell將會出現什麼樣的資料 & shareButton的分享功能 & cellAction是會進到下一個頁面
    
    func setupRow() {
        var rowModels: [CellRowModel] = []
        self.getLoveList()
        //先把getLoveList初始化
        
        for pet in self.filterList(list: self.petList) {
            rowModels.append(PetTableViewCellRowModel(title: pet.animalVariety,
                                                      petModel: pet,
                                                      imageURLStr: pet.albumFile,
                                                      sex:pet.animalSex,
                                                      isLove: self.loveList.contains(pet),
                                                      shareButtonAtion: { image in
                
                self.showShareVC(petVariety: pet.animalVariety ?? "", petImage: image )
            },
                                                      loveButtonAction: { petModel in
                if self.loveList.contains(petModel){
                    let tempList = self.loveList.filter({ petModel1 in
                        petModel1 != petModel
                    })
                    self.loveList = tempList
                } else {
                    self.loveList.append(petModel)
                }
                self.setLoveList()
                self.setupRow()
            },
                                                      cellAction: { rowModel in
                guard let rowModel = rowModel as? PetTableViewCellRowModel else { return }
                if let petModel = rowModel.petModel {
                    self.gotoNextVC(pet: petModel)
                }
                
            }
          ))
        }
        self.adapter?.updateData(rowModels: rowModels)
    }
    
    //MARK: - 使用UserDefault儲存資料(lovebutton)
    
    //此function是獲得loveList的array
    
    func getLoveList() {
        if let petData = UserDefaults.standard.object(forKey: "pet") as? Data {
            if let loadedPets = try? JSONDecoder().decode([PetModel].self, from: petData)
            //第100行是撈取PetModel的資料，來自於自定義的petData(從UserDefault獲取data)
            {
                self.loveList  = loadedPets
            }
        }
    }
    
    //此function是將資料存到userDefault然後轉為data檔
    //JSONEncode:用JSON進行編碼，該類型要用Codable
    //encoder:提供的值進行編碼出現問題，此方法會根據問題類型引發錯誤
    //(self.loveList) -> 撈loveList的陣列，第21行為[PetModel]的array
    func setLoveList() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.loveList) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "pet")
            
        }
    }
    //MARK: - 當user點選特定cell會進到下一個PetViewController
    
    func gotoNextVC(pet: PetModel) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PetViewController") as? PetViewController {
            vc.pet = pet
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

