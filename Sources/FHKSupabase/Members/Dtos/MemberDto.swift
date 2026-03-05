//
//  MemberDto.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 5/3/26.
//

import Foundation
import FHKDomain

public struct MemberDto: Codable {
    public let identification_uuid: UUID
    public let email_parent: String
    public let member_name: String
    public let avatar_name: String
    public var iconName: String = "trash"
}

public extension MemberDto {
    func toDomain() -> MemberEntity {
        return MemberEntity(
            id: self.identification_uuid,
            emailParent: self.email_parent,
            memberName: self.member_name,
            avatarName: self.avatar_name
        )
    }
}
