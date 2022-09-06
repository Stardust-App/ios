//
//  RowndApi.swift
//  RowndSDK
//
//  Created by Matt Hamann on 8/16/22.
//

import Foundation
import Get

let rowndApi = Get.APIClient(baseURL: URL(string: Rownd.config.apiUrl))

class RowndApi {
    let client: APIClient

    init() {
        let config = APIClient.Configuration(baseURL: URL(string: Rownd.config.apiUrl), delegate: RowndApiClientDelegate())
        client = APIClient(configuration: config)
    }
}

class RowndApiClientDelegate : APIClientDelegate {
    func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        request.setValue(DEFAULT_API_USER_AGENT, forHTTPHeaderField: "User-Agent")
        request.setValue(Rownd.config.appKey, forHTTPHeaderField: "x-rownd-app-key")

        if store.state.auth.isAuthenticated, let accessToken = await Rownd.getAccessToken() {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        print("request url: \(request.url)")
    }
}