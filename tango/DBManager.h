//
//  DBManager.h
//  Perikare
//
//  Created by Hoang on 6/15/14.
//  Copyright (c) 2014 Leverages. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject{
    NSString *databasePath;
}

+(DBManager *) getSharedInstance;
-(void) createDB;
-(NSMutableArray *) getCategory:(NSString *)query;
-(NSMutableArray *) getConversation:(NSString *)query;
-(BOOL) updateRecord:(NSString *)query;
@end
