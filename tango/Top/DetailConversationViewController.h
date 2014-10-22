//
//  DetailConversationViewController.h
//  tango
//
//  Created by Hoang on 9/24/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "Conversation.h"
@import AVFoundation;

@interface DetailConversationViewController : UIViewController
@property (nonatomic, retain) AVAudioPlayer *myAudioPlayer;
@property (weak, nonatomic) IBOutlet UILabel *secondLanguage;
@property (weak, nonatomic) IBOutlet UILabel *firstLanguage;
@property (nonatomic, retain) Conversation *conv;
@property (weak, nonatomic) IBOutlet UIButton *fav;
@end
