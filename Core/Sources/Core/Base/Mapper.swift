//
//  Mapper.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//
import Foundation

public protocol Mapper {
    associatedtype From
    associatedtype To
    
    func transform(from this: From) -> To
}
