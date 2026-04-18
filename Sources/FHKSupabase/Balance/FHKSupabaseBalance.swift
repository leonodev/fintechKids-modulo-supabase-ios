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
    
    public func fetchBalance(memberId: UUID
    ) async throws -> FHKDomain.BalanceEntity {
        let balances: [BalanceDto] = try await supabaseClient
            .from(DB.TABLE_BALANCE.NAME)
            .select()
            .eq(DB.TABLE_BALANCE.COLUMN.memberId, value: memberId)
            .execute()
            .value
        
        guard let balance = balances.first else {
            throw FHKSupabaseError.unknown("Error unknown")
        }
        
        return balance.toDomain()
    }
    
    public func updateKidsCoinsBalance(memberId: UUID, infoBalance: BalanceKidsCoinsEntity) async throws {
        do {
            let coinsParams = CoinsRewardsParams(
                target_member_id: memberId,
                new_coins: infoBalance.coinsObtained
            )
            
            let response = try await supabaseClient.rpc(
                DB.TABLE_BALANCE.FUNCTION_RPC.updateCoinsBalance,
                params: coinsParams
            ).execute()
            
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
    
    public func updateTimeBalance(memberId: UUID, infoBalance: BalanceTimeEntity) async throws {
        do {
            let timeParams = TimeRewardsParams(
                target_member_id: memberId,
                new_time_string: infoBalance.timeObtained
            )
            
            let response = try await supabaseClient.rpc(
                DB.TABLE_BALANCE.FUNCTION_RPC.updateTimeBalance,
                params: timeParams
            ).execute()
            
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
    
    public func sendGoldenTicket(data: GoldenTicketParamsEntity) async throws {
        do {
            // .invoke busca la función por el nombre con el que la desplegaste
            let response: ResendResponse = try await supabaseClient.functions
                .invoke(
                    "resend-email", // Nombre exacto en Supabase
                    options: FunctionInvokeOptions(body: data)
                )
            
            if let emailId = response.id {
                print("✅ Ticket enviado con éxito. ID de Resend: \(emailId)")
            }
            
        } catch {
            // Lanzamos el error para que el ViewModel pueda capturarlo
            // y mostrar una alerta si es necesario.
            print("❌ Error al enviar el Ticket Dorado: \(error)")
            throw error
        }
    }
}
