//
//  API+AltStoreApps.swift
//  appdb
//
//  Created by ChatGPT on 2024-07-??.
//

import Alamofire

extension API {

    static func getOfficialAltStoreApps(success: @escaping (_ items: [OfficialAltStoreApp]) -> Void, fail: @escaping (_ error: String) -> Void) {
        AF.request(endpoint + Actions.getAltStoreOfficialApps.rawValue,
                   parameters: ["lang": languageCode],
                   headers: headers)
            .responseArray(keyPath: "data") { (response: AFDataResponse<[OfficialAltStoreApp]>) in
                switch response.result {
                case .success(let apps):
                    success(apps)
                case .failure(let error):
                    fail(error.localizedDescription)
                }
            }
    }

    static func getAltStoreRepoApps(repoId: String, success: @escaping (_ items: [RepoAltStoreApp]) -> Void, fail: @escaping (_ error: String) -> Void) {
        AF.request(endpoint + Actions.getAltStoreRepoApps.rawValue,
                   parameters: ["id": repoId, "lang": languageCode],
                   headers: headers)
            .responseArray(keyPath: "data") { (response: AFDataResponse<[RepoAltStoreApp]>) in
                switch response.result {
                case .success(let apps):
                    success(apps)
                case .failure(let error):
                    fail(error.localizedDescription)
                }
            }
    }

    static func getUserAltStoreApps(success: @escaping (_ items: [UserAltStoreApp]) -> Void, fail: @escaping (_ error: String) -> Void) {
        AF.request(endpoint + Actions.getAltStoreUserApps.rawValue,
                   parameters: ["lang": languageCode],
                   headers: headersWithCookie)
            .responseArray(keyPath: "data") { (response: AFDataResponse<[UserAltStoreApp]>) in
                switch response.result {
                case .success(let apps):
                    success(apps)
                case .failure(let error):
                    fail(error.localizedDescription)
                }
            }
    }
}

