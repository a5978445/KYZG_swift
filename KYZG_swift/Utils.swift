//
//  Utils.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/3/2.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class Utils: NSObject {
    open class func createQRCodeFromString(string:String) -> UIImage {

        let stringData = string.data(using: String.Encoding.utf8)

        let QRFilter = CIFilter.init(name: "CIQRCodeGenerator", withInputParameters: nil)!
        QRFilter.setValue(stringData, forKey: "inputMessage")
        QRFilter.setValue("M", forKey: "inputCorrectionLevel")
    
  
    
        let scale:CGFloat = 5;
        let cgImage = CIContext.init(options: nil).createCGImage(QRFilter.outputImage!, from: (QRFilter.outputImage?.extent)!)
//    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:QRFilter.outputImage fromRect:QRFilter.outputImage.extent];
    
    //Scale the image usign CoreGraphics
        let width:CGFloat = QRFilter.outputImage!.extent.size.width * scale;
        UIGraphicsBeginImageContext(CGSize(width:width,height:width));
    let context = UIGraphicsGetCurrentContext();
    context!.interpolationQuality = CGInterpolationQuality.none;
  //  CGContextDrawImage(context, context!.boundingBoxOfClipPath, cgImage);
    context?.draw(cgImage!, in: CGRect(x: 0, y: 0, width: width, height: width))
    let image = UIGraphicsGetImageFromCurrentImageContext();
    
    //Cleaning up
    UIGraphicsEndImageContext();
  
    
    return image!;
    
    }
}
