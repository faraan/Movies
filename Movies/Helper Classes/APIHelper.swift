//
//  APIHelper.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

/// HTTP method definitions.
///
/// See https://tools.ietf.org/html/rfc7231#section-4.3
enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}


class APIHelper: NSObject {
    
    static let shared = APIHelper()
    
    let session = URLSession(configuration: .default)
    
    func getRequest(urlString: String, completionBlock: @escaping (_ success: Bool, _ result: Any) -> ()){
        
        if let urlComponent = URLComponents.init(string: urlString){
            
            guard let url = urlComponent.url else { return }
            
            let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        completionBlock(false, error)
                    }
                     
                    else if let data = data , let response = response as? HTTPURLResponse{
                        
                        /* to parse XML data uncomment this line and import SWXMLHash
                         uncomment SWXMLHash pod in podfile to install

                        if response.statusCode == 200{
                            let xml = SWXMLHash.parse(data)

                            completionBlock(true, xml)
                        }
                         */

                        if let json = try? JSONSerialization.jsonObject(with: data, options: []){
                            
                            if response.statusCode == 200{
                                
                                completionBlock(true, json)
                            }
                        }
                    }
                }
                
            })
            dataTask.resume()
        }
    }
    
    func postRequest(urlString: String, parameters: [String: String], completionBlock: @escaping (_ success: Bool, _ result: Any) -> ()){
        
        let request = urlRequest(urlString: urlString, parameters: parameters)
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    completionBlock(false, error)
                }
                    
                else if let data = data , let response = response as? HTTPURLResponse{
                    
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []){
                        
                        if response.statusCode == 200{
                            
                            completionBlock(true, json)
                        }
                    }
                }
            }
            
            
        })
        dataTask.resume()
    }
    
    fileprivate func urlRequest(urlString: String, parameters: [String: String]) -> URLRequest {
        
        var request = URLRequest.init(url: URL(string: urlString)!)
        
        request.httpMethod = HTTPMethod.post.rawValue
        
        /*
         let json = try? JSONSerialization.data(withJSONObject: parameters, options: [])
         
         request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
         
         request.httpBody = json
         */
        
        var paramString = ""
        
        for (key, value) in parameters {
            let escapedKey =
                key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            paramString += "\(escapedKey ?? "")=\(escapedValue ?? "")&"
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = paramString.data(using: String.Encoding.utf8)
        }
        return request
    }
}
