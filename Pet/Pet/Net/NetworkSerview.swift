//
//  NetworkSerview.swift
//  PetAdoptionExercise
//
//  Created by Kai on 2022/7/10.
//

import Foundation
// 類別
enum PetType {
    case dog
    case cat
}
// 網路層
class NetworkService {
    static func downloadJson(completed: @escaping (Result<[PetModel], Error>)->()) {
        //type怎麼直接可以讀到
        let url = URL(string: "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&$top=20&$skip=0")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil {
                do{
                    let pets = try JSONDecoder().decode([PetModel].self, from: data!)
                    DispatchQueue.main.async {
                        completed(.success(pets))
                    }
                } catch {
                    print("我錯了")
                    }
                }
            }.resume()
        }
}

