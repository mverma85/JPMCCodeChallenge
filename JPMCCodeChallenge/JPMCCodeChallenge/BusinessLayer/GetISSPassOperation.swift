//
//  GetISSPassOperation.swift
//  JPMCCodeChallenge
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import Foundation

class GetISSPassOperation: ISSOperation {
    var lat: String
    var lon: String

    fileprivate let handler: ((_ inner: () throws -> ([ISSPass]?)) -> Void)
    
    init(lat: String, lon: String, handler: @escaping (_ inner: () throws -> ([ISSPass]?)) -> Void) {
        self.lat = lat
        self.lon = lon
        self.handler = handler
        super.init()
        self.name = "GetISSPassOperation"
    }
    
    // download json and parse using swift JSONDecoder
    override func execute() {
        var dataTask: URLSessionDataTask?
        if var urlComponents = URLComponents(string: "http://api.open-notify.org/iss-pass.json") {
            urlComponents.query = "lat=\(lat)&lon=\(lon)"
            guard let url = urlComponents.url else { return }
            dataTask = URLSession(configuration: .default).dataTask(with: url) { data, response, error in
                defer { dataTask = nil }
                if let error = error {
                    self.handler({ throw error })
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.parseJSON(data)
                }
            }
            dataTask?.resume()
        }
    }
    
    // parse json using JSONDecoder
    func parseJSON(_ data: Data) {
        do {
            let decoder = JSONDecoder()
            let decodedData: ISSPassResponse = try decoder.decode(ISSPassResponse.self, from: data)
            let issPass = decodedData.response
            self.handler({ issPass })
        } catch let decoderError {
            self.handler({ throw decoderError })
            debugPrint(decoderError)
        }
    }
    
}
