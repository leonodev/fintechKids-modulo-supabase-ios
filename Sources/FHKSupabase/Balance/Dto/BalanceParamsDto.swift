//
//  BalanceParamsDto.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 14/4/26.
//

import Foundation

struct TimeRewardsParams: Encodable {
    let target_member_id: UUID
    let new_time_string: String
}

struct CoinsRewardsParams: Encodable {
    let target_member_id: UUID
    let new_coins: Int
}
