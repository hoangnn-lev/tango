//
//  ContactViewController.h
//  tango
//
//  Created by Eastern on 2/10/15.
//  Copyright (c) 2015 Eastern. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UITextField *mail_title;
@property (weak, nonatomic) IBOutlet UILabel *ex_title;
@property (weak, nonatomic) IBOutlet UILabel *ex_content1;
@property (weak, nonatomic) IBOutlet UILabel *ex_content_2;
@end
