//
//  GithubAPI.swift
//  SampleofAPIKit
//
//  Created by 横山新 on 2019/02/24.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import APIKit
import RxSwift

protocol GitHubRequest: Request {
    
}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        return object
    }
}

struct FetchRepositoryRequest: GitHubRequest {
    typealias Response = [Repository]
    
    var userName: String
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/users/\(self.userName)/repos"
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [Repository] {
        let decoder = JSONDecoder()
        return try decoder.decode([Repository].self, from: object as! Data)
    }
    
    // Codable用
    var dataParser: DataParser {
        return JSONDataParser()
    }
    
    // RxSwift の Observable を実装したインターフェース
    public func asObservable() -> Observable<Response> {
        return Session.rx_sendRequest(request: self)
    }
}

// Codable用パーサークラス
class JSONDataParser: APIKit.DataParser {
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        // ここではデコードせずにそのまま返す
        return data
    }
}
