//
//  TransparentLayoutManager.swift
//  ReversedFont
//
//  Created by Arsen Gasparyan on 04/07/16.
//  Copyright © 2016 Arsen Gasparyan. All rights reserved.
//

import UIKit

class TransparentLayoutManager: NSLayoutManager {

    override func showCGGlyphs(glyphs: UnsafePointer<CGGlyph>, positions: UnsafePointer<CGPoint>, count glyphCount: Int, font: UIFont, matrix textMatrix: CGAffineTransform, attributes: [String : AnyObject], inContext graphicsContext: CGContext) {
        guard attributes[NSBackgroundColorAttributeName] != nil else {
            super.showCGGlyphs(glyphs, positions: positions, count: glyphCount, font: font, matrix: textMatrix, attributes: attributes, inContext: graphicsContext)
            return
        }
        
        CGContextSaveGState(graphicsContext)
        CGContextSetBlendMode(graphicsContext, .DestinationOut)
        super.showCGGlyphs(glyphs, positions: positions, count: glyphCount, font: font, matrix: textMatrix, attributes: attributes, inContext: graphicsContext)
        CGContextRestoreGState(graphicsContext)
    }
    
}
