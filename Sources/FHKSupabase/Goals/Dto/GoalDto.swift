//
//  GoalDto.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 15/3/26.
//

import Foundation
import FHKDomain

public struct GoalDto: BusinessModelProtocol {
    public let date_expiration: String
    public let name: String
    public let email_parent: String
    public let value: Int
    public let measure_type: String
    public let status: String
}

extension GoalDto: MappeableToDomain {
    public func toDomain() throws -> GoalEntity {
        return GoalEntity(
            expirationDate: self.date_expiration,
            name: self.name,
            emailParent: self.email_parent,
            value: self.value,
            measureType: self.measure_type,
            status: self.status)
    }
}
