//
//  MemberDto.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 5/3/26.
//

import Foundation
import FHKDomain

public struct MemberDto: BusinessModelProtocol {
    public let identification_uuid: UUID
    public let email_parent: String
    public let member_name: String
    public let name_family: String
    public let avatar_name: String
}

extension MemberDto: MappeableToDomain {
    public func toDomain() -> MemberEntity {
        return MemberEntity(
            id: self.identification_uuid,
            emailParent: self.email_parent,
            memberName: self.member_name,
            familyName: self.name_family,
            avatarName: self.avatar_name
        )
    }
}
