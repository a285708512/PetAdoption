//
//  PetTableViewController.swift
//  Pet
//
//  Created by Kai on 2022/7/11.
//

import UIKit

import UIKit
import SDWebImage
class PetTableViewController: UIViewController {

    @IBOutlet weak private var mTableView: UITableView!
    
    var petList = [PetModel]()
    
    var petType: PetType = .dog

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.delegate = self
        mTableView.dataSource = self
        let nib = UINib(nibName: "PetTableViewCell", bundle: nil)
        mTableView.register(nib, forCellReuseIdentifier: "dogCell")
        
        NetworkService.downloadJson(type: petType) { result in
            switch result {
            case .success(let data):
                self.petList = data
                self.mTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension PetTableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dogCell", for: indexPath)
        as! PetTableViewCell
        
        let pet = petList[indexPath.row]
        cell.myLabel.text = pet.animalKind
        cell.myImageView.sd_setImage(with: URL(string: pet.albumFile),
        placeholderImage:UIImage(named:"LoadingImage"), options:[], completed: nil)

        
        return cell
    }
    
    
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
}

