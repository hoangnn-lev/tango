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

@interface Translate : UIViewController<UIAlertViewDelegate, UITextFieldDelegate>
@property (nonatomic, retain) AVAudioPlayer *myAudioPlayer;
@property (weak, nonatomic) IBOutlet UITextField *InputText;

@property (nonatomic) Reachability *internetReachability;
@property (weak, nonatomic) IBOutlet UIButton *play;
@property (weak, nonatomic) IBOutlet UIButton *clearText;
@property (weak, nonatomic) IBOutlet UIImageView *flag;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UILabel *result;
@property (weak, nonatomic) IBOutlet UIImageView *changeLanguage;

@end
