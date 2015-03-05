//
//  Language.m
//  TownCenterProject
//
//  Created by ASAL on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Language.h"

@implementation Language

static NSBundle *bundle = nil;

+(void)initialize {
    
    NSString *language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    if(language==nil){
        
        language = [[NSLocale preferredLanguages] objectAtIndex:0];
        if ([language isEqualToString:@"ja"]) {
            language=@"ja";
        }else{
            language=@"en";
        }
    }
   [self setLanguage:language];

}

/*
 example calls:
 [Language setLanguage:@"it"];
 [Language setLanguage:@"de"];
 */

+(void)setLanguage :(NSString *) language{

    NSString *path = [[ NSBundle mainBundle ] pathForResource:language ofType:@"lproj" ];
    bundle = [NSBundle bundleWithPath:path];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:language forKey:@"language"];
    [defaults synchronize];
}

+(NSString *)get:(NSString *)key alter:(NSString *)alternate {
    return [bundle localizedStringForKey:key value:alternate table:nil];
}

@end
