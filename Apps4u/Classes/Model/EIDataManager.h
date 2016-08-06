//
//  EIDataManager.h
//  Apps4u
//
//  Created by Евгений Иванов on 05.08.16.
//  Copyright © 2016 Евгений Иванов. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RLMResults;
@class EIGroup;

@interface EIDataManager : NSObject

+ (EIDataManager *)sharedManager;

- (void)generateGroupsWithStudents;
- (NSArray *)getGroupsArray;
- (RLMResults *)getStudentsForGroup:(EIGroup *)group withFilterString:(NSString *)filterString;
- (RLMResults *)getStudentsWithFilterString:(NSString *)filterString;

@end
