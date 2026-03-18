//
//  MappaleSupabaseErrors.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 18/3/26.
//

import FHKDomain

protocol SupabaseErrorProtocol {
    func mapPostgresError(_ code: String, message: String) -> FHKSupabaseError
}

/// Codes API Doc: https://www.postgresql.org/docs/current/errcodes-appendix.html
extension SupabaseErrorProtocol {
    
    func mapPostgresError(_ code: String, message: String) -> FHKSupabaseError {
        switch code {
        case "22007":
            return .dateInvalid
            
        case "23505":
            return .nameAlreadyExists
            
        case "23502":
            return .missingRequiredField
            
        default:
            // We group by class prefix
            if code.hasPrefix("08") {
                return .networkError
            }
            return .unknown(message)
        }
    }
}
