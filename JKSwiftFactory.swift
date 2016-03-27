//
//  JKSwiftButtonFactory.swift
//  NewWineClient
//
//  Created by 马少洋 on 16/3/19.
//  Copyright © 2016年 贵永冬. All rights reserved.
//

import UIKit

class JKSwiftFactory: NSObject {

    /**
    button工厂
     - parameter frame:            button的frame
     - parameter buttonTitle:      标题
     - parameter tag:              tag
     - parameter buttonBackColor:  背景颜色
     - parameter buttonTitleColor: 标题颜色
     - parameter borderWidth:      边框宽
     - parameter borderColor:      边框颜色
     - parameter target:           对象（用来添加时间）
     - parameter action:           点击事件
     */
    class func createButton(frame frame:CGRect = CGRectMake(0, 100, 100, 20),
        buttonTitle : String = "",
        tag : NSInteger = 1,
        buttonBackColor : UIColor = UIColor.clearColor(),
        buttonImage:UIImage? = nil,
        buttonTitleColor : UIColor = UIColor.blackColor(),
        borderWidth : CGFloat = 0,
        borderColor : UIColor  = UIColor.clearColor(),
        cornerRadius : CGFloat = 0,
        buttonFont : CGFloat = 17,
        target:AnyObject? = nil ,
        action:Selector? = nil
        ) -> UIButton{
        
        let button : UIButton = UIButton(type: UIButtonType.Custom)
        button.frame = frame
        button.tag = tag
        button.setTitle(buttonTitle, forState: UIControlState.Normal)
        button.setTitle(buttonTitle, forState: UIControlState.Highlighted)
        button.setTitleColor(buttonTitleColor, forState: UIControlState.Normal)
        button.setTitleColor(buttonTitleColor, forState: UIControlState.Highlighted)
        button.titleLabel?.font = UIFont.systemFontOfSize(buttonFont)
        button.backgroundColor = buttonBackColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = cornerRadius
        button.layer.borderColor = borderColor.CGColor
        button.layer.borderWidth = borderWidth
        if target != nil || action != nil{
            button.addTarget(target!, action: action!, forControlEvents: UIControlEvents.TouchUpInside)
        }
        if (buttonTitle == "" && buttonImage == nil){
            button.backgroundColor = UIColor.blueColor()
        }
        if(buttonImage != nil){
            button.setImage(buttonImage, forState: UIControlState.Normal)
            button.setImage(buttonImage, forState: UIControlState.Highlighted)
        }
        return button
    }
    
    /**
     label工厂
     - parameter frame:            label的frame
     - parameter labelTitle:      标题
     - parameter tag:              tag
     - parameter labelBackColor:  背景颜色
     - parameter labelTitleColor: 标题颜色
     - parameter borderWidth:      边框宽
     - parameter borderColor:      边框颜色
     */
    class  func createLabel(frame frame : CGRect = CGRectMake(0, 100, 100, 20),
        labelTitle : String = "",
        labelBackColor : UIColor = UIColor.clearColor() ,
        labelTitleColor : UIColor = UIColor.clearColor(),
        textAlignment : NSTextAlignment = NSTextAlignment.Center,
        fontSize:CGFloat = 17,
        borderWidth : CGFloat = 0,
        borderColor : UIColor  = UIColor.clearColor(),
        cornerRadius : CGFloat = 0,
        tag : NSInteger = 0) -> UILabel {
            
        let label : UILabel = UILabel(frame: frame)
        label.text = labelTitle
        label.textAlignment = textAlignment
        label.font = UIFont.systemFontOfSize(fontSize)
        label.textColor = labelTitleColor
        label.backgroundColor = labelBackColor
        label.layer.borderColor = borderColor.CGColor
        label.layer.borderWidth = borderWidth
        label.layer.masksToBounds = true
        label.layer.cornerRadius = cornerRadius
        if(labelTitle == ""){
            label.backgroundColor = UIColor.blueColor()
        }
        label.tag = tag
        return label
    }
    /**
     创建textField
     
     - parameter frame:         frame
     - parameter placeText:     占位字符
     - parameter fontSize:      字体大小
     - parameter borderWidth:   边框粗细
     - parameter borderColor:   边框颜色额
     - parameter cornerRadius:  裁剪大小
     - parameter textAlignment: 字体居中
     - parameter textColor:     字体颜色
     - parameter tag:           tag
     - parameter delegate:      代理
     
     - returns: textField
     */
    class func createTextField(frame frame:CGRect = CGRectMake(0, 0, 100, 10),
        placeText : String = "",
        fontSize:CGFloat = 17,
        borderWidth : CGFloat = 0,
        borderColor : UIColor  = UIColor.clearColor(),
        cornerRadius : CGFloat = 0,
        textAlignment : NSTextAlignment = NSTextAlignment.Left,
        textColor : UIColor = UIColor.blackColor(),
        tag : NSInteger = 0,
        delegate : UITextFieldDelegate
        ) ->UITextField{
            let textField : UITextField = UITextField(frame: frame)
            textField.placeholder = placeText
            textField.textAlignment = textAlignment
            textField.textColor = textColor
            textField.tag = tag
            textField.delegate = delegate
            textField.font = UIFont.systemFontOfSize(fontSize)
            textField.layer.masksToBounds = true
            textField.layer.cornerRadius = cornerRadius
            textField.layer.borderColor = borderColor.CGColor
            textField.layer.borderWidth = borderWidth
            textField.leftView = JKSwiftFactory.createLine(frame: CGRectMake(0, 0, 8, 0), color: UIColor.clearColor(), tag: 0)
            textField.leftViewMode = UITextFieldViewMode.Always
            return textField
    }
    
    /// 创建一条线
    class  func createLine(frame frame : CGRect = CGRectMake(0, 0, 100, 1),
        color : UIColor = UIColor.blackColor(),
        tag : NSInteger = 1
        ) -> UIView {
            
        let line : UIView = UIView(frame: frame)
        line.tag = tag
        line.frame = frame
        line.backgroundColor = color
        return line
    }
    /**
     通过名字返回一个路径
     
     - parameter imageName: 图片名字带上格式
     
     - returns: 图片
     */
    class func getImagePath(imageName imageName:String)->UIImage {
        let imagePath : String = NSBundle.mainBundle().pathForResource(imageName, ofType: nil)!
        let image : UIImage = UIImage(contentsOfFile: imagePath)!
        return image
    }
    
    class func getStringFrame (text text : String,textWidth : CGFloat,fontSize : CGFloat,isBold : Bool) ->CGRect?{
        if Float(UIDevice.currentDevice().systemVersion) >= 7.0{
            //iOS7之后
            var dict: NSDictionary = NSDictionary()
            if (isBold) {
                dict = NSDictionary(object: UIFont.boldSystemFontOfSize(fontSize), forKey: NSFontAttributeName)
                
            } else {
                dict = NSDictionary(object: UIFont.systemFontOfSize(fontSize), forKey: NSFontAttributeName)
                
            }
            
            let rect: CGRect = (text as NSString).boundingRectWithSize(CGSize(), options: [NSStringDrawingOptions.TruncatesLastVisibleLine, NSStringDrawingOptions.UsesFontLeading, NSStringDrawingOptions.UsesLineFragmentOrigin], attributes: dict as? [String : AnyObject], context: nil)
            return rect
        }

        return nil
    }
    
    class func changeImageSelect(selectImage selectImage : UIImage? = nil,
         button : UIButton,
         selectTitleColor : UIColor? = UIColor.blackColor(),
         selectTitle : String? = nil,
         image : UIImage? = nil,
         titleColor : UIColor? = UIColor.blackColor(),
         title : String? = nil
        ){
        if image != nil {
            button.setImage(image, forState: UIControlState.Normal)
        }
        if selectImage != nil {
            button.setImage(selectImage, forState: UIControlState.Selected)
        }
        if selectTitle != nil {
            button.setTitle(selectTitle, forState: UIControlState.Selected)
        }
        if title != nil {
            button.setTitle(title, forState: UIControlState.Normal)
        }
        button.setTitleColor(selectTitleColor, forState: UIControlState.Selected)
        button.setTitleColor(titleColor, forState: UIControlState.Normal)
    }
    

}
