// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation


import Foundation
import PathKit

func * (lhs: String, rhs: Int) -> String {
    return String(repeating: lhs, count: rhs)
}

Log.default("-"*200, .bold)

let arguments = CommandLine.arguments

guard arguments.count == 3 else {
    let arg0 = Path(arguments[0]).lastComponent
    fputs("usage: \(arg0) path package_json\n", stderr)
    exit(1)
}

Log.green(arguments.description)

//for (index, argument) in arguments.enumerated() {
//    Log.green("Argument \(index): \(argument)")
//}

let projectPath = arguments[1]
guard projectPath.count > 0 else {
    Log.red("Error: SPM project psth is null")
    exit(1)
}

let json = CommandLine.arguments[2]
guard let package = PackageModel.model(with: json) else {
    Log.red("Error: SPM package json is null")
    exit(1)
}

let service = Service(path: projectPath, package: package)
service.excute()


Log.default("="*200, .bold)
//xcodeproj.pbxproj.projects.forEach { obj in
//    print("Main PBXProject:\(obj.name) spm count:\(obj.remotePackages.count)")
//    obj.remotePackages.forEach { ref in
//        print("Main \(String(describing: ref.repositoryURL)), \(ref.versionRequirement.debugDescription)")
//    }
//}




/*
 try xcodeproj.write(path: projectPath)
 podXcodeproj.pbxproj.projects.forEach { obj in
 print("Pod PBXProject:\(obj.name) spm count:\(obj.remotePackages.count)")
 obj.remotePackages.forEach { ref in
 print("Pod \(String(describing: ref.repositoryURL)), \(ref.versionRequirement.debugDescription)")
 }
 let package0 = try? obj.addSwiftPackage(repositoryURL: "https://gitee.com/runsminicode/CMCCHttpDNSKit.git", productName: "CMCCHttpDNSKit",
 versionRequirement: .exact("0.0.2"),
 targetName: "Hello")
 let package1 = try? obj.addSwiftPackage(repositoryURL: "https://gitee.com/runsminicode/CMCCHttpDNSKit.git", productName: "CMCCHttpDNSKit",
 versionRequirement: .exact("0.0.2"),
 targetName: "World")
 }
 try podXcodeproj.write(path: podsPath)
 */


/*
actor ArgumentsManager {
    let arguments = CommandLine.arguments
}
*/
//let argumentsManager = ArgumentsManager()
//
//Task {
//    let arguments = await argumentsManager.arguments
//    guard arguments.count == 3 else {
//       let arg0 = Path(CommandLine.arguments[0]).lastComponent
//       fputs("usage: \(arg0) <project>\n", stderr)
//       exit(1)
//    }
//
//    print("BEGIN! You've passed \(arguments.count) arguments.")
//
//    for (index, argument) in arguments.enumerated() {
//        print("Argument \(index): \(argument)")
//    }
//
//}
//
///*







//xcodeproj.workspace.data.children.forEach { obj in
//    print("XCWorkspaceDataElement:\(obj)")
//}

//try xcodeproj.pbxproj.rootGroup()?.children.forEach{ obj in
//    print("PBXFileElement:\(obj.name ?? "")")
//}

//print("-"*100)
//xcodeproj.pbxproj.legacyTargets.forEach { obj in
//    print("PBXLegacyTarget:\(obj.name)")
//}
//print("-"*100)
//xcodeproj.pbxproj.aggregateTargets.forEach { obj in
//    print("PBXAggregateTarget:\(obj.name)")
//}
//print("-"*100)
//xcodeproj.pbxproj.nativeTargets.forEach { obj in
//    print("PBXNativeTarget:\(obj.name)")
////    obj.addDependency(target: T##PBXTarget)
//}

//print("-"*100)
//podXcodeproj.pbxproj.aggregateTargets.forEach { obj in
//    print("Pod PBXAggregateTarget:\(obj.name)")
//}
//print("-"*100)
//podXcodeproj.pbxproj.nativeTargets.forEach { obj in
//    print("PodPBXNativeTarget:\(obj.name)")
//}
//print("-"*100)
//xcodeproj.pbxproj.targetDependencies.forEach { obj in
//    print("PBXTargetDependency:\(obj.name ?? "")")
//}
//print("-"*100)
//xcodeproj.pbxproj.frameworksBuildPhases.forEach { obj in
//    print("PBXFrameworksBuildPhase:\(obj.context ?? ""))")
//}


