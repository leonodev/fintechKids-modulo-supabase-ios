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
                .from(DB.TABLE_REWARDS_LIST.NAME)
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
            .from(DB.TABLE_REWARDS_LIST.NAME)
            .select()
            .eq(DB.TABLE_REWARDS_LIST.COLUMN.emailParent, value: emailParent)
            .execute()
            .value
        
        return try rewardList.toDomain()
    }
    
    public func fetchRewardCollected(parentEmail: String) async throws -> [RewardCollectedEntity] {
        do {
            let response: [RewardCollectedDto] = try await supabaseClient
                .from(DB.TABLE_REWARDS_COLLECTED.NAME)
                .select(DB.TABLE_REWARDS_COLLECTED.JOIN_FAMILY_MEMBER)
                .eq(DB.TABLE_REWARDS_COLLECTED.COLUMN.parentEmail, value: parentEmail)
                .order(DB.TABLE_REWARDS_COLLECTED.COLUMN.createdAt, ascending: false)
                .execute()
                .value

            return try response.toDomain()
        } catch {
            throw FHKSupabaseError.unknown(error.localizedDescription)
        }
    }
}
