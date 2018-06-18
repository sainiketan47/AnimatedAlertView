//
//  KSAlertView.swift
//  KSDynamicAlert
//
//  Created by ketan saini on 22/03/17.
//  Copyright © 2017 Net Solutions. All rights reserved.
//

import UIKit

public protocol KSAlertDelegate {
    func okButtonTapped()
    func cancelButtonTapped()
}


open class KSAlertView: UIView {
    // Create UIDynamicAnimator object
    var animator: UIDynamicAnimator?
    public var delegate: KSAlertDelegate?
    public var strTitle: String?
    public var strMessage: String?
    let alertHightMargin: CGFloat = 100.0
    public var damping: CGFloat = 0.5

    //IBOutlets
    @IBOutlet var alertView: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var constraintYAxis: NSLayoutConstraint!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var constraintAlertHeight: NSLayoutConstraint!

    // UIView required methods
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    // init with frame
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    public init(title: String, message: String) {
        let window = UIApplication.shared.keyWindow
        super.init(frame: (window?.bounds)!)
        strTitle = title
        strMessage = message
    }

    /**
     Show alert with animation
     - Get UIView from nib
     - Set view frames
     - Add view on application window
     - Initialize UIDynamicAnimator
     - Create snap behaviour
     - Add behavior to animator
     */
    public func showAlert() {
        // Get View from nib
        let bundle = Bundle(identifier: "com.netsolutions.AnimatedAlert")
        let view = bundle?.loadNibNamed("KSAlertView", owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        addSubview(view)
        // Set y axis
        constraintYAxis.constant = -self.bounds.size.height
        self.layoutIfNeeded()

        //Set title and message
        lblTitle.text = strTitle
        lblMessage.text = strMessage

        // Add view to window
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)

        // Animate background view alpha
        backgroundView.alpha = 0.0
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 0.4
        }

        // Set Alert View Height
        if let font = UIFont(name: "Helvetica", size: 15)
        {
            let alertHeight = alertHightMargin + (strMessage?.height(withConstrainedWidth: lblMessage.bounds.size.width, font: font))!

            if alertHeight > self.bounds.size.height - 100 {
                constraintAlertHeight.constant = self.bounds.size.height - 100
            } else {
                constraintAlertHeight.constant = alertHeight
            }
            self.layoutIfNeeded()
        }

        // Add Snap Behavior to animator
        animator = UIDynamicAnimator(referenceView: self)
        let snap = UISnapBehavior(item: alertView, snapTo: self.center)
        snap.damping = damping
        animator?.addBehavior(snap)
    }

    /**
     Dismiss alert with animation
     - Remove all added Behaviors
     - Set alert view frames
     - Add Gravity Behavior
     - Remove alert view from application window
    */
    public func dismissAlert() {

        // Remove all Behaviors
        self.animator?.removeAllBehaviors()
        constraintYAxis.constant = self.center.y - alertView.frame.size.height
        self.layoutIfNeeded()
        // Add Gravity Behavior
        let gravityBehaviour = UIGravityBehavior(items: [alertView])
        gravityBehaviour.gravityDirection = CGVector(dx: 0.0, dy: 10.0)
        animator?.addBehavior(gravityBehaviour)

        let itemBehaviour = UIDynamicItemBehavior(items: [alertView])
        itemBehaviour.addAngularVelocity(CGFloat(-Double.pi/2), for: alertView)
        animator?.addBehavior(itemBehaviour)

        UIView.animate(withDuration: 0.5) {
            self.backgroundView.alpha = 0.0
        }
        // Remove view from super view
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.removeFromSuperview()
        }

    }
    // MARK: UIButton Outlets
    // Button Ok Tapped action
    @IBAction func btnOkTapped(_ sender: Any) {
        delegate?.okButtonTapped()
        dismissAlert()
    }
    // Button Cancel Tapped action
    @IBAction func btnCancelTapped(_ sender: Any) {
        delegate?.cancelButtonTapped()
        dismissAlert()
    }
}

extension String {
    /*
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
 */
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)

        return boundingBox.height
    }
}
