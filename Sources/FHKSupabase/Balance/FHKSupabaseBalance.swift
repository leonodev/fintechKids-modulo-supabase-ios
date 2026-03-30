//
//  FHKSupabaseBalance.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 30/3/26.
//

import Foundation
import Supabase
import FHKDomain
import FHKUtils
import PostgREST

public final class FHKSupabaseBalance: FHKSupabaseErrorProtocol, FHKSupabaseBalanceProtocol {
    let supabaseClient: SupabaseClient
    
    public init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    public func fetchBalance(memberId: String
    ) async throws -> FHKDomain.BalanceEntity {
        let balance: BalanceDto = try await supabaseClient
            .from(DB.TABLE_BALANCE.NAME)
            .select()
            .eq(DB.TABLE_BALANCE.COLUMN.memberId, value: memberId)
            .execute()
            .value
        
        return balance.toDomain()
    }
    
    public func updateBalance(memberId: String,
                              infoBalance: FHKDomain.BalanceEntity
    ) async throws {
        do {
            let balanceDto = try infoBalance.toDto()

            let response = try await supabaseClient
                .from(DB.TABLE_BALANCE.NAME)
                .update(balanceDto)
                .execute()
            
            if response.status >= 400 {
                throw FHKSupabaseError.unknown("Error unknown: \(response.status)")
            }
        } catch let pgError as PostgrestError {
            let code = pgError.code ?? ""
            let errorToThrow = mapPostgresError(code, message: pgError.message)
            throw errorToThrow
        } catch {
            throw FHKSupabaseError.unknown(error.localizedDescription)
        }
    }
}
