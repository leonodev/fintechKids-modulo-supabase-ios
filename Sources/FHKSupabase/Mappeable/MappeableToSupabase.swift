//
//  MappeableToSupabase.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 11/3/26.
//

import FHKDomain

public protocol MappeableToSupabase {
    associatedtype ModelSupabase
    func toDto() throws -> ModelSupabase
}

extension Array: MappeableToSupabase where Element: MappeableToSupabase {
    public typealias ModelSupabase = [Element.ModelSupabase]
    
    public func toDto() throws -> ModelSupabase {
        try map { try $0.toDto() }
    }
}
