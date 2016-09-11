//: Playground - noun: a place where people can play

import UIKit

import Darwin


private func drawBackground(input:Double,subTitle:String)->UIImage{
    let fillCircleRadius : CGFloat = 130
    let overlayCircleRadius : CGFloat = 110
    let innerCircleRadius : CGFloat = 86

    let buttonRadius : CGFloat = 20
    let centerPoint = CGPoint(x: fillCircleRadius,y:fillCircleRadius)
    let buttonToCenterPointLength = innerCircleRadius + (overlayCircleRadius - innerCircleRadius) / 2
    let headRadius : CGFloat = (overlayCircleRadius - innerCircleRadius) / 2
    let headY : CGFloat = fillCircleRadius - buttonToCenterPointLength
    
    let size = CGSize(width: fillCircleRadius * 2, height: fillCircleRadius * 2)
    let pi:CGFloat = CGFloat(M_PI)
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    let fullCirclePath = UIBezierPath(ovalInRect: CGRect(origin: CGPointZero, size: size))
    let glucoseColor = UIColor(red: 251/255.0, green: 0, blue: 105/255.0, alpha: 1)
    glucoseColor.setFill()
    fullCirclePath.fill()
    let start = CGFloat(-1 * M_PI_2)
    let decimalInput = input
    let end = start + CGFloat(2 * M_PI * decimalInput)
    
    
    let overlayCirclePath = UIBezierPath()
    overlayCirclePath.addLineToPoint(CGPoint(x: 130, y: 30))
    overlayCirclePath.addArcWithCenter(centerPoint, radius: overlayCircleRadius, startAngle: start, endAngle: end , clockwise: true)
    overlayCirclePath.addLineToPoint(centerPoint)
    
    let overlayColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    overlayColor.setFill()
    
    
    let headPath = UIBezierPath()
    headPath.addArcWithCenter(CGPoint(x: 130,y:headY), radius: headRadius, startAngle: start, endAngle: start + 2 * pi * 0.5 , clockwise: false)
    overlayColor.setFill()
    headPath.fill()
    overlayCirclePath.fill()
    
    let lightCirclePath = UIBezierPath()
    lightCirclePath.addArcWithCenter(centerPoint, radius: overlayCircleRadius, startAngle: 0, endAngle: 2 * pi , clockwise: true)
    let lighter = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
    lighter.setFill()
    lightCirclePath.fill()
    
    let innerCirclePath = UIBezierPath()
    innerCirclePath.addArcWithCenter(centerPoint, radius: innerCircleRadius, startAngle: 0, endAngle: 2 * pi , clockwise: true)
    glucoseColor.setFill()
    innerCirclePath.fill()
    
    
    let dialButtonPath = UIBezierPath()
    let degree : CGFloat = CGFloat(input * 360 - 90)
    let dialX:CGFloat = fillCircleRadius + buttonToCenterPointLength * cos(degree * pi / 180)
    let dialY:CGFloat = fillCircleRadius + buttonToCenterPointLength * sin(degree * pi / 180)
    
    dialButtonPath.addArcWithCenter(CGPoint(x: dialX,y:dialY), radius: buttonRadius, startAngle: 0, endAngle: 2 * pi , clockwise: true)
    UIColor.whiteColor().setFill()
    dialButtonPath.fill()
    
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .Center
    
    //UIFont(name: "HelveticaNeue-Thin", size: 65)!
    let numberAttrs = [NSFontAttributeName: UIFont.systemFontOfSize(55), NSParagraphStyleAttributeName: paragraphStyle,NSForegroundColorAttributeName:UIColor.whiteColor()]
    let numberString = String(format:"%.0f",input * 450)
    numberString.drawWithRect(CGRect(x: 60,y: 80,width: 140,height: 70), options: .UsesLineFragmentOrigin, attributes: numberAttrs, context: nil)
    
    let unitAttrs = [NSFontAttributeName: UIFont.systemFontOfSize(25), NSParagraphStyleAttributeName: paragraphStyle,NSForegroundColorAttributeName:UIColor.whiteColor()]
    let unitString = subTitle
    unitString.drawWithRect(CGRect(x: 60,y: 140,width: 140,height: 50),  options: .UsesLineFragmentOrigin, attributes: unitAttrs, context: nil)
    
    let outputImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return outputImage
    
}

drawBackground(0.31,subTitle: "mg/dL")








