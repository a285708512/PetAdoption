//
//  PetTableViewController.swift
//  Pet
//
//  Created by Kai on 2022/7/11.
//

import UIKit
import SDWebImage

class PetTableViewController: UIViewController {

    @IBOutlet weak  var mTableView: UITableView!
    
    var petList:[PetModel] = []
    
    var petType: PetType = .dog
    
    var adapter: TableViewAdapter?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adapter = .init(mTableView)
        
        let nib = UINib(nibName: "PetTableViewCell", bundle: nil)
        mTableView.register(nib, forCellReuseIdentifier: "PetTableViewCell")
        
        NetworkService.downloadJson(type: petType) { result in
            switch result {
            case .success(let data):
                self.petList = data
                self.setupRow()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func showShareVC(petVariety: String = "",petImage: UIImage = UIImage()) {
        let activityVC = UIActivityViewController(activityItems: [petVariety,petImage],
                                                  applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    func setupRow() {
        var rowModels: [CellRowModel] = []
        for pet in self.petList {
            rowModels.append(PetTableViewCellRowModel(title: pet.animalVariety,
                                                      petModel: pet,
                                                      imageURLStr: pet.albumFile,
                                                      sex:pet.animalSex,
                                                      shareButtonAtion: { image in
                
                self.showShareVC(petVariety: pet.animalVariety ?? "", petImage: image )
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
    
    func gotoNextVC(pet: PetModel) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PetViewController") as? PetViewController {
            vc.pet = pet
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}


