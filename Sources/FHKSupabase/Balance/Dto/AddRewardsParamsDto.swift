//
//  AddRewardsParamsDto.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 14/4/26.
//

import Foundation

struct AddRewardsParams: Encodable {
    let target_member_id: UUID
    let new_coins: Int
    let new_time_string: String
}
