//
//  QuartzCanvasView.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/28.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class QuartzCanvasView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    let PI:CGFloat = 3.14159265358979323846
    
    
    var  _center:CGPoint
    var  offestCenter:CGPoint? {
        didSet {
            let originX = _center.x + (offestCenter?.x)!;
            let originY = _center.y + (offestCenter?.y)!;
            _center = CGPoint(x: originX, y: originY)
            
            // [self setNeedsDisplay];
        }
    }
    var minimumRoundRadius:CGFloat = 30.0;
    var strokeColor = UIColor.white
    
    override init(frame:CGRect) {
        
        let centerX = frame.size.width * 0.5;
        let centerY = frame.size.height * 0.5 - 5;
        _center = CGPoint(x: centerX, y: centerY)
        
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect:CGRect) -> Void {
        
        // Drawing code
        let ctx = UIGraphicsGetCurrentContext();
    
        ctx!.setStrokeColor(self.strokeColor.cgColor);//画笔线的颜色
        ctx!.setLineWidth(1.0);//线的宽度
        
        self.drawRoundWithContextRef(ctx: ctx!)
        self.addAnimations()
      
    }
    
    func addAnimations() -> Void {
        
        var changeRadius = self.minimumRoundRadius;
        let standardRadius:CGFloat = max(self.bounds.width, self.bounds.height) * 0.5
       
        let center = _center;
        var reverses = true
        
        while changeRadius < standardRadius {
            
            let aLayer = self.templateLayer()
            self.layer.addSublayer(aLayer)
            
            /** core Graphics 创建路径 */
            let path = CGMutablePath.init()
            path.addEllipse(in: CGRect(x: center.x - changeRadius, y: center.y - changeRadius, width: changeRadius * 2, height: changeRadius * 2))
            
            aLayer.add(self.getKeyframeAnimationWithPath(path: path, reverses: reverses), forKey: "PostionKeyframeValueAni")
            
            changeRadius = changeRadius + 40;
            reverses = !reverses
        }
    }
    
    //画圆
    func drawRoundWithContextRef(ctx:CGContext) -> Void {
        
        let center = _center;
        /** 从最内层圆开始绘制 */
        
        let standardRadius:CGFloat = max(self.bounds.width, self.bounds.height) * 0.5
        
        var radius = self.minimumRoundRadius
        
        while radius < standardRadius {
            ctx.addArc(center: center, radius: CGFloat(radius), startAngle: 0, endAngle: 2 * PI, clockwise: false)
            
            ctx.drawPath(using: CGPathDrawingMode.stroke);
            radius += 40
        }
        
    }
    
    func getKeyframeAnimationWithPath(path:CGMutablePath,reverses:Bool) -> CAKeyframeAnimation {
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath:"position") //
        keyFrameAnimation.repeatCount = MAXFLOAT;
        keyFrameAnimation.repeatDuration = CFTimeInterval(MAXFLOAT);
        //        keyFrameAnimation.autoreverses = YES;//翻转动画
       
        keyFrameAnimation.calculationMode = kCAAnimationPaced;
        keyFrameAnimation.rotationMode = kCAAnimationRotateAuto;
        keyFrameAnimation.isRemovedOnCompletion = false;
         keyFrameAnimation.duration = 5;
        
        keyFrameAnimation.path = path;
        keyFrameAnimation.speed = 0.2;
        if (reverses) {
            keyFrameAnimation.speed = -keyFrameAnimation.speed;
        }
       
        
        return keyFrameAnimation;
    }
    
    
    func templateLayer() -> CALayer {
        
        let layer = CALayer()
        layer.backgroundColor = self.strokeColor.cgColor;
        let layerSize = CGFloat((arc4random() % 4) + 8);
        
        layer.frame =  CGRect(x: 0, y: 0, width: layerSize, height: layerSize)
        layer.cornerRadius = 5;
        return layer;
    }
}
