//
//  UIImageView.h
//  ScratchÇard
//
//  Copyright (c) 2021-2022 Ashi Inc. All rights reserved.
//
import UIKit

public protocol AAScratchViewDelegate: NSObjectProtocol {
    func view(_ scratchView: AAScratchView, scratchCardEraseProgress eraseProgress: Float)
}

/// This class responsible for designing scratch cards
public class AAScratchView: UIImageView {

    /// Delegated reference to give call back
    public weak var delegate: AAScratchViewScratchViewDelegate?
    /// draw boarder type
    public var lineType: CGLineCap = .round
    /// draw border width
    public var lineWidth: CGFloat = 30.0
    /// final localtion
    private var finalLocation: CGPoint?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = true
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard  let touch = touches.first else { return }
        finalLocation = touch.location(in: self)
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard  let touch = touches.first, let point = finalLocation else { return }
        let currentLocation = touch.location(in: self)
        scrachBetween(point, currentLocation)
        finalLocation = currentLocation
        if let img = self.image, let _ = delegate {
            let eraseProgress = scratchedPercentage(img)
            delegate?.view(self, scratchCardEraseProgress: eraseProgress * 100)
        }
    }

    /// This method is responsible for scratching the card
    /// - Parameters:
    ///   - fromPoint: from point
    ///   - currentPoint: this courrect points
    func scrachBetween(_ fromPoint: CGPoint, _ currentPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.frame.size)
        image?.draw(in: self.bounds)
        let path = CGMutablePath()
        path.move(to: fromPoint)
        path.addLine(to: currentPoint)
        let context = UIGraphicsGetCurrentContext()!
        context.setShouldAntialias(true)
        context.setLineCap(lineType)
        context.setLineWidth(lineWidth)
        context.setBlendMode(.clear)
        context.addPath(path)
        context.strokePath()
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    private func scratchedPercentage(_ scratchImage: UIImage) -> Float {
        let width = Int(scratchImage.size.width)
        let height = Int(scratchImage.size.height)
        
        let bitmapBytesPerRow = width
        let bitmapByteCount = bitmapBytesPerRow * height
        let pixelData = UnsafeMutablePointer<UInt8>.allocate(capacity: bitmapByteCount)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        let context = CGContext(data: pixelData,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: bitmapBytesPerRow,
                                space: colorSpace,
                                bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.alphaOnly.rawValue).rawValue)!
        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context.clear(rect)
        context.draw(scratchImage.cgImage!, in: rect)
        var alphaOnlyPixels = 0
        for x in 0...Int(width) {
            for y in 0...Int(height) {
                if pixelData[y * width + x] == 0 {
                    alphaOnlyPixels += 1
                }
            }
        }
        free(pixelData)
        return Float(alphaOnlyPixels) / Float(bitmapByteCount)
    }
}
