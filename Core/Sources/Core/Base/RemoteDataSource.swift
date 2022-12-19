//
//  RemoteDataSource.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//
import Combine

public protocol RemoteDataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
