//
//  MCTransparentWindow.h
//  Pods
//
//  Created by Matthew Cheok on 28/4/14.
//
//

#import <UIKit/UIKit.h>

@interface MCTransparentWindow : UIWindow

+ (instancetype)windowWithLevel:(UIWindowLevel)level;
- (void)setupOrientation;

@end
