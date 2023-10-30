//
//  PhotosModel.swift
//  Learning-Examples
//
//  Created by Karthi Rasu on 23/07/23.
//

import Foundation


struct PhotosModel : Codable {
    let created_at : String?
    let description : String?
    let urls : Urls?
    let likes : Int?
    let user : User?

    enum CodingKeys: String, CodingKey {

        case created_at = "created_at"
        case description = "description"
        case urls = "urls"
        case likes = "likes"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        urls = try values.decodeIfPresent(Urls.self, forKey: .urls)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        user = try values.decodeIfPresent(User.self, forKey: .user)
    }

}

struct Urls : Codable {
    let raw : String?
    let full : String?
    let regular : String?
    let small : String?
    let thumb : String?
    let small_s3 : String?

    enum CodingKeys: String, CodingKey {

        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
        case small_s3 = "small_s3"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        raw = try values.decodeIfPresent(String.self, forKey: .raw)
        full = try values.decodeIfPresent(String.self, forKey: .full)
        regular = try values.decodeIfPresent(String.self, forKey: .regular)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
        small_s3 = try values.decodeIfPresent(String.self, forKey: .small_s3)
    }

}

struct User : Codable {
    let name : String?
    let profile_image : Profile_image?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case profile_image = "profile_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        profile_image = try values.decodeIfPresent(Profile_image.self, forKey: .profile_image)
    }

}

struct Profile_image : Codable {
    let small : String?
    let medium : String?
    let large : String?

    enum CodingKeys: String, CodingKey {

        case small = "small"
        case medium = "medium"
        case large = "large"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        medium = try values.decodeIfPresent(String.self, forKey: .medium)
        large = try values.decodeIfPresent(String.self, forKey: .large)
    }

}
