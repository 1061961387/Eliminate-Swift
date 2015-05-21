//
//  EView.swift
//  Eliminate-Swift
//
//  Created by 裕福 on 15/5/20.
//  Copyright (c) 2015年 裕福. All rights reserved.
//

import UIKit

class EView: UIView {

    var row:Int = 10
    var column:Int = 10
    var margin:CGFloat = 2.0
    var edge:CGFloat = 10.0
    
    var elementWidth:CGFloat = 0.0
    var elementHeight:CGFloat = 0.0
    var totalArray:NSMutableArray = []
    var removeArray:NSMutableArray = []
    
    var surplus:Int = 0
    
    func start() {
        self.backgroundColor = UIColor.grayColor()
        self.elementWidth = (self.frame.size.width-CGFloat(self.column-1)*self.margin-(self.edge*2))/CGFloat(self.column)
        self.elementHeight = (self.frame.size.width-CGFloat(self.row-1)*self.margin-self.edge*2)/CGFloat(self.row);
        println("elementWidth = \(self.elementWidth) -- elementHeight = \(self.elementHeight)")
        
        self.creatBtns()
    }
    
    func reload() {
        self.end()
        self.start()
    }
    
    func creatBtns() {
        for var j=0; j<self.column; j++ {
            var columnArray:NSMutableArray = []
            for var i=self.row; i>0; i-- {
                var btn = EButton()
                btn = EButton.buttonWithType(UIButtonType.Custom) as! EButton
                btn.frame = CGRectMake(self.edge+(self.elementWidth+self.margin)*CGFloat(j), self.edge+(self.elementHeight+self.margin)*CGFloat(i-1), self.elementWidth, self.elementHeight)
                btn.tag = j*10+self.row-i
                btn.mTag = btn.tag
                btn.isExist = true
                var random = arc4random()%5
                btn.calculateType = EBUTTONCOLOR(rawValue: random)!
                btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                btn.addTarget(self, action: "click:", forControlEvents:UIControlEvents.TouchUpInside)
                self.addSubview(btn)
                columnArray.addObject(btn)
            }
            self.totalArray.addObject(columnArray)
        }
    }
    
    func click(sender:EButton) {
        self.removeArray.removeAllObjects()
        self.removeArray.addObject(sender)
        
        self.addRelateBtn()
        
        if self.removeArray.count >= 2 {
            for btn in self.removeArray {
                var tmp:NSMutableArray = self.totalArray
                for array in tmp as NSMutableArray {
                    if array.containsObject(btn) {
                        array.removeObject(btn)
                    }
                    if array.count == 0 {
                        self.totalArray.removeObject(array)
                    }
                }
                btn.removeFromSuperview()
            }
        }else{
            return
        }
        
        self.updateBtns()
        
        if !self.check() {
            var alertView = UIAlertView()
            alertView.title = "恭喜您"
            alertView.message = "获得\(self.column*self.row - self.surplus)分"
            alertView.addButtonWithTitle("确定")
            alertView.show()
        }
    }
    
    func check() -> Bool {
        self.removeArray.removeAllObjects()
        
        self.surplus = 0
        for array in self.totalArray as NSMutableArray {
            for btn in array as! NSMutableArray {
                self.removeArray.addObject(btn)
                self.addRelateBtn()
                self.surplus++
                if self.removeArray.count >= 2 {
                    return true
                }else{
                    self.removeArray.removeAllObjects()
                }
            }
        }
        return false
    }
    
    func addRelateBtn() {
        for var i=0; i<self.removeArray.count; i++ {
            var sender = self.removeArray.objectAtIndex(i) as! EButton
            var one = 0
            var ten = 0
            var array:NSMutableArray = []
            for ten=0; ten<self.totalArray.count; ten++ {
                array = self.totalArray.objectAtIndex(ten) as! NSMutableArray
                if array.containsObject(sender) {
                    one = array.indexOfObject(sender)
                    break
                }
            }
            
            if ten>0 {
            var left = self.totalArray.objectAtIndex(ten-1) as! NSMutableArray
                if left.count>one {
                    var btn = left.objectAtIndex(one) as! EButton
                    self.compare(sender, another:btn)
                }
            }
            
            if one<array.count-1 {
                var btn = array.objectAtIndex(one+1) as! EButton
                self.compare(sender, another: btn)
            }
            
            if ten<self.totalArray.count-1 {
                var right = self.totalArray.objectAtIndex(ten+1) as! NSMutableArray
                if right.count>one {
                    var btn = right.objectAtIndex(one) as! EButton
                    self.compare(sender, another: btn)
                }
            }
            
            if one>0 {
                var btn = array.objectAtIndex(one-1) as! EButton
                self.compare(sender, another: btn)
            }
        }
    }
    
    func compare(sender:EButton, another:EButton) {
        if self.removeArray.containsObject(another) {
            return
        }
        if sender.type == another.type {
            self.removeArray.addObject(another)
            self.addRelateBtn()
        }
    }
    
    func updateBtns() {
        for var j=0; j<self.totalArray.count; j++ {
            var array = self.totalArray.objectAtIndex(j) as! NSMutableArray
            for var i=0; i<array.count; i++ {
                var btn = array.objectAtIndex(i) as! EButton
                UIView.animateWithDuration(0.5, animations:
                    {
                        btn.frame = CGRectMake(self.edge+(self.elementWidth+self.margin)*CGFloat(j), self.edge+(self.elementHeight+self.margin)*CGFloat(self.row-i-1), self.elementWidth, self.elementHeight)

                })
            }
        }
    }
    
    func changeBtnFrame(column:Int, row:Int, sender:EButton) {
        sender.frame = CGRectMake(self.edge+(self.elementWidth+self.margin)*CGFloat(column), self.edge+(self.elementHeight+self.margin)*CGFloat(self.row-row-1), self.elementWidth, self.elementHeight)
    }
    
    func end() {
        for array in self.totalArray as NSMutableArray {
            for btn in array as! NSMutableArray {
                btn.removeFromSuperview()
            }
        }
        
        self.totalArray.removeAllObjects()
    }
    
}
