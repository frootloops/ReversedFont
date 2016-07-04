//
//  ViewController.swift
//  ReversedFont
//
//  Created by Arsen Gasparyan on 04/07/16.
//  Copyright © 2016 Arsen Gasparyan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    private let session = AVCaptureSession()
    private let imageOutput = AVCaptureStillImageOutput()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
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
    
    private let attributedText: NSAttributedString = {
        let text = "Swift is now open source!\n\n" +
            "We are excited by this new chapter in the story of Swift. After Apple unveiled the Swift programming language, it quickly became one of the fastest growing languages in history. Swift makes it easy to write software that is incredibly fast and safe by design. Now that Swift is open source, you can help make the best general purpose programming language available everywhere.\n\n" +
            "For students, learning Swift has been a great introduction to modern programming concepts and best practices. And because it is now open, their Swift skills will be able to be applied to an even broader range of platforms, from mobile devices to the desktop to the cloud.\n\n" +
        "Welcome to the Swift community. Together we are working to build a better programming language for everyone."
        
        return NSAttributedString(string: text, attributes: [NSBackgroundColorAttributeName: UIColor.blackColor(), NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.systemFontOfSize(25) ])
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clearColor()
        textView.backgroundColor = .clearColor()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .whiteColor()
        textView.backgroundColor = .clearColor()
        textView.selectable = false
        textView.editable = false
        textView.textContainerInset = UIEdgeInsetsZero
        textView.textContainer.lineFragmentPadding = 0
        textView.attributedText = attributedText
        
        
        for device in AVCaptureDevice.devices() {
            guard device.position == .Back else { continue }
            let captureDevice = device as? AVCaptureDevice
            
            do {
                let deviceInput = try AVCaptureDeviceInput(device: captureDevice) as AVCaptureInput
                session.sessionPreset = AVCaptureSessionPresetPhoto
                session.addInput(deviceInput as AVCaptureInput)
                session.addOutput(imageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: session) as AVCaptureVideoPreviewLayer
                containerView.layer.addSublayer(previewLayer)
                session.startRunning()
                
            } catch {}
        }
        
        containerView.addSubview(textView)
        textView.topAnchor.constraintEqualToAnchor(containerView.topAnchor).active = true
        textView.leadingAnchor.constraintEqualToAnchor(containerView.leadingAnchor).active = true
        textView.trailingAnchor.constraintEqualToAnchor(containerView.trailingAnchor).active = true
        textView.bottomAnchor.constraintEqualToAnchor(containerView.bottomAnchor).active = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.frame = UIScreen.mainScreen().bounds
        
    }
}

