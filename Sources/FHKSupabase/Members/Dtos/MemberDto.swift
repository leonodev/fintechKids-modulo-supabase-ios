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

public extension Array where Element == MemberDto {
    func toDomain() -> [MemberEntity] {
        return self.map { $0.toDomain() }
    }
}

extension MemberEntity {
    func toDto() -> MemberDto {
        return MemberDto(
            identification_uuid: self.id,
            email_parent: self.emailParent,
            member_name: self.memberName,
            avatar_name: self.avatarName
        )
    }
}

extension Array where Element == MemberEntity {
    func toDto() -> [MemberDto] {
        return self.map { $0.toDto() }
    }
}
