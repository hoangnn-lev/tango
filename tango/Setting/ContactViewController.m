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
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
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
    
    
    self.ex_title.text = [Language get:@"ex_title" alter:nil];
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
        NSLog(@"dasdsa");
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notify" message:@"Email invalid !" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];

        [alert show];
        return FALSE;
    }
    else if(title.length <6 )
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notify" message:@"Title short !" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"", nil];
        
        [alert show];
        return FALSE;
    }
    else if( content.length <10 )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notify" message:@"Content short !" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"", nil];
        
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


@end
