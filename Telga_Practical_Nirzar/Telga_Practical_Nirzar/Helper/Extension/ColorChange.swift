//
//  ColorChange.swift
//  Medizone
//
//  Created by nilomi on 19/12/18.
//  Copyright © 2018 nilomi. All rights reserved.
//




func colorChange(view : UIView){
    // let allSubviews = view.allSubViewsOf(type: UIView.self)
    //    let allLabels : [UILabel] = view.allSubViewsOf(type: UILabel.self)
    //    changeComponentValues(lblArr: allLabels)
    //    let allViews : [UIView] = view.allSubViewsOf(type: UIView.self)
    
    //    changeComponentValues(viewArr: allViews)
    let allBtn : [UIButton] = view.allSubViewsOf(type: UIButton.self)
    changeAllBtnTintColor(btnArr: allBtn)
    //    changeComponentButtons(btnArr: allBtn , bgColor: UIColor.black, titleColor: UIColor.white, font: UIFont.systemFont(ofSize: 17), tintColor: UIColor.black)
    
    //    let allTxtFld : [UITextField] = view.allSubViewsOf(type: UITextField.self)
    //    changeTxtFld(txtArr: allTxtFld)
    
}


func changeTxtFld (txtArr : [UITextField]){
    for txtfld in txtArr {
        txtfld.changeTxtFlNirzarrs(placeHolderColor: UIColor.black, borderWidth: 0.5, borderColor: UIColor.darkGray, textColor: UIColor.lightGray, bgColor: UIColor.white, font: UIFont.systemFont(ofSize: 15), strPlaceholder: nil)
    }
}

func changeComponentValues (lblArr : [UILabel]){
    for lbl in lblArr {
        lbl.changeLabelAttributes(fontColor: UIColor.black, font: UIFont(name: "Mishafi", size: lbl.font.pointSize), bgColor: UIColor.white)
    }
}

func changeComponentValues (viewArr : [UIView]){
    print(viewArr.count)
    
    for v in viewArr {
        if( type(of: v) == UIView.self){
            v.changeViewAttributes(bgColor: UIColor.white, borderWidth: nil, borderColor: nil)
        }
    }
}

func changeAllBtnAttributes (btnArr : [UIButton] , bgColor : UIColor, titleColor : UIColor, font : UIFont? ,  tintColor : UIColor?){
    for btn in btnArr {
        btn.changeBtnAttributes(bgColor: bgColor, titleColor: titleColor, font: font, tintColor: tintColor, strText: nil)
    }
}

func changeAllBtnTintColor (btnArr : [UIButton]){
    for btn in btnArr {
        btn.setTintColor(UIColor.red)
    }
}

func overrideFontSize(intDefaultFontSize : Int, strBuilderFlySize : String?) -> CGFloat {
    
    return CGFloat(intDefaultFontSize)
}

//MARK: changing attributes
extension UIButton {
    func changeBtnAttributes(bgColor : UIColor?, borderColor : UIColor = .clear, titleColor : UIColor?, font : UIFont? ,  tintColor : UIColor?, strText : String?)  {
        
        //font else
        /*else {
         self.titleLabel?.font = UIFont(name: Global.shared.wholeAppFont, size: (self.titleLabel?.font.pointSize) ?? 15)
         }*/
        
        if bgColor != nil {
            self.backgroundColor = bgColor
        }
        
        if borderColor != nil {
            self.borderColor = borderColor
        }
        
        if titleColor != nil {
            self.setTitleColor(titleColor, for: .normal)
        }
        
        if(font != nil) {
            self.titleLabel?.font = font
        }
        
        if tintColor != nil {
            self.tintColor = tintColor
        }
        
        if strText != nil {
            self.setTitle(strText, for: .normal)
        }
    }
    
    func setTintColor(_ color : UIColor)  {
        self.tintColor = color
    }
    
}
extension UIFont {
    var bold: UIFont { return withWeight(.bold) }
    var semibold: UIFont { return withWeight(.semibold) }
    var regular: UIFont { return withWeight(.regular) }
    
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        traits[.weight] = weight
        
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName
        
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}

extension UITextField {
    func changeTxtFlNirzarrs(placeHolderColor : UIColor?, borderWidth : CGFloat? , borderColor : UIColor?, textColor : UIColor?, bgColor : UIColor? , font : UIFont? ,strPlaceholder : String? )  {
        
        if strPlaceholder != nil {
            self.placeholder = strPlaceholder
        }
        if placeHolderColor != nil {
            self.placeHolderColor = placeHolderColor?.withAlphaComponent(0.65)
        }
        if borderWidth != nil {
            self.borderWidth = borderWidth!
        }
        if borderColor != nil {
            self.borderColor = borderColor
        }
        if textColor != nil {
            self.textColor = textColor
        }
        if font != nil {
            self.font = font
        }
        if backgroundColor != nil {
            self.backgroundColor = bgColor
        }
    }
}

extension UITextView {
    func changeTxtViewAttrs(borderWidth : CGFloat? , borderColor : UIColor?, textColor : UIColor?, bgColor : UIColor? , font : UIFont?)  {
        
        if borderWidth != nil {
            self.borderWidth = borderWidth ?? 0
        }
        if borderColor != nil {
            self.borderColor = borderColor
        }
        if textColor != nil {
            self.textColor = textColor
        }
        if font != nil {
            self.font = font
        }
        if backgroundColor != nil {
            self.backgroundColor = bgColor
        }
    }
}

extension UILabel {
    func changeLabelAttributes( fontColor : UIColor? , font : UIFont? , bgColor : UIColor? )  {
        
        if fontColor != nil {
            self.textColor = fontColor
        }
        
        if font != nil {
            self.font = font
        }
        
        if bgColor != nil {
            self.backgroundColor = bgColor
        }
        
    }
}

extension UIView{
    func changeViewAttributes( bgColor : UIColor? , borderWidth : CGFloat? , borderColor : UIColor? )  {
        
        if bgColor != nil {
            self.backgroundColor = bgColor
        }
        
        if borderWidth != nil {
            self.borderWidth = borderWidth!
        }
        
        if borderColor != nil {
            self.borderColor = borderColor
        }
        
    }
}
extension UIView {
    
    func subViews<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T{
                all.append(aView)
            }
        }
        return all
    }
    
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}

