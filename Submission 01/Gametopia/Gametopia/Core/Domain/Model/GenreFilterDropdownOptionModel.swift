//
//  GenreFilterDropdownOptionModel.swift
//  Gametopia
//
//  Created by Patricia Fiona on 21/11/22.
//

struct GenreFilterDropdownOptionModel: Hashable {
    let key: String
    let value: String

    public static func == (lhs: GenreFilterDropdownOptionModel, rhs: GenreFilterDropdownOptionModel) -> Bool {
        return lhs.key == rhs.key
    }
}
