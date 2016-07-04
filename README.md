### ReversedFont

That code helps render reversed font.

<img src="https://raw.githubusercontent.com/frootloops/ReversedFont/master/demo.gif" width="250">


How to use:

1. Create custom NSLayoutManager
```swift
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
```
2. Create a textview and use it
```swift
private let textView: UITextView = {
        let textStorage = NSTextStorage()
        let layoutManager = TransparentLayoutManager()
        let container = NSTextContainer(size: CGSize.zero)
        container.widthTracksTextView = true
        container.heightTracksTextView = true
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)
        
        return UITextView(frame: CGRect.zero, textContainer: container)
    }()
```

