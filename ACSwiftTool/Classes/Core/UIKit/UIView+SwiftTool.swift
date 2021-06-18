//
//  UIView+SwiftTool.swift
//  SwiftTool
//
//  Created by Quinn on 2020/10/20.
//

import UIKit
import SVProgressHUD
/// 线的位置
public enum LinePosition: Int {
    case top = 0
    case bottom = 1
    case center = 2
}

/// UIView的构造和函数
extension UIView {
    
    public convenience init(backgroundColor: UIColor = UIColor.white, cornerRadius: CGFloat? = nil) {
        self.init()
        self.backgroundColor = backgroundColor
        
        if let radius = cornerRadius {
            self.cornerRadius = radius
        }
    }
    
    /// 从nib初始化一个View
    public static func nib<T>(bundle: Bundle? = nil) -> T {
        return UINib(nibName: self.named, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! T
    }
    
    /// 添加阴影
    public func shadow(ofColor color: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.2) {
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false

    }
    /// 添加阴影图层
    public func shadowLayer(ofColor color: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5,cornerRadius:CGFloat,bounds:CGRect) {
        
        let layer = CALayer()
        layer.frame = bounds
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.backgroundColor = UIColor.white.cgColor
        self.layer.insertSublayer(layer, at: 0)
        self.layer.addSublayer(layer)
        
    }
    
    
    /// 添加细线 ply线高
    @discardableResult
    public func line(position : LinePosition, color : UIColor, ply : CGFloat, leftPadding : CGFloat, rightPadding : CGFloat) -> UIView {
        let line = UIView.init()
        line.backgroundColor = color;
        line.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(line)
        line.leftAnchor.constraint(equalTo: leftAnchor, constant: leftPadding).isActive = true
        line.rightAnchor.constraint(equalTo: leftAnchor, constant: rightPadding).isActive = true
        line.heightAnchor.constraint(equalToConstant: ply).isActive = true
        switch position {
        case .top:
            line.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        case .bottom:
            line.bottomAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        case .center:
            line.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
            line.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        }
        return line
    }
    
    // MARK: - 添加点击手势
    private struct AssociatedKeys {
        static var tapGesture = false
    }
    /// 添加点击手势
    /// - Parameter handler: 点击回调
    func addTapGesture(handler: @escaping NormalClosure) {
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        addGestureRecognizer(tap)
        objc_setAssociatedObject(self, &AssociatedKeys.tapGesture, handler, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
    @objc func tapGesture(_ gesture:UITapGestureRecognizer) {
        if let closure = objc_getAssociatedObject(self, &AssociatedKeys.tapGesture) as? NormalClosure {
            closure()
        }
    }
    
    /// 添加长按手势
    @discardableResult
    public func addLongPressGestureRecognizer(target : Any?, action : Selector?, pressDuration: Double = 1) -> UILongPressGestureRecognizer {
        
        let longPressGesture = UILongPressGestureRecognizer.init(target: target, action: action)
        longPressGesture.minimumPressDuration    = pressDuration;
        self.addGestureRecognizer(longPressGesture)
        self.isUserInteractionEnabled = true
        return longPressGesture
    }
    
    /// 获取view的UIViewController
    public func parentViewController()->UIViewController?{
        for view in sequence(first: self.superview, next: {$0?.superview}){
            if let responder = view?.next{
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    /// 添加顶部mask
    public func topCornerRadius(rect:CGRect,radius:CGFloat){
        cornerRadius(position: [.topLeft, .topRight], cornerRadius: radius, roundedRect:rect)
    }
    
    /// 使用贝塞尔曲线设置圆角
    public func cornerRadius(position: UIRectCorner, cornerRadius: CGFloat, roundedRect: CGRect) {
        let path = UIBezierPath(roundedRect:roundedRect, byRoundingCorners: position, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let layer = CAShapeLayer()
        layer.frame = roundedRect
        layer.path = path.cgPath
        self.layer.mask = layer
    }
    
    /// 设置渐变色
    /// - Parameter colors: 颜色数组，定义渐变层的各个颜色
    /// - Parameter startPoint: 渲染的起始位置
    /// - Parameter endPoint: 渲染的终止位置
    @discardableResult
    func setGradient(colors: [UIColor], startPoint: CGPoint ,endPoint: CGPoint) -> CAGradientLayer {
        func setGradient(_ layer: CAGradientLayer) {
            self.layoutIfNeeded()
            var colorArr = [CGColor]()
            for color in colors {
                colorArr.append(color.cgColor)
            }
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            layer.frame = self.bounds
            CATransaction.commit()
            
            layer.colors = colorArr
            layer.startPoint = startPoint
            layer.endPoint = endPoint
        }
        
        let gradientLayer = CAGradientLayer()
        self.layer.insertSublayer(gradientLayer , at: 0)
        setGradient(gradientLayer)
        return gradientLayer
    }
    
}

extension UIView {
    /// 设置圆角
    public var cornerRadius: CGFloat {
        set {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    /// 指定位置圆角
    func addRoundedCorners(_ corners: UIRectCorner,radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    /// 设置边框线颜色
    public func border(color: UIColor, width: CGFloat = 1.0) {
        self.layer.masksToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    ///将当前视图转为UIImage
    public func screenshots() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { (rendererContext) in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
// MARK: - view + SVProgressHUD
extension UIView{
    // MARK: - SVProgressHUD提示设置
    /// 显示加载
    public static func showToastActivity() {
        SVProgressHUD.show()
    }
    /// 隐藏加载
    public static func hideToastActivity() {
        self.dismissHUD()
    }
    
    /// 信息提示
    /// - Parameter with:提示文字
    public static func showInfo(with status: String?) {
        SVProgressHUD.showInfo(withStatus: status)
    }
    
    /// 加载提示
    /// - Parameter with:提示文字
    public static func showLoding(with status: String?) {
        SVProgressHUD.show(withStatus: status)
    }
    
    /// 成功提示
    /// - Parameter with:提示文字
    public static func showSuccess(with status: String?) {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    /// 黑色背景错误提示
    /// - Parameter with:提示文字
    public static func showError(with status: String?) {
        SVProgressHUD.showError(withStatus: status)
    }
    
    /// 关闭提示
    public static func dismissHUD() {
        SVProgressHUD.dismiss()
        // SVProgressHUD.setMinimumSize(.zero)
    }
    
    /// 关闭提示
    /// - Parameter time:时间
    public static func dismissHUD(withDelay: TimeInterval) {
        SVProgressHUD.dismiss(withDelay: withDelay)
    }
}
// MARK: - view + BlurView

extension UIView {
    
    private struct BlurAssociatedKeys {
        static var descriptiveName = "AssociatedKeys.DescriptiveName.blurView"
    }
    
    private (set) var blur: BlurView {
        get {
            if let blurView = objc_getAssociatedObject(
                self,
                &BlurAssociatedKeys.descriptiveName
            ) as? BlurView {
                return blurView
            }
            self.blur = BlurView(to: self)
            return self.blur
        }
        set(blurView) {
            objc_setAssociatedObject(
                self,
                &BlurAssociatedKeys.descriptiveName,
                blurView,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    func addAlignedConstrains() {
        translatesAutoresizingMaskIntoConstraints = false
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.top)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.leading)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.trailing)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.bottom)
    }
    
    func addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute) {
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: attribute,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: superview,
                attribute: attribute,
                multiplier: 1,
                constant: 0
            )
        )
    }
    
}
/// 高斯模糊
class BlurView {
    
    private var superview: UIView
    private var blur: UIVisualEffectView?
    private var editing: Bool = false
    private (set) var blurContentView: UIView?
    private (set) var vibrancyContentView: UIView?
    
    var animationDuration: TimeInterval = 0.1
    
    /**
     * Blur style. After it is changed all subviews on
     * blurContentView & vibrancyContentView will be deleted.
     */
    var style: UIBlurEffect.Style = .light {
        didSet {
            guard oldValue != style,
                  !editing else { return }
            applyBlurEffect()
        }
    }
    /**
     * Alpha component of view. It can be changed freely.
     */
    var alpha: CGFloat = 0 {
        didSet {
            guard !editing else { return }
            if blur == nil {
                applyBlurEffect()
            }
            let alpha = self.alpha
            UIView.animate(withDuration: animationDuration) {
                self.blur?.alpha = alpha
            }
        }
    }
    
    init(to view: UIView) {
        self.superview = view
    }
    
    func setup(style: UIBlurEffect.Style, alpha: CGFloat) -> Self {
        self.editing = true
        
        self.style = style
        self.alpha = alpha
        
        self.editing = false
        
        return self
    }
    
    func enable(isHidden: Bool = false) {
        if blur == nil {
            applyBlurEffect()
        }
        
        self.blur?.isHidden = isHidden
    }
    
    private func applyBlurEffect() {
        blur?.removeFromSuperview()
        
        applyBlurEffect(
            style: style,
            blurAlpha: alpha
        )
    }
    
    private func applyBlurEffect(style: UIBlurEffect.Style,
                                 blurAlpha: CGFloat) {
        superview.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        blurEffectView.contentView.addSubview(vibrancyView)
        
        blurEffectView.alpha = blurAlpha
        
        superview.insertSubview(blurEffectView, at: 0)
        
        blurEffectView.addAlignedConstrains()
        vibrancyView.addAlignedConstrains()
        
        self.blur = blurEffectView
        self.blurContentView = blurEffectView.contentView
        self.vibrancyContentView = vibrancyView.contentView
    }
}

