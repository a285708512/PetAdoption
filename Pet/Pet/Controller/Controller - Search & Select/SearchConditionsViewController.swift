//
//  SearchConditionsViewController.swift
//  Pet
//
//  Created by Kai on 2022/8/04.
//

import Foundation
import UIKit

class SearchConditions {
    var sex: String = "F"
    var area: String = ""
    var kind: String = "狗"
}

class SearchConditionsViewController: DefaultTableViewController {
    
    var conditios = SearchConditions()
    
    var petList: [PetModel] = []
    
    var areas: [String] = []
    
    override func viewDidLoad() {
        self.regisCell(cellIDs: [
        "TitleDetailCell"
        ])
        super.viewDidLoad()
        self.buttonAction = {
            self.searchAction()
        }
        self.setupRow()
        
        NetworkService.downloadJson() { result in
            switch result {
            case .success(let data):
                self.petList = data
                self.filterArea()
            case .failure(let error):
                print(error)
            }
        }
    }
    //MARK: - 地區篩選的程式碼
    
    func filterArea() {
        var datas:[String] = []
        for pet in self.petList {
            let address = pet.shelterAddress ?? ""
            let area = address.prefix(3)
            //prefix->取前三個字的縣市，因為每個收容所很多不同名
            
            datas.append(String(area))
        }
        
        for data in datas {
            if !self.areas.contains(data) {
                self.areas.append(data)
            }
        }
        print(self.areas)
    }
    
    //MARK: - 有品種.性別.地區的篩選樣板
    func setupRow() {
        var rowModels: [CellRowModel] = []
        
        //品種的Row
        
        let petRow = TitleDetailCellRowModel(title: "品種",
                                             detail: self.conditios.kind,
                                             cellAction: {
            rowModel in
            let vc = SelectCondionsViewController()
            vc.confirmAction = { stringArray in
                self.conditios.kind = stringArray.first ?? ""
                self.setupRow()
            }
            vc.selectedArray = [self.conditios.kind]
            vc.dataSource = ["狗","貓"]
            self.navigationController?.pushViewController(vc, animated: true)
        })
        rowModels.append(petRow)
        
        
        //性別的Row
        
        let sexRow = TitleDetailCellRowModel(title: "性別",
                                             detail: self.conditios.sex,
                                             cellAction: {
            rowModel in
            let vc = SelectCondionsViewController()
            vc.confirmAction = { stringArray in
                self.conditios.sex = stringArray.first ?? ""
                self.setupRow()
            }
            vc.selectedArray = [self.conditios.sex]
            vc.dataSource = ["F","M"]
            self.navigationController?.pushViewController(vc, animated: true)
        })
        rowModels.append(sexRow)
        
        //
        
        let areaRow = TitleDetailCellRowModel(title: "地區",
                                             detail: self.conditios.area,
                                             cellAction: {
            rowModel in
            let vc = SelectCondionsViewController()
            vc.confirmAction = { stringArray in
                self.conditios.area = stringArray.first ?? ""
                self.setupRow()
            }
            vc.selectedArray = [self.conditios.area]
            vc.dataSource = self.areas
            self.navigationController?.pushViewController(vc, animated: true)
        })
        rowModels.append(areaRow)
        self.adapter?.updateData(rowModels: rowModels)
    }
    
    
    
    func searchAction() {
        let vc = self.storyboard?.instantiateViewController(identifier: "PetTableViewController") as? PetTableViewController
        vc?.conditions = self.conditios
        
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
}
