//
//  FDTSimpleGestureProviderSwift.swift
//  Recognizer
//
//  Created by Karol Wawrzyniak on 16/02/16.
//  Copyright © 2016 Karol Wawrzyniak. All rights reserved.
//

import UIKit


class FDTSimpleGestureProviderSwift: NSObject, FDTRecognizerProvider {

    var recognitionObject: FDTRecognitionObject

    init(fileURL: NSURL) {
        self.recognitionObject = FDTRecognitionObject.recognizerWithFileURL(fileURL)
    }

    var gestureName: String! {
        return self.recognitionObject.name;
    }
    var connectedURLString: String! {
        return self.recognitionObject.urlString;
    }
    func transformPoint(point: CGPoint) -> AnyObject! {
        return NSValue(CGPoint: point);
    }

    func testForGestureWithPoints(points: [AnyObject]!) -> Bool {
        let sampled = self.sample(points);
        let distance = self.distance(sampled);
        return distance <= 0.7;
    }

    func sample(points: NSArray!) -> NSArray {
        let sample = NSMutableArray();
        let loadedSampleCount = self.recognitionObject.angles.count;
        let c = points.count;

        for (var i = 0; i < loadedSampleCount; i++) {
            let index = max(0, c - 1) * i / (loadedSampleCount - 1);
            sample.addObject(points[index]);
        }

        return sample;
    }

    func distanceBetweenAngles(firstAngle: CGFloat, secondAngle: CGFloat) -> CGFloat {
        var phi = fabs(secondAngle - firstAngle);
        phi = fmod(phi, CGFloat(M_PI * 2));
        let distance = phi > CGFloat(M_PI) ? CGFloat(2 * M_PI) - phi : phi;
        return distance;
    }

    func distance(points: NSArray) -> CGFloat {
        var distance: CGFloat = 0.0;
        let angles = self.recognitionObject.angles;
        let minCount = min(angles.count, points.count);

        for (var i = 0; i < minCount; i++) {
            let aVal = CGFloat(angles[i].floatValue);
            let bVal = CGFloat(points[i].floatValue);
            distance += self.distanceBetweenAngles(aVal, secondAngle: bVal);
        }

        distance = fabs(distance / CGFloat(minCount));

        return distance;
    }


}
