# scratchcards

Designed Framework and Sample Application for Scratch card UI

## Designed simple framework for scratch card UI. You can take scratch image from this framework and design own customize UI.


##How to intergate in Controller


 @IBOutlet weak var scratchImageView: AAScratchView!
 @IBOutlet weak var scratchCardView: UIView!
  @IBOutlet weak var winningBgView: UIView!
  
  
  
  ViewDidLoad 
  
      winningBgView.isHidden = true
      self.scratchImageView.lineWidth = 40.0
      self.scratchImageView.delegate = self
      self.scratchImageView.layer.cornerRadius = 8
      self.scratchImageView.layer.masksToBounds = true
        
      self.scratchCardView.layer.cornerRadius = 8
      self.scratchCardView.layer.masksToBounds = true
      
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

## For more information follow sample application.
