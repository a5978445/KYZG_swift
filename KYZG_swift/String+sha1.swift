//
//  String+sha1.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/28.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit


public typealias DigestAlgorithmClosure = (_ data: UnsafePointer<UInt8>, _ dataLength: UInt32) -> [UInt8]

extension String {
//    func sha1() -> String {
//        let data = self.data(using: String.Encoding.utf8)!
//        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
//     //   da
//        data.withUnsafeBytes {_ in 
//          //  tempData.replaceBytes(in: NSMakeRange(0, data.count), withBytes: $0)
//             CC_SHA1(data.bytes, CC_LONG(data.count), &digest)
//        }
//      //  CC_SHA1(data.bytes, CC_LONG(data.count), &digest)
//        let hexBytes = map(digest) { String(format: "%02hhx", $0) }
//        return "".join(hexBytes)
//    }
}

extension Data {
    
    public func digestBytes()->[UInt8]{
        let string = (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count)
        let stringLength = UInt32(self.count)
        
        let closure = { (_ data: UnsafePointer<UInt8>, _ dataLength: UInt32) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
            CC_SHA1(data, dataLength, &hash)
            
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
