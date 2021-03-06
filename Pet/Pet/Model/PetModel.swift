//
//  PetModel.swift
//  Pet
//
//  Created by Kai on 2022/7/11.
//

import Foundation
struct PetModel: Codable,Equatable {

    static func == (lhs: PetModel, rhs: PetModel) -> Bool {
        return lhs.albumFile == rhs.albumFile &&
        lhs.albumUpdate == rhs.albumUpdate &&
        lhs.animalVariety == rhs.animalVariety &&
        lhs.animalAge == rhs.animalAge &&
        lhs.animalAreaPkid == rhs.animalAreaPkid &&
        lhs.animalBacterin == rhs.animalBacterin &&
        lhs.animalBodytype == rhs.animalBodytype &&
        lhs.animalCaption == rhs.animalCaption &&
        lhs.animalCloseddate == rhs.animalCloseddate &&
        lhs.animalColour == rhs.animalColour &&
        lhs.animalCreatetime == rhs.animalCreatetime &&
        lhs.animalFoundplace == rhs.animalFoundplace &&
        lhs.animalId == rhs.animalId &&
        lhs.animalKind == rhs.animalKind &&
        lhs.animalOpendate == rhs.animalOpendate &&
        lhs.animalPlace == rhs.animalPlace &&
        lhs.animalRemark == rhs.animalRemark &&
        lhs.animalSex == rhs.animalSex &&
        lhs.animalShelterPkid == rhs.animalShelterPkid &&
        lhs.animalStatus == rhs.animalStatus &&
        lhs.animalSterilization == rhs.animalSterilization &&
        lhs.animalSubid == rhs.animalSubid &&
        lhs.animalTitle == rhs.animalTitle &&
        lhs.animalUpdate == rhs.animalUpdate &&
        lhs.cDate == rhs.cDate &&
        lhs.shelterAddress == rhs.shelterAddress &&
        lhs.shelterName == rhs.shelterName &&
        lhs.shelterTel == rhs.shelterTel
        //lhr左邊的東西 rhs右邊的東西
    }
    
    let albumFile : String
    let albumUpdate : String?
    let animalVariety : String?
    let animalAge : String?
    let animalAreaPkid : Int?
    let animalBacterin : String?
    let animalBodytype : String?
    let animalCaption : String?
    let animalCloseddate : String?
    let animalColour : String?
    let animalCreatetime : String?
    let animalFoundplace : String?
    let animalId : Int?
    let animalKind : String?
    let animalOpendate : String?
    let animalPlace : String?
    let animalRemark : String?
    let animalSex : String?
    let animalShelterPkid : Int?
    let animalStatus : String?
    let animalSterilization : String?
    let animalSubid : String?
    let animalTitle : String?
    let animalUpdate : String?
    let cDate : String?
    let shelterAddress : String?
    let shelterName : String?
    let shelterTel : String?


    enum CodingKeys: String, CodingKey {
        case albumFile = "album_file"
        case albumUpdate = "album_update"
        case animalVariety = "animal_Variety"
        case animalAge = "animal_age"
        case animalAreaPkid = "animal_area_pkid"
        case animalBacterin = "animal_bacterin"
        case animalBodytype = "animal_bodytype"
        case animalCaption = "animal_caption"
        case animalCloseddate = "animal_closeddate"
        case animalColour = "animal_colour"
        case animalCreatetime = "animal_createtime"
        case animalFoundplace = "animal_foundplace"
        case animalId = "animal_id"
        case animalKind = "animal_kind"
        case animalOpendate = "animal_opendate"
        case animalPlace = "animal_place"
        case animalRemark = "animal_remark"
        case animalSex = "animal_sex"
        case animalShelterPkid = "animal_shelter_pkid"
        case animalStatus = "animal_status"
        case animalSterilization = "animal_sterilization"
        case animalSubid = "animal_subid"
        case animalTitle = "animal_title"
        case animalUpdate = "animal_update"
        case cDate = "cDate"
        case shelterAddress = "shelter_address"
        case shelterName = "shelter_name"
        case shelterTel = "shelter_tel"
    }
}
