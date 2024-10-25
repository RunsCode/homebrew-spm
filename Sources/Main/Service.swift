//
//  Service.swift
//
//
//  Created by 王亚军 on 2024/9/18.
//

import Foundation
import XcodeProj
import PathKit

struct Service {
    
    let path: String
    let package: PackageModel
    
    public func excute() {
        
//        print("package name \(package.name)")
        
        let projectPath = Path(path)
        guard let xcodeproj = try? XcodeProj(path: projectPath) else {
            Log.red("SPM: project path: \(path) is invaild")
            exit(1)
        }
        defer {
            let name = xcodeproj.pbxproj.rootObject?.name ?? ""
            do {
                try xcodeproj.write(path: projectPath)
                Log.green("SPM: Project:\(name) Save Done!")
            } catch {
                Log.green("SPM: Project:\(name) Save Error: \(error)")
            }
        }
        
        xcodeproj.pbxproj.projects.forEach { obj in
            
//            print("Project::\(obj.name) spm count:\(obj.remotePackages.count)")
//            obj.remotePackages.forEach { ref in
//                Log.yellow("Warnning: package name: \(ref.name ?? "") repositoryURL: \(ref.repositoryURL ?? "") version: \(ref.versionRequirement.debugDescription)")
//            }
            
            /// 先判断 target 是否存在
            /// 如果不存在打断执行
            let results = obj.targets.filter { $0.name == package.target }
            guard results.count > 0 else {
                Log.red("Error: SPM package target:\(package.target) is not exists")
                exit(0)
            }
            
            guard let versionRequirement = self.versionRequirement else {
                Log.red("Error: SPM package versionRequirement is wrong")
                exit(0)
            }
            
            var url = package.location
            if url.hasSuffix(".git") {
                url = String(url.dropLast(4))
            }
            let remoteRef = XCRemoteSwiftPackageReference(repositoryURL:url, versionRequirement: versionRequirement)
            /// 判断是否存在相同的 package 引用
            /// 如果存在就移除老的
            /// 再添加新的
            let refResults = obj.remotePackages.filter {
                var url = $0.repositoryURL ?? ""
                if url.hasSuffix(".git") {
                    url = String(url.dropLast(4))
                }
                return $0.name == remoteRef.name && url == remoteRef.repositoryURL //&& $0.versionRequirement == versionRequirement
            }
           
            do {
                refResults
                    .compactMap { $0.repositoryURL ?? "" }
                    .filter { !$0.isEmpty }
                    .forEach {
                        Log.yellow("Warning: SPM package \(package.name) already exists, remove it now.")
                        let res = obj.removeSwiftPackage(repositoryURL: $0, productName: package.name, targetName: package.target)
                        Log.yellow("Warning: SPM remove old package \(package.name) \(res != nil ? "success": "failure" ).")
                    }

                try obj.addSwiftPackage(repositoryURL: url, productName: package.name, versionRequirement: versionRequirement, targetName: package.target)
                Log.green("Success: SPM target:\(package.target) add package url: \(url) product: \(package.name) versionRequirement: \(versionRequirement)")
            } catch {
                Log.red("Error: SPM target:\(package.target) add package url: \(url) product: \(package.name) versionRequirement: \(versionRequirement) failure, \nReason: \(error)\nExit.")
                exit(0)
            }
        }
    }
    
    private var versionRequirement: XCRemoteSwiftPackageReference.VersionRequirement? {
        if let tag = package.tag, !tag.isEmpty {
            return XCRemoteSwiftPackageReference.VersionRequirement.exact(tag)
        }
        
        if let branch = package.branch, !branch.isEmpty {
            return XCRemoteSwiftPackageReference.VersionRequirement.branch(branch)
        }
        
        if let major = package.major, !major.isEmpty {
            return XCRemoteSwiftPackageReference.VersionRequirement.upToNextMajorVersion(major)
        }
        
        if let minor = package.minor, !minor.isEmpty {
            return XCRemoteSwiftPackageReference.VersionRequirement.upToNextMinorVersion(minor)
        }
        
        if let range = package.range, !range.isEmpty, range.contains("-") {
            let results = range.components(separatedBy: "-")
            guard let first = results.first, let last = results.last else { return nil }
            return XCRemoteSwiftPackageReference.VersionRequirement.range(from: first, to: last)
        }
        
        if let revision = package.commit, !revision.isEmpty {
            return XCRemoteSwiftPackageReference.VersionRequirement.revision(revision)
        }
        
        return nil
    }
    

}



/*
 let projectPath = Path(arguments[1])
 let xcodeproj = try XcodeProj(path: projectPath) // Opening project.
 //
 print("\(projectPath.parent())")

 */
