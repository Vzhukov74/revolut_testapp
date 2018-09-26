//
//  NetworkTask.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 20.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation
import UIKit

class NetworkTask<T> where T: Codable {
    private var task: URLSessionDataTask?
    
    //for post request you can add extension (i confine myself only get requests)
    func execute(getUrl: String, uiIndication: ((_ isLoading: Bool) -> Void)? = nil, completion: @escaping (_ result: NetworkTaskResult<T>) -> Void) {
        guard let url = URL(string: getUrl) else {
            //i dont have logging, but here we can add logging code
            return
        }
        
        task?.cancel()
        
        task = URLSession.shared.dataTask(with: url, completionHandler: { (data, responce, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                uiIndication?(false)
            }
            
            if error != nil {
                DispatchQueue.main.async {
                    completion(.fail(error!.localizedDescription))
                }
            }
            
            let statusCode = (responce as? HTTPURLResponse)?.statusCode
            
            if statusCode == 200, data != nil {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: data!)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.fail(error.localizedDescription))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.fail("statusCode is \(String(describing: statusCode))"))
                }
            }
        })
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            uiIndication?(true)
        }
        
        task?.resume()
    }
}
