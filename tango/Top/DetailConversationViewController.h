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
#import "VLDContextSheet.h"

@import AVFoundation;

@interface DetailConversationViewController : UIViewController<VLDContextSheetDelegate>
@property (nonatomic, retain) AVAudioPlayer *myAudioPlayer;
@property (weak, nonatomic) IBOutlet UITextView *firstLanguage;
@property (weak, nonatomic) IBOutlet UITextView *secondLanguage;
@property (nonatomic, retain) Conversation *conv;
@property (weak, nonatomic) IBOutlet UIButton *fav;
@property (weak, nonatomic) IBOutlet UIImageView *flag;
@property (strong, nonatomic) VLDContextSheet *contextSheet;
@end
