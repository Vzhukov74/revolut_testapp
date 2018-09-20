//
//  NetworkTask.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 20.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation
import UIKit

class NetworkTask<T> {
    private var task: URLSessionDataTask?
    
    //for post request you can add extension (i confine myself only get requests)
    func execute(getUrl: String, uiIndication: ((_ isLoading: Bool) -> Void)? = nil, completion: (_ result: NetworkTaskResult<T>) -> Void) {
        guard let url = URL(string: getUrl) else {
            //here
            return
        }
        
        task?.cancel()
        
        task = URLSession.shared.dataTask(with: url, completionHandler: { (data, responce, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                uiIndication?(false)
            }
            
            let statusCode = (responce as? HTTPURLResponse)?.statusCode
            
            if statusCode == 200 {
                
            }
        })
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            uiIndication?(true)
        }
        
        task?.resume()
    }
}
