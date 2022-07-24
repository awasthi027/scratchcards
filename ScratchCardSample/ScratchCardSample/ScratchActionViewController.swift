//
//  UIImageView.h
//  ScratchÇard
//
//  Copyright (c) 2021-2022 Ashi Inc. All rights reserved.
//

import UIKit
import AAScratchView

class ScratchActionViewController: UIViewController {

    @IBOutlet weak var scratchImageView: AAScratchView!
    @IBOutlet weak var scratchCardView: UIView!

    @IBOutlet weak var winningBgView: UIView!
    
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var winTitleLbl: UILabel!
    @IBOutlet weak var winSubtitleLbl: UILabel!
    @IBOutlet weak var nexSubTitleLbl: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var redeemBtn: UIButton!
    @IBOutlet weak var lineView: UIView!

    class func scratchActionViewController() -> ScratchActionViewController? {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: String(describing: ScratchActionViewController.self)) as? ScratchActionViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scratchImageView.lineWidth = 40.0
        self.scratchImageView.delegate = self

        winningBgView.isHidden = true
        self.scratchImageView.layer.cornerRadius = 8
        self.scratchImageView.layer.masksToBounds = true
        
        self.scratchCardView.layer.cornerRadius = 8
        self.scratchCardView.layer.masksToBounds = true
        actionBtn.cardLayer(8.0)
        winningBgView.cardLayer(30)
        lineView.cardLayer(2)
        redeemBtn.cardLayer(8)
        heightConstraint.constant += 60

        titleLbl.text = "You Won\n\n$1000"
        actionBtn.setTitle("Add 100  ", for: .normal)
        // nexSubTitleLbl.text = rulesTxt
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Actions
    @IBAction func didSelectOnButtonAction(_ sender: AnyObject) {

    }
    @IBAction func didSelectOnCrossButtonAction(_ sender: AnyObject) {
        self.dismiss(animated: true)
    }

    @IBAction func didSelectOnRedeemButtonAction(_ sender: AnyObject) {
    }
    
}
    
extension ScratchActionViewController: AAScratchViewDelegate {
    func view(_ scratchView: AAScratchView, scratchCardEraseProgress eraseProgress: Float) {
        if eraseProgress > 60.0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.scratchImageView.alpha = 0.0
                self.winningBgView.isHidden = false
            })
        }
    }
}
extension UIView {
    /// make corners rounds as per the radius, default radius = 0
    func cardLayer(_ radius: CGFloat = 0, _ borderWidth: CGFloat = 0, _ color: UIColor = .lightGray) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
}
