//
//  Untitled.swift
//  StandfordSwiftUI
//
//  Created by Guilherme Prata Costa on 13/03/25.
//
import SwiftUI

public protocol StyleProtocol: DynamicProperty, Sendable {
    associatedtype Configuration
    associatedtype Body: View
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> Body
}
