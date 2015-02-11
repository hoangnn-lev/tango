//
//  Translate.m
//  tango
//
//  Created by Hoang on 10/19/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import "Translate.h"
#import "FGTranslator.h"

static NSString *const GOOGLE_API_KEY = @"AIzaSyBUPWCNU_fW5BQ-MgQUAD5m0RUEU_G_FyU";
static NSString *const BING_CLIENT_ID = @"jp_leverages_tango_bing";
static NSString *const BING_CLIENT_SECRET = @"VU35ecqSJVSsWjjH+BEvuHII3SB480ZO0JCNaJc8kgw=";

@implementation Translate{
    NSString *translateTextResult;
    NSString *current_language;
    NSString *translate_language;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = [Language get:@"Translate" alter:nil];
    NSString *language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    if (![current_language isEqualToString:language]) {
        current_language = language;
        translate_language = language;
        self.InputText.text = [Language get:@"Type some text..." alter:nil];
        self.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_full_1.png",language]];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.play.hidden = YES;
    
    self.InputText.text = [Language get:@"Type some text..." alter:nil];
    self.InputText.delegate = self;
    
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexBarButton, doneButton, nil]];
    self.InputText.inputAccessoryView = keyboardDoneButtonView;
    
    [FGTranslator flushCache];
    [FGTranslator flushCredentials];
    [self.loading stopAnimating];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChangeLanguage:)];
    self.changeLanguage.userInteractionEnabled  =YES;
    [self.changeLanguage addGestureRecognizer:singleTap];
    translate_language = current_language;
}

-(void) clickChangeLanguage:(UIPinchGestureRecognizer *)sender{
    [self switchLanguage];
    self.InputText.text = @"";
    self.result.text = @"";
}

-(void) switchLanguage{
    if ([translate_language isEqualToString:@"en"]) {
        translate_language = @"ja";
        self.changeLanguage.image = [UIImage imageNamed:@"ja_full_1"];
    }else{
        translate_language = @"en";
        self.changeLanguage.image = [UIImage imageNamed:@"en_full_1"];
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)showErrorWithError:(NSError *)error
{
    NSLog(@"FGTranslator failed with error: %@", error);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:error.localizedDescription
                                                   delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void) speech:(NSString *)text name:(NSString *)name{
    NSString *userAgent = @"Mozilla/5.0";
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *foofile = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", name]];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
    if (!fileExists) {
        
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://www.translate.google.com/translate_tts?tl=vi&q=%@.", text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
        NSURLResponse* response = nil;
        NSError* error = nil;
        NSData* data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        [data writeToFile:foofile atomically:YES];
    }
    
    SystemSoundID soundID;
    NSURL *urls = [NSURL fileURLWithPath:foofile];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)urls, &soundID);
    AudioServicesPlaySystemSound (soundID);
}

- (IBAction)play:(id)sender {
    [self speech:translateTextResult name:translateTextResult];
}

- (IBAction)clearText:(id)sender {
    self.InputText.text = @"";
    self.result.text = @"";
    self.play.hidden = YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if(buttonIndex == 1) {
        [self speech:translateTextResult name:translateTextResult];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if ([textView.text isEqualToString:[Language get:@"Type some text..." alter:nil]]) {
        textView.text = @"";
        
        textView.textColor = [UIColor whiteColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = [Language get:@"Type some text..." alter:nil];
        textView.textColor = [UIColor lightTextColor]; //optional
    }
    [textView resignFirstResponder];
}

- (IBAction)doneClicked:(id)sender
{
    [self.view endEditing:YES];
    self.play.hidden = YES;
    translateTextResult = @"";
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        UIAlertView *objalert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please check network" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        objalert.delegate = self;
        [objalert show];
    }else if(![self.InputText.text isEqualToString:@""] && ![self.InputText.text isEqualToString:[Language get:@"Type some text..." alter:nil]]){
        
        
        [self.loading startAnimating];
        FGTranslator *translator;
        
        // using Google Translate
        //translator = [[FGTranslator alloc] initWithGoogleAPIKey:GOOGLE_API_KEY];
        
        // using Bing Translate
        translator = [[FGTranslator alloc] initWithBingAzureClientId:BING_CLIENT_ID secret:BING_CLIENT_SECRET];
        
        
        [translator translateText:self.InputText.text withSource:translate_language target:@"vi" completion:^(NSError *error, NSString *translated, NSString *sourceLanguage){
            
            if (error)
            {
                [self showErrorWithError:error];
                [self.loading stopAnimating];
            }
            else
            {
                [self.loading stopAnimating];
                translateTextResult = translated;
                self.result.text = translated;
                self.result.numberOfLines = 10;
                [self.result sizeToFit];
                self.play.hidden = NO;
            }
        }];
    }
}

@end
