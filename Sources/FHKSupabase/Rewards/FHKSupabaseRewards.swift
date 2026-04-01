//
//  FHKSupabaseRewards.swift
//  FHKSupabase
//
//  Created by Fredy Leon on 1/4/26.
//

import Foundation
import Supabase
import FHKDomain
import FHKUtils
import PostgREST

public final class FHKSupabaseRewards: FHKSupabaseErrorProtocol, FHKSupabaseRewardsProtocol {
    let supabaseClient: SupabaseClient
    
    public init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    public func createReward(reward: RewardEntity) async throws {
        do {
            let rewardDto = try reward.toDto()

            let response = try await supabaseClient
                .from(DB.TABLE_REWARDS.NAME)
                .insert(rewardDto)
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
    
    public func fetchRewards(emailParent: String) async throws -> [RewardEntity] {
        let rewardList: [RewardDto] = try await supabaseClient
            .from(DB.TABLE_REWARDS.NAME)
            .select()
            .eq(DB.TABLE_REWARDS.COLUMN.emailParent, value: emailParent)
            .execute()
            .value
        
        return try rewardList.toDomain()
    }
}
