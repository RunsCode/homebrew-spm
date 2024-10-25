//
//  Model.swift
//  
//
//  Created by 王亚军 on 2024/9/18.
//

import Foundation
/// - upToNextMajorVersion: The package version can be bumped up to the next major version.
/// - upToNextMinorVersion: The package version can be bumped up to the next minor version.
/// - range: The package version needs to be in the given range.
/// - exact: The package version needs to be the given version.
/// - branch: To use a specific branch of the git repository.
/// - revision: To use an specific revision of the git repository.
struct PackageModel: Codable {
    let target: String
    let name: String
    let location: String
    var tag: String?
    var branch: String?
    var major: String?
    var minor: String?
    var range: String?
    var commit: String?
    
    static func model(with jsonString: String?) -> Self? {
        guard let jsonString else { return nil }
        var model: PackageModel?
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                model = try JSONDecoder().decode(PackageModel.self, from: jsonData)
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        } else {
            print("Failed to create data from JSON string")
        }
        return model
    }
}
