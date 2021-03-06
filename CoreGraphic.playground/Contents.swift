//: Playground - noun: a place where people can play

import UIKit

import Darwin


private func drawBackground(){
    let fillCircleRadius : CGFloat = 130
    let overlayCircleRadius : CGFloat = 110
    let innerCircleRadius : CGFloat = 86
    let centerPoint = CGPoint(x: fillCircleRadius,y:fillCircleRadius)
    let buttonToCenterPointLength = innerCircleRadius + (overlayCircleRadius - innerCircleRadius) / 2
    let headRadius : CGFloat = (overlayCircleRadius - innerCircleRadius) / 2
    let headY : CGFloat = fillCircleRadius - buttonToCenterPointLength
    let size = CGSize(width: fillCircleRadius * 2, height: fillCircleRadius * 2)
    let pi:CGFloat = CGFloat(M_PI)
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    let fullCirclePath = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: size))
    let glucoseColor = UIColor(red: 251/255.0, green: 0, blue: 105/255.0, alpha: 1)
    glucoseColor.setFill()
    fullCirclePath.fill()
    let start = CGFloat(-1 * M_PI_2)
    let decimalInput = 0.25
    let end = start + CGFloat(2 * M_PI * decimalInput)
    let overlayCirclePath = UIBezierPath()
    overlayCirclePath.addArc(withCenter: centerPoint, radius: overlayCircleRadius, startAngle: start, endAngle: end , clockwise: true)
    //overlayCirclePath.addLine(to: centerPoint)
    
    let overlayColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    overlayColor.setFill()
    let headPath = UIBezierPath()
    headPath.addArc(withCenter: CGPoint(x: 130,y:headY), radius: headRadius, startAngle: start, endAngle: start + 2 * pi * 0.5 , clockwise: false)
    headPath.fill()
    
    let lightCirclePath = UIBezierPath()
    lightCirclePath.addArc(withCenter: centerPoint, radius: overlayCircleRadius, startAngle: 0, endAngle: 2 * pi , clockwise: true)
    let lighter = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
    lighter.setFill()
    lightCirclePath.fill()
}

func drawContent(input:Double,unit:String){
    let fillCircleRadius : CGFloat = 130
    let overlayCircleRadius : CGFloat = 110
    let innerCircleRadius : CGFloat = 86
    
    let buttonRadius : CGFloat = 20
    let centerPoint = CGPoint(x: fillCircleRadius,y:fillCircleRadius)
    let buttonToCenterPointLength = innerCircleRadius + (overlayCircleRadius - innerCircleRadius) / 2
    let pi:CGFloat = CGFloat(M_PI)
    let glucoseColor = UIColor(red: 251/255.0, green: 0, blue: 105/255.0, alpha: 1)
    let start = CGFloat(-1 * M_PI_2)
    let decimalInput = input
    let end = start + CGFloat(2 * M_PI * decimalInput)
    
    
    let overlayCirclePath = UIBezierPath()
    overlayCirclePath.addArc(withCenter: centerPoint, radius: overlayCircleRadius, startAngle: start, endAngle: end , clockwise: true)
    overlayCirclePath.addLine(to: centerPoint)
    let overlayColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    overlayColor.setFill()
    overlayCirclePath.fill()
    
    
    let innerCirclePath = UIBezierPath()
    innerCirclePath.addArc(withCenter: centerPoint, radius: innerCircleRadius, startAngle: 0, endAngle: 2 * pi , clockwise: true)
    glucoseColor.setFill()
    innerCirclePath.fill()
    
    
    let dialButtonPath = UIBezierPath()
    let degree : CGFloat = CGFloat(input * 360 - 90)
    let dialX:CGFloat = fillCircleRadius + buttonToCenterPointLength * cos(degree * pi / 180)
    let dialY:CGFloat = fillCircleRadius + buttonToCenterPointLength * sin(degree * pi / 180)
    
    dialButtonPath.addArc(withCenter: CGPoint(x: dialX,y:dialY), radius: buttonRadius, startAngle: 0, endAngle: 2 * pi , clockwise: true)
    UIColor.white.setFill()
    dialButtonPath.fill()
    
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    
    //UIFont(name: "HelveticaNeue-Thin", size: 65)!
    let numberAttrs = [NSFontAttributeName: UIFont.systemFont(ofSize: 55), NSParagraphStyleAttributeName: paragraphStyle,NSForegroundColorAttributeName:UIColor.white]
    let numberString = String(format:"%.0f",input * 450)
    numberString.draw(with: CGRect(x: 60,y: 80,width: 140,height: 70), options: .usesLineFragmentOrigin, attributes: numberAttrs, context: nil)
    
    let unitAttrs = [NSFontAttributeName: UIFont.systemFont(ofSize: 25), NSParagraphStyleAttributeName: paragraphStyle,NSForegroundColorAttributeName:UIColor.white]
    let unitString = unit
    unitString.draw(with: CGRect(x: 60,y: 140,width: 140,height: 50),  options: .usesLineFragmentOrigin, attributes: unitAttrs, context: nil)
}

func getImage() -> UIImage{
    let outputImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return outputImage!
}








drawBackground()
drawContent(input: 0.2, unit: "mg/dL")
getImage()

















