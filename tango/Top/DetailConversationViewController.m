//
//  DetailConversationViewController.m
//  tango
//
//  Created by Hoang on 9/24/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import "DetailConversationViewController.h"
#import "DBManager.h"

@interface DetailConversationViewController (){
        NSString *current_language;
}
@end
@implementation DetailConversationViewController

@synthesize myAudioPlayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    current_language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    
    self.firstLanguage.text = self.conv.second_language;
    self.firstLanguage.numberOfLines = 0;
    [self.firstLanguage sizeToFit];

    self.secondLanguage.text = self.conv.native_language;
    self.secondLanguage.numberOfLines = 0;
    [self.secondLanguage sizeToFit];

    if ([self.conv.favorite isEqualToString:@"1"]) {
        self.fav.selected = YES;
    }
    self.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_flag_translate_1.png",current_language]];
    [self updateHistory];
}

-(void) updateHistory{
    
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];
    
    NSString *sql = [NSString stringWithFormat:@"update conversations set modified=%f  where id=%d", timeInMiliseconds,  self.conv.id];
    [[DBManager getSharedInstance] updateRecord:sql];
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSString *check_language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    if (![current_language isEqualToString:check_language]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)speak:(id)sender {
    
    [self speech:self.self.conv.second_language name:self.conv.second_language];
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

- (IBAction)fav:(id)sender {
    self.fav.selected = !self.fav.selected;
    NSString *sql = [NSString stringWithFormat:@"update conversations set favorite = '%hhd'  where id=%d", self.fav.selected, self.conv.id];
   [[DBManager getSharedInstance] updateRecord:sql];
}

- (IBAction)share:(id)sender {
    NSMutableArray *sharingItems = [NSMutableArray new];
    NSString *text = [NSString stringWithFormat:@"%@ \n %@",self.conv.native_language, self.conv.second_language] ;
    [sharingItems addObject:text];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}


@end
