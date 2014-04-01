//
//  MCPanGestureRecognizer.m
//  MCAdditions
//
//  Created by Matthew Cheok on 2/10/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "MCPanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

//const static CGFloat MCPanGestureRecognizerThreshold = 4;

@implementation MCPanGestureRecognizer {
    BOOL _isDragging;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (self.state == UIGestureRecognizerStateFailed)
        return;
    if (!_isDragging) {
        CGPoint nowPoint = [[touches anyObject] locationInView:self.view];
        CGPoint prevPoint = [[touches anyObject] previousLocationInView:self.view];
        CGFloat translationX = prevPoint.x - nowPoint.x;
        CGFloat translationY = prevPoint.y - nowPoint.y;

        if (_direction == MCPanGestureRecognizerDirectionHorizontal &&
             abs(translationY) > abs(translationX)) {
            self.state = UIGestureRecognizerStateFailed;
        }
        if (_direction == MCPanGestureRecognizerDirectionVertical &&
             abs(translationX) > abs(translationY)) {
            self.state = UIGestureRecognizerStateFailed;
        }
        _isDragging = YES;
    }
}

- (void)reset {
    [super reset];
    _isDragging = NO;
}

@end
