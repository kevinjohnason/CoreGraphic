//: Playground - noun: a place where people can play

import UIKit

import Darwin

let fillCircleRadius : CGFloat = 130
let innerCircleRadius : CGFloat = 100
let centerPoint = CGPoint(x: fillCircleRadius,y:fillCircleRadius)
let size = CGSize(width: fillCircleRadius * 2, height: fillCircleRadius * 2)
let pi:CGFloat = CGFloat(M_PI)


class GlucosePoint{
    var glucoseValue:Float
    
    var angle:CGFloat {
        get{
            return CGFloat((glucoseValue / 450.0) * 360.0)
        }
    }
    
    init(value:Float){
        glucoseValue = value
        
    }
    
    lazy var pointCenter:CGPoint = {
        return self.getPoint(center: centerPoint, radius: innerCircleRadius + (fillCircleRadius - innerCircleRadius) / 2, degree: CGFloat(self.angle))
    }()
    
    let glucoseColor = UIColor(red: 251/255.0, green: 0, blue: 105/255.0, alpha: 1)
    func drawPoint(){
        glucoseColor.setFill()
        let glucosePath = UIBezierPath()
        glucosePath.addArc(withCenter: pointCenter, radius: 11, startAngle: 0, endAngle: 2 * pi, clockwise: true)
        glucosePath.fill()
    }
    
    func getPoint(center:CGPoint,radius:CGFloat,degree:CGFloat) -> CGPoint{
        let x:CGFloat = center.x + radius * cos(degree * pi / 180)
        let y:CGFloat = center.y + radius * sin(degree * pi / 180)
        return CGPoint(x: x, y: y)
    }
    
    func drawValue(){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let numberAttrs = [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSParagraphStyleAttributeName: paragraphStyle,NSForegroundColorAttributeName:UIColor.white]
        let numberString = String(format:"%.0f",glucoseValue)
        numberString.draw(with: CGRect(x: pointCenter.x - 10,y: pointCenter.y - 5,width: 20,height: 10), options: .usesLineFragmentOrigin, attributes: numberAttrs, context: nil)
    }
}


class GlucoseRange{
    let glucoseRangeColor = UIColor(displayP3Red: 251/255.0, green: 0, blue: 105/255.0, alpha: 0.6)
    var glucosePoints:[GlucosePoint]
    lazy var inRangePoints:[GlucosePoint] = {
        return  self.glucosePoints.filter { (point:GlucosePoint) -> Bool in
            return point.glucoseValue >= self.lowRange && point.glucoseValue <= self.highRange
        }
    }()
    var highRange:Float
    var lowRange:Float
    init(points:[GlucosePoint],high:Float,low:Float){
        glucosePoints = points
        highRange = high
        lowRange = low
    }
    
    var maxPoint:GlucosePoint{
        get{
            let max = glucosePoints.max { (a:GlucosePoint, b:GlucosePoint) -> Bool in
                return a.glucoseValue < b.glucoseValue
            }
            return max!
        }
    }
    
    var minPoint:GlucosePoint{
        get{
            let min = glucosePoints.min { (a:GlucosePoint, b:GlucosePoint) -> Bool in
                return a.glucoseValue < b.glucoseValue
            }
            return min!
        }
    }
    
    var maxPointInRange:GlucosePoint{
        get{
            let max = inRangePoints.max { (a:GlucosePoint, b:GlucosePoint) -> Bool in
                return a.glucoseValue < b.glucoseValue
            }
            return max!
        }
    }
    
    var minPointInRange:GlucosePoint{
        get{
            let min = inRangePoints.min { (a:GlucosePoint, b:GlucosePoint) -> Bool in
                return a.glucoseValue < b.glucoseValue
            }
            return min!
        }
    }
    
    var startAngle:CGFloat{
        return minPoint.angle
    }
    
    var endingAngel:CGFloat{
        return maxPoint.angle
    }
    
    var inRangeStartAngle:CGFloat{
        return minPointInRange.angle
    }
    
    var inRangeEndingAngle:CGFloat{
        return maxPointInRange.angle
    }
    
    func drawPoints(){
        for point in glucosePoints{
            point.drawPoint()
        }
    }
    func getPoint(center:CGPoint,radius:CGFloat,degree:CGFloat) -> CGPoint{
        let x:CGFloat = center.x + radius * cos(degree * pi / 180)
        let y:CGFloat = center.y + radius * sin(degree * pi / 180)
        return CGPoint(x: x, y: y)
    }
    
    func drawInRangeCoverage(){
        let inRangePath = UIBezierPath()
        inRangePath.lineWidth = 2
        UIColor.white.setStroke()
        inRangePath.addArc(withCenter: centerPoint, radius: innerCircleRadius, startAngle: inRangeStartAngle/180.0 * pi, endAngle: inRangeEndingAngle / 180.0 * pi, clockwise: true)
        inRangePath.move(to: getPoint(center: centerPoint, radius: fillCircleRadius, degree: inRangeStartAngle))
        inRangePath.addArc(withCenter: centerPoint, radius: fillCircleRadius , startAngle: inRangeStartAngle/180.0 * pi, endAngle: inRangeEndingAngle / 180.0 * pi, clockwise: true)
        inRangePath.stroke()
        let beginingHeadPath = UIBezierPath()
        beginingHeadPath.lineWidth = 2
        let beginingCenter = getPoint(center: centerPoint, radius: innerCircleRadius + (fillCircleRadius - innerCircleRadius) / 2, degree: inRangeStartAngle)
        beginingHeadPath.addArc(withCenter: beginingCenter, radius: (fillCircleRadius - innerCircleRadius) / 2, startAngle: (inRangeStartAngle / 180) * pi, endAngle: (inRangeStartAngle + 180) / 180 * pi, clockwise: false)
        beginingHeadPath.stroke()
        let endingHeadPath = UIBezierPath()
        endingHeadPath.lineWidth = 2
        let endingCenter = getPoint(center: centerPoint, radius: innerCircleRadius + (fillCircleRadius - innerCircleRadius) / 2, degree: inRangeEndingAngle)
        endingHeadPath.addArc(withCenter: endingCenter, radius: (fillCircleRadius - innerCircleRadius) / 2, startAngle: (inRangeEndingAngle / 180) * pi, endAngle: (inRangeEndingAngle + 180) / 180 * pi, clockwise: true)
        endingHeadPath.stroke()
    }
    
    
    func drawFullCoverage(){
        glucoseRangeColor.setFill()
        let inRangePath = UIBezierPath()
        inRangePath.lineWidth = 2
        inRangePath.addArc(withCenter: centerPoint, radius: innerCircleRadius, startAngle: startAngle/180.0 * pi, endAngle: endingAngel / 180.0 * pi, clockwise: true)
        let endingCenter = getPoint(center: centerPoint, radius: innerCircleRadius + (fillCircleRadius - innerCircleRadius) / 2, degree: endingAngel)
        inRangePath.addArc(withCenter: endingCenter, radius: (fillCircleRadius - innerCircleRadius) / 2, startAngle: (endingAngel / 180) * pi, endAngle: (endingAngel + 180) / 180 * pi, clockwise: true)
        inRangePath.addArc(withCenter: centerPoint, radius: fillCircleRadius , startAngle: endingAngel/180.0 * pi, endAngle: startAngle / 180.0 * pi, clockwise: false)
        let beginingCenter = getPoint(center: centerPoint, radius: innerCircleRadius + (fillCircleRadius - innerCircleRadius) / 2, degree: startAngle)
        inRangePath.addArc(withCenter: beginingCenter, radius: (fillCircleRadius - innerCircleRadius) / 2, startAngle: (startAngle / 180) * pi, endAngle: (startAngle + 180) / 180 * pi, clockwise: false)
        inRangePath.fill()
    }
    
    func drawBackground(){
        //ovalIn: CGRect(origin: CGPoint.zero, size: size)
        let fullCirclePath = UIBezierPath()
        fullCirclePath.move(to: centerPoint)
        fullCirclePath.addArc(withCenter: centerPoint, radius: fillCircleRadius, startAngle: -0.4 * pi, endAngle: 1.4 * pi, clockwise: true)
        let bottomColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        bottomColor.setFill()
        fullCirclePath.fill()
        
        let beginingHeadPath = UIBezierPath()
        let beginingCenter = getPoint(center: centerPoint, radius: innerCircleRadius + (fillCircleRadius - innerCircleRadius) / 2, degree: -360 * 0.4 / 2)
        beginingHeadPath.addArc(withCenter: beginingCenter, radius: (fillCircleRadius - innerCircleRadius) / 2, startAngle: 0, endAngle: 2 * pi, clockwise: false)
        beginingHeadPath.fill()
        
        let endingHeadPath = UIBezierPath()
        let endiningCenter = getPoint(center: centerPoint, radius: innerCircleRadius + (fillCircleRadius - innerCircleRadius) / 2, degree: 360 * 1.4 / 2)
        endingHeadPath.addArc(withCenter: endiningCenter, radius: (fillCircleRadius - innerCircleRadius) / 2, startAngle: 0, endAngle: 2 * pi, clockwise: false)
        endingHeadPath.fill()
        
        
    
        let lightCirclePath = UIBezierPath()
        lightCirclePath.addArc(withCenter: centerPoint, radius: innerCircleRadius, startAngle: 0, endAngle: 2 * pi , clockwise: true)
        let lighter = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        lighter.setFill()
        lightCirclePath.fill()
    }
    
    
    static func drawInRangeChart(){
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let range = GlucoseRange(points: [GlucosePoint(value:180),GlucosePoint(value:60),GlucosePoint(value:90),GlucosePoint(value:100),GlucosePoint(value:120),GlucosePoint(value:135)],high:150,low:80)
        range.drawBackground()
        range.drawFullCoverage()
        range.drawPoints()
        range.maxPoint.drawValue()
        range.minPoint.drawValue()
        range.drawInRangeCoverage()
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
}


GlucoseRange.drawInRangeChart()





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























