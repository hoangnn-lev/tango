//
//  Translate.m
//  tango
//
//  Created by Hoang on 10/19/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import "Translate.h"
#import "FGTranslator.h"
#import "SVProgressHUD.h"

static NSString *const GOOGLE_API_KEY = @"AIzaSyBUPWCNU_fW5BQ-MgQUAD5m0RUEU_G_FyU";
static NSString *const BING_CLIENT_ID = @"jp_leverages_tango_ms";
static NSString *const BING_CLIENT_SECRET = @"hCyHF7l6slstz9cK8IfKT8AQlIvQXdMJ8UoyNocn9WI=";

@implementation Translate{
    NSString *translateTextResult;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [FGTranslator flushCache];
    [FGTranslator flushCredentials];
}

- (IBAction)btnTranslate:(id)sender {
    
    translateTextResult = @"";
    NSString *language = @"en";
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];

    if(status == NotReachable)
    {
        UIAlertView *objalert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please check network" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        objalert.delegate = self;
        [objalert show];
    }else{
        
        
        [SVProgressHUD show];
        
        switch (self.FromLanguage.selectedSegmentIndex) {
            case 0:
                language = @"en";
                break;
            case 1:
                language = @"ja";
                break;
                
            default:
                break;
        }
        
        FGTranslator *translator;
        
        // using Google Translate
        //translator = [[FGTranslator alloc] initWithGoogleAPIKey:GOOGLE_API_KEY];
        
        // using Bing Translate
        translator = [[FGTranslator alloc] initWithBingAzureClientId:BING_CLIENT_ID secret:BING_CLIENT_SECRET];
        
        NSLog(@"text- %@ language %@", self.InputText.text, language);

        [translator translateText:self.InputText.text withSource:language target:@"vi" completion:^(NSError *error, NSString *translated, NSString *sourceLanguage){
            
            if (error)
            {
                [self showErrorWithError:error];
                
                [SVProgressHUD dismiss];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Translate" message:translated delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Play", nil];
                [alert show];
                [SVProgressHUD dismiss];
                translateTextResult = translated;
            }
        }];
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



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if(buttonIndex == 1) {
        NSLog(@"dasdsa");
        [self speech:translateTextResult name:translateTextResult];
    }
}

@end
