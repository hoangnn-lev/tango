//
//  Translate.h
//  tango
//
//  Created by Hoang on 10/19/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//
@import AVFoundation;

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "Reachability.h"

@interface Translate : UIViewController<UIAlertViewDelegate>
@property (nonatomic, retain) AVAudioPlayer *myAudioPlayer;
@property (weak, nonatomic) IBOutlet UISegmentedControl *FromLanguage;
@property (weak, nonatomic) IBOutlet UITextView *InputText;
@property (weak, nonatomic) IBOutlet UIButton *btnTranslate;
@property (nonatomic) Reachability *internetReachability;

@end
