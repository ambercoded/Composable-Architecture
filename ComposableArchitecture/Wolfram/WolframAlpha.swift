//
//  WolframAlpha.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import Foundation

struct WolframAlphaResult: Decodable {
  let queryresult: QueryResult

  struct QueryResult: Decodable {
    let pods: [Pod]

    struct Pod: Decodable {
      let primary: Bool?
      let subpods: [SubPod]

      struct SubPod: Decodable {
        let plaintext: String
      }
    }
  }
}


func wolframAlpha(query: String, callback: @escaping (WolframAlphaResult?) -> Void) -> Void {
  var components = URLComponents(string: "https://api.wolframalpha.com/v2/query")!
  components.queryItems = [
    URLQueryItem(name: "input", value: query),
    URLQueryItem(name: "format", value: "plaintext"),
    URLQueryItem(name: "output", value: "JSON"),
    URLQueryItem(name: "appid", value: "wolframAlphaApiKey"),
  ]

  URLSession.shared.dataTask(with: components.url(relativeTo: nil)!) { data, response, error in
    callback(
      data
        .flatMap { try? JSONDecoder().decode(WolframAlphaResult.self, from: $0) }
    )
  }
  .resume()
}


func nthPrime(_ n: Int, callback: @escaping (Int?) -> Void) -> Void {
  wolframAlpha(query: "prime \(n)") { result in
    callback(
      result
        .flatMap {
          $0.queryresult
            .pods
            .first(where: { $0.primary == .some(true) })?
            .subpods
            .first?
            .plaintext
      }
      .flatMap(Int.init)
    )
  }
}

func nthPrimeMock(_ n: Int, callback: @escaping (Int?) -> Void) -> Void {
    callback(42)
}
