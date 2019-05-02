//
//  API+Install.swift
//  appdb
//
//  Created by ned on 28/09/2018.
//  Copyright © 2018 ned. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension API {
    static func install(id: String, type: ItemType, completion:@escaping (_ error: String?) -> Void) {
        Alamofire.request(endpoint, parameters: ["action": Actions.install.rawValue, "type": type.rawValue, "id": id], headers: headersWithCookie)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if !json["success"].boolValue {
                        completion(json["errors"][0].stringValue)
                    } else {
                        completion(nil)
                    }
                case .failure(let error):
                    completion(error.localizedDescription)
                }
        }
    }
    
    static func requestInstallJB(plist: String, icon: String, link: String, completion:@escaping (_ error: String?) -> Void) {
        Alamofire.request(endpoint, method: .post, parameters: ["action": Actions.customInstall.rawValue, "plist": plist, "icon": icon, "link": link], headers: headersWithCookie)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if !json["success"].boolValue {
                        completion(json["errors"][0].stringValue)
                    } else {
                        completion(nil)
                    }
                case .failure(let error):
                    completion(error.localizedDescription)
                }
        }
    }
    
    static func addToMyAppstore(jobId: String, fileURL: URL, request:@escaping (_ r: Alamofire.Request) -> Void, progress:@escaping (_ fraction: Double, _ read: Int64,_ total: Int64) -> Void, completion:@escaping (_ error: String?) -> Void) {

        let parameters = [
            "action": Actions.addIpa.rawValue,
            "job_id": jobId
        ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(fileURL, withName: "ipa")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: endpoint, method: .post, headers: headersWithCookie,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress { p in
                        progress(p.fractionCompleted, p.completedUnitCount, p.totalUnitCount)
                    }
                    
                    request(upload.responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            if !json["success"].boolValue {
                                completion(json["errors"][0].stringValue)
                            } else {
                                completion(nil)
                            }
                        case .failure(let error):
                            completion(error.localizedDescription)
                        }
                    })
                    
                case .failure(let encodingError):
                     completion(encodingError.localizedDescription)
                }
        })
    }
    
    static func analyzeJob(jobId: String, completion:@escaping (_ error: String?) -> Void) {
        Alamofire.request(endpoint, parameters: ["action": Actions.analyzeIpa.rawValue], headers: headersWithCookie)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)

                    if !json["success"].boolValue {
                        completion(json["errors"][0].stringValue)
                    } else {
                        for i in 0..<json["data"].count {
                            let job = json["data"][i]
                            if job["id"].stringValue == jobId {
                                if job["status"].stringValue.contains("Success") {
                                    completion(nil)
                                } else {
                                    completion(job["status"].stringValue)
                                }
                                break
                            }
                        }
                    }
                case .failure(let error):
                    completion(error.localizedDescription)
                }
        }
    }
}
