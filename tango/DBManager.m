//
//  DBManager.m
//  Perikare
//
//  Created by Hoang on 6/15/14.
//  Copyright (c) 2014 Leverages. All rights reserved.
//

#import "DBManager.h"
#import "Categories.h"
#import "Conversation.h"

static DBManager *shareInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager*) getSharedInstance{
    if (!shareInstance) {
        shareInstance = [[super allocWithZone:NULL] init];
        [shareInstance createDB];
    }
    return shareInstance;
}

-(void) createDB{
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [array objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:@"sqlite.db"];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:filePath]) {
        NSString *path_backup = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/sqlite.db"];
        [manager copyItemAtPath:path_backup toPath:filePath error:nil];
    }
    databasePath = [[NSString alloc] initWithString:filePath];

}

-(NSMutableArray *) getCategory:(NSString *)query
{
    const char *dbPath = [databasePath UTF8String];
    NSMutableArray *resuluteArray = [[NSMutableArray alloc] init];
    if (sqlite3_open(dbPath, &database)==SQLITE_OK) {
        
        const char *query_stmt = [query UTF8String];
        
        if(sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL)==SQLITE_OK){
            
            while (sqlite3_step(statement)==SQLITE_ROW) {
                                
                Categories *cat = [[Categories alloc] init];
                cat.id = sqlite3_column_int(statement, 0);
                cat.name = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                [resuluteArray addObject:cat];
            }
            
        }else{
            NSLog(@" %s", sqlite3_errmsg(database));
        }
        sqlite3_reset(statement);
        
    }
    
    return resuluteArray;
}

-(NSMutableArray *) getConversation:(NSString *)query
{
    const char *dbPath = [databasePath UTF8String];
    NSMutableArray *resuluteArray = [[NSMutableArray alloc] init];
    if (sqlite3_open(dbPath, &database)==SQLITE_OK) {
        
        const char *query_stmt = [query UTF8String];
        
        if(sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL)==SQLITE_OK){
            
            while (sqlite3_step(statement)==SQLITE_ROW) {
                Conversation *conv = [[Conversation alloc] init];
                conv.id = sqlite3_column_int(statement, 0);
                conv.native_language = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                conv.second_language = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                conv.favorite = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                [resuluteArray addObject:conv];
            }
            
        }
        sqlite3_reset(statement);
        
    }
    
    return resuluteArray;
}

-(BOOL) updateRecord:(NSString *)query{
    
    const char *dbPath = [databasePath UTF8String];
    const char *updateSQL = [query UTF8String];
    
    if(sqlite3_open(dbPath, &database) == SQLITE_OK)
    {
        sqlite3_prepare_v2(database, updateSQL, -1, &statement, NULL);
        if(sqlite3_step(statement) == SQLITE_DONE){
            return  YES;
        }else{
            //  NSLog(@"%s", sqlite3_errmsg(database));
        }
        
    }
    
    return NO;
}

@end