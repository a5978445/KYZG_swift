//
//  Utils.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/2.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

struct Utils {
    public static func createQRCodeFromString(string: String) -> UIImage {
        
        let stringData = string.data(using: String.Encoding.utf8)
        
        let QRFilter = CIFilter.init(name: "CIQRCodeGenerator", parameters: nil)!
        QRFilter.setValue(stringData, forKey: "inputMessage")
        QRFilter.setValue("M", forKey: "inputCorrectionLevel")
        
        
        
        let scale:CGFloat = 5;
        let cgImage = CIContext.init(options: nil).createCGImage(QRFilter.outputImage!,
                                                                 from: (QRFilter.outputImage?.extent)!)
       
        let width:CGFloat = QRFilter.outputImage!.extent.size.width * scale;
        UIGraphicsBeginImageContext(CGSize(width:width,height:width));
        let context = UIGraphicsGetCurrentContext();
        context!.interpolationQuality = CGInterpolationQuality.none;
   
        context?.draw(cgImage!, in: CGRect(x: 0, y: 0, width: width, height: width))
        let image = UIGraphicsGetImageFromCurrentImageContext();
        

        UIGraphicsEndImageContext();
        
        
        return image!;
        
    }
}
