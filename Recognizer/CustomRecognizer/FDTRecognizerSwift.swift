//
//  FDTRecognizerSwift.swift
//  Recognizer
//
//  Created by Karol Wawrzyniak on 18/02/16.
//  Copyright © 2016 Karol Wawrzyniak. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class FDTRecognizerSwift: UIGestureRecognizer {

    var provider: FDTRecognizerProvider?

    var points: NSMutableArray!;


    override func reset() {
        self.points = nil;
        self.state = .Possible;
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)

        if (touches.count > 1) {
            self.state = .Failed;
            return;
        }

        self.points = NSMutableArray();

        let touch = touches.first
        let point = touch?.locationInView(self.view)
        let value = self.provider?.transformPoint(point!);

        self.points.addObject(value!);

    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)

        let touch = touches.first
        let point = touch?.locationInView(self.view)
        let value = self.provider?.transformPoint(point!)

        self.points.addObject(value!)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)

        if (self.points.count < 2) {
            self.state = .Failed
            return
        }
        
        let covertedPoints = FDTRecognizer.transformCGPointsToAngles(self.points! as [AnyObject]);
        let recognized = self.provider?.testForGestureWithPoints(covertedPoints);

        if recognized == true {
            self.state = .Recognized;
        } else {
            self.state = .Failed
        }

    }
}
