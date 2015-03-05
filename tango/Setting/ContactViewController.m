//
//  ContactViewController.m
//  tango
//
//  Created by Eastern on 2/10/15.
//  Copyright (c) 2015 Eastern. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = [Language get:@"Contact" alter:nil];
    self.navigationController.navigationBar.topItem.title = @"";
    
    
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:[Language get:@"Done" alter:nil]
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexBarButton, doneButton, nil]];
    self.email.inputAccessoryView = keyboardDoneButtonView;
    self.mail_title.inputAccessoryView = keyboardDoneButtonView;
    self.content.inputAccessoryView= keyboardDoneButtonView;
    
    self.mail_title.placeholder =[Language get:@"Title" alter:nil];
    self.email.placeholder =[Language get:@"Email" alter:nil];
    self.content.text = [Language get:@"Type some text..." alter:nil];
    self.content.delegate = self;

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5.0;
    
    UIButton *btnRight=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setImage:[UIImage imageNamed:@"ic_send_b_1.png"] forState:UIControlStateNormal];
    btnRight.frame=CGRectMake(0, 0, 24, 23);
    [btnRight addTarget:self action:@selector(sendMail:)
       forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *btnSearch=[[UIBarButtonItem alloc] initWithCustomView:btnRight];
    NSArray *rightNavigtaionBarButtonItems = @[negativeSpacer,  btnSearch];
    [self.navigationItem setRightBarButtonItems:rightNavigtaionBarButtonItems];
    
    
    self.ex_content1.text = [Language get:@"ex_content1" alter:nil];
    self.ex_content_2.text = [Language get:@"ex_content_2" alter:nil];

}

- (IBAction)doneClicked:(id)sender
{
    [self.view endEditing:YES];
}

- (void)sendMail:(UIButton *)sender{
    
    
    if([self checkValidate])
    {
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            
            mailer.mailComposeDelegate = self;
            
            [mailer setSubject:self.mail_title.text];
            
            NSArray *toRecipients = [NSArray arrayWithObjects:@"vietnam-app@leverages.jp", nil];
            [mailer setToRecipients:toRecipients];
            
            NSString *emailBody = self.content.text;
            [mailer setMessageBody:emailBody isHTML:NO];
            
            [self presentViewController:mailer animated:YES completion:nil];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[Language get:@"Notify" alter:nil]
                                                            message:[Language get:@"Mail not support" alter:nil]
                                                           delegate:nil
                                                  cancelButtonTitle:[Language get:@"Done" alter:nil]
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if ([textView.text isEqualToString:[Language get:@"Type some text..." alter:nil]]) {
        textView.text = @"";
        
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}


- (BOOL)validateEmail:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}


-(BOOL)checkValidate
{
    
    NSString *title = [self.mail_title.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceCharacterSet]];
    NSString *content = [self.content.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    
    if (![self validateEmail:[self.email text]])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[Language get:@"Notify" alter:nil] message:[Language get:@"Mail error" alter:nil] delegate:self cancelButtonTitle:[Language get:@"Done" alter:nil] otherButtonTitles:nil, nil];

        [alert show];
        return FALSE;
    }
    else if(title.length <1 )
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[Language get:@"Notify" alter:nil] message:[Language get:@"Title empty" alter:nil] delegate:self cancelButtonTitle:[Language get:@"Done" alter:nil] otherButtonTitles:nil, nil];
        
        [alert show];
        return FALSE;
    }
    else if( content.length <1 )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[Language get:@"Notify" alter:nil] message:[Language get:@"Content empty" alter:nil] delegate:self cancelButtonTitle:[Language get:@"Done" alter:nil] otherButtonTitles:nil, nil];
        
        [alert show];
        return FALSE;
    }
    return TRUE;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)hidesBottomBarWhenPushed{
    return YES;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
        [self dismissViewControllerAnimated:YES completion:nil];
}

@end
