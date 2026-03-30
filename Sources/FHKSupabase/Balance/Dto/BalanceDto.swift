//
//  BalanceDto.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 30/3/26.
//

import Foundation
import FHKDomain

public struct BalanceDto: BusinessModelProtocol {
    public let member_id: UUID
    public let coins_obtained: Int
    public let time_obtained: String
}

extension BalanceDto: MappeableToDomain {
    public func toDomain() -> BalanceEntity {
        return BalanceEntity(
            memberId: self.member_id,
            coinsObtained: self.coins_obtained,
            timeObtained: self.time_obtained
        )
    }
}
