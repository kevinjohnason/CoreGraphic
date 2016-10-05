//: Playground - noun: a place where people can play

import UIKit

import Darwin

let pi:CGFloat = CGFloat(M_PI)

private func drawBackground(){
    let fillCircleRadius : CGFloat = 130
    let innerCircleRadius : CGFloat = 100
    let centerPoint = CGPoint(x: fillCircleRadius,y:fillCircleRadius)
    let size = CGSize(width: fillCircleRadius * 2, height: fillCircleRadius * 2)
    let pi:CGFloat = CGFloat(M_PI)
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    let fullCirclePath = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: size))
    let bottomColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    bottomColor.setFill()
    fullCirclePath.fill()

    let lightCirclePath = UIBezierPath()
    lightCirclePath.addArc(withCenter: centerPoint, radius: innerCircleRadius, startAngle: 0, endAngle: 2 * pi , clockwise: true)
    let lighter = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    lighter.setFill()
    lightCirclePath.fill()
    
    let glucoseRangeColor = UIColor(displayP3Red: 251/255.0, green: 0, blue: 105/255.0, alpha: 0.6)
    glucoseRangeColor.setStroke()
    glucoseRangeColor.setFill()
    //innerCirclePath.stroke()
    
    let outerCirclePath = UIBezierPath()
    outerCirclePath.lineWidth = 4
    outerCirclePath.addArc(withCenter: centerPoint, radius: fillCircleRadius, startAngle: 0, endAngle: 180/180  * pi , clockwise: true)
    
    
    let point = getPoint(center: centerPoint, radius: innerCircleRadius, degree: 180)
    outerCirclePath.addLine(to: point)
    outerCirclePath.move(to: point)
    outerCirclePath.addArc(withCenter: centerPoint, radius: innerCircleRadius, startAngle: 180/180 * pi, endAngle: 0, clockwise: false)
    outerCirclePath.addLine(to: getPoint(center: centerPoint, radius: fillCircleRadius, degree: 0))
    outerCirclePath.fill()
    
    let beginingHeadPath = UIBezierPath()
    let beginingCenter = getPoint(center: centerPoint, radius: innerCircleRadius + (fillCircleRadius - innerCircleRadius) / 2, degree: 0)
    beginingHeadPath.addArc(withCenter: beginingCenter, radius: (fillCircleRadius - innerCircleRadius) / 2, startAngle: pi, endAngle: 0, clockwise: true)
    beginingHeadPath.fill()
    
    
    let endingHeadPath = UIBezierPath()
    let endingCenter = getPoint(center: centerPoint, radius: innerCircleRadius + (fillCircleRadius - innerCircleRadius) / 2, degree: 180)
    endingHeadPath.addArc(withCenter: endingCenter, radius: (fillCircleRadius - innerCircleRadius) / 2, startAngle: pi, endAngle: 0, clockwise: true)
    endingHeadPath.fill()
    
    
    UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
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




func getPoint(center:CGPoint,radius:CGFloat,degree:CGFloat) -> CGPoint{
    let x:CGFloat = center.x + radius * cos(degree * pi / 180)
    let y:CGFloat = center.y + radius * sin(degree * pi / 180)
    return CGPoint(x: x, y: y)
}



drawBackground()

//drawContent(input: 0.2, unit: "mg/dL")
//getImage()

















