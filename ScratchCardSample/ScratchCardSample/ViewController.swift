//
//  UIImageView.h
//  ScratchÇard
//
//  Copyright (c) 2021-2022 Ashi Inc. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scratchCardActionBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didPresentScratchCard(_ sender: Any) {
        if let vc = ScratchActionViewController.scratchActionViewController() {
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: {
            })
        }
    }

}

