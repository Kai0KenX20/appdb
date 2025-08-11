//
//  API+Apps.swift
//  appdb
//
//  Created by ChatGPT on 2024.
//

import Alamofire
import ObjectMapper

extension API {
    /// Fetch list of official apps
    static func getOfficialApps(success: @escaping (_ apps: [OfficialApp]) -> Void,
                                fail: @escaping (_ error: String) -> Void) {
        let request = AF.request(endpoint + Actions.getOfficialApps.rawValue, headers: headers)
        quickCheckForErrors(request) { ok, hasError, _ in
            if ok {
                request.responseArray(keyPath: "data") { (response: AFDataResponse<[OfficialApp]>) in
                    switch response.result {
                    case .success(let items):
                        success(items)
                    case .failure(let error):
                        fail(error.localizedDescription)
                    }
                }
            } else {
                fail((hasError ?? "Cannot connect").localized())
            }
        }
    }

    /// Fetch list of apps from repositories
    static func getRepoApps(success: @escaping (_ apps: [RepoApp]) -> Void,
                            fail: @escaping (_ error: String) -> Void) {
        let request = AF.request(endpoint + Actions.getRepoApps.rawValue, headers: headers)
        quickCheckForErrors(request) { ok, hasError, _ in
            if ok {
                request.responseArray(keyPath: "data") { (response: AFDataResponse<[RepoApp]>) in
                    switch response.result {
                    case .success(let items):
                        success(items)
                    case .failure(let error):
                        fail(error.localizedDescription)
                    }
                }
            } else {
                fail((hasError ?? "Cannot connect").localized())
            }
        }
    }

    /// Fetch list of user uploaded apps
    static func getUserApps(success: @escaping (_ apps: [UserApp]) -> Void,
                            fail: @escaping (_ error: String) -> Void) {
        let request = AF.request(endpoint + Actions.getUserApps.rawValue, headers: headers)
        quickCheckForErrors(request) { ok, hasError, _ in
            if ok {
                request.responseArray(keyPath: "data") { (response: AFDataResponse<[UserApp]>) in
                    switch response.result {
                    case .success(let items):
                        success(items)
                    case .failure(let error):
                        fail(error.localizedDescription)
                    }
                }
            } else {
                fail((hasError ?? "Cannot connect").localized())
            }
        }
    }
}

