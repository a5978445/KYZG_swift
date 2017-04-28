//
//  String+sha1.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/28.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit


public typealias DigestAlgorithmClosure = (_ data: UnsafePointer<UInt8>, _ dataLength: UInt32) -> [UInt8]

extension Data {
    
    public func digestBytes()->[UInt8]{
        let string = (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count)
        
        let stringLength = UInt32(self.count)
        
        let closure:DigestAlgorithmClosure = {
            var hash = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
            CC_SHA1($0, $1, &hash)
            
            return hash
        }
        
        let bytes = closure(string, stringLength)
        return bytes
    }
    
    public func digestHex()->String{
       // let digestLength = algorithm.digestLength()
        let bytes = self.digestBytes()
        var hashString: String = ""
        
        for i in 0..<Int(CC_SHA1_DIGEST_LENGTH) {
            hashString += String(format: "%02x", bytes[i])
        }
        return hashString
    }
}
