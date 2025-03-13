//
//  TextStyle.swift
//  StandfordSwiftUI
//
//  Created by Guilherme Prata Costa on 13/03/25.
//
import SwiftUI

public extension Text {
    @MainActor
    func textStyle(_ style: some TextStyle) -> some View {
        AnyView(
            style.resolve(
                configuration: TextStyleConfiguration(content: self)
            )
        )
    }
}

public struct AnyTextStyle: TextStyle & Sendable & Identifiable {
    public let id: UUID = .init()
    
    private let _makeBody: @Sendable (TextStyleConfiguration) -> AnyView
    
    public init <S: TextStyle>(_ style: S) {
        _makeBody = { @Sendable config in
            AnyView(style.makeBody(configuration: config))
        }
    }
    
    public func makeBody(configuration: TextStyleConfiguration) -> some View {
        _makeBody(configuration)
    }
}

public protocol TextStyle: StyleProtocol & Identifiable {
    typealias Configuration = TextStyleConfiguration
}

public struct TextStyleConfiguration {
    let content: Text
    
    init(content: Text) {
        self.content = content
    }
}


public extension TextStyle {
    @MainActor
    func resolve(configuration: Configuration) -> some View {
        ResolvedTextStyle(style: self, configuration: configuration)
    }
}


private struct ResolvedTextStyle<S: TextStyle>: View {
    let style: S
    let configuration: S.Configuration
    
    
    var body: some View {
        style.makeBody(configuration: configuration)
    }
}
