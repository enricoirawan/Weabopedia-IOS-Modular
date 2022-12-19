//
//  Repository.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import Foundation
import Combine

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
