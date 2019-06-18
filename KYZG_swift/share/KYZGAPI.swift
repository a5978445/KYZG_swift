//
//  PostProvider.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/5/4.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import Foundation
import Moya



// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum KYZG {
    case news(String?)
    case imageInfo
    case tweets([String : Any])
    case login([String : Any])
}

extension KYZG: TargetType {
    public var baseURL: URL {
        return URL(string: "https://www.oschina.net/action/apiv2/")!
    }
    
    public var path: String {
        switch self {
        case .news:
            return "news"
        case .imageInfo:
            return "banner"
        case .tweets:
            return "tweets"
        case .login:
            return "login_validate"
        default:
            return ""
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var parameters: [String: Any]? {
        switch self {
        case let .news(pageToken):
            if let token = pageToken  {
                return ["pageToken" : token]
            } else {
                return nil
            }
        case .imageInfo:
            return ["catalog" : 1]
        case let .tweets(dic):
            return dic
        case let .login(dic):
            return dic
        default:
            return nil
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    public var task: Task {
        return .request
    }
    //    public var validate: Bool {
    ////        switch self {
    ////        case .news:
    ////            return true
    ////        default:
    ////            return false
    ////        }
    //        return false
    //    }
    public var sampleData: Data {
        switch self {
        case .news(_):
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .imageInfo:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .tweets(_):
            return "[{\"name\": \"Repo Name\"}]".data(using: String.Encoding.utf8)!
        case .login(_):
            return "[{\"name\": \"Repo Name\"}]".data(using: String.Encoding.utf8)!
        }
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

//MARK: - Response Handlers

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}
