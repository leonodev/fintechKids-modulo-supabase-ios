//
//  RewardDto.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 1/4/26.
//

import Foundation
import FHKDomain

public struct RewardDto: BusinessModelProtocol {
    public let created_at: String
    public let name: String
    public let time_requiered: String
    public let coins_required: Int
    public let email_parent: String
}


extension RewardDto: MappeableToDomain {
    public func toDomain() throws -> RewardEntity {
        
        return RewardEntity(
            createdAt: self.created_at,
            name: self.name,
            timeRequiered: self.time_requiered,
            coinsRequiered: self.coins_required,
            emailParent: self.email_parent)
    }
}
