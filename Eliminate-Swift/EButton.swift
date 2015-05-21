//
//  EButton.swift
//  Eliminate-Swift
//
//  Created by 裕福 on 15/5/20.
//  Copyright (c) 2015年 裕福. All rights reserved.
//

import UIKit

enum EBUTTONCOLOR:UInt32 {
    case red=0,yellow,blue,green,purple
}

class EButton: UIButton {

    var clickCount:Int?
    var mTag:Int?
    var isExist:Bool?
    var type:EBUTTONCOLOR?
    
    var calculateType:EBUTTONCOLOR {
        set{
            if newValue == EBUTTONCOLOR.red {
                self.setBackgroundImage(self.imageWithColor(UIColor.redColor()), forState: UIControlState.Normal)
            }else if newValue == EBUTTONCOLOR.yellow {
                self.setBackgroundImage(self.imageWithColor(UIColor.yellowColor()), forState: UIControlState.Normal)
            }else if newValue == EBUTTONCOLOR.blue {
                self.setBackgroundImage(self.imageWithColor(UIColor.blueColor()), forState: UIControlState.Normal)
            }else if newValue == EBUTTONCOLOR.green {
                self.setBackgroundImage(self.imageWithColor(UIColor.greenColor()), forState: UIControlState.Normal)
            }else {
                self.setBackgroundImage(self.imageWithColor(UIColor.purpleColor()), forState: UIControlState.Normal)
            }
            type = newValue
        }
        get{
            return type!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageWithColor(color:UIColor) -> UIImage {
        var rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        var image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
}
