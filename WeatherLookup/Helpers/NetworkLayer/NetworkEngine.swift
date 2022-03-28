//
//  NetworkEngine.swift
//  WeatherLookup
//
//  Created by Utkarsh Upadhyay (BLR GSS) on 20/03/22.
//

import Foundation

class NetworkEngine {

    class func request<T: Codable>(endPoint: EndPoints, completion: @escaping(Result<T, Error>) -> ()) {

        // Make url component
        var component = URLComponents()
        component.scheme = endPoint.scheme
        component.host = endPoint.baseURL
        component.path = endPoint.path
        component.queryItems = endPoint.parameter

        guard let url = component.url else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue

        print("URL Request : \(urlRequest)")

        // Make a url session object
        // Make task object and handle it.
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in

            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknow error")
                return
            }

            guard response != nil, let data = data else {
                return
            }

            DispatchQueue.main.async {
                if let respsnseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(respsnseObject))
                } else {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
                    completion(.failure(error))
                }
            }

        }
        // Start the task
        dataTask.resume()
    }
}
