//
//  EIDataManager.m
//  Apps4u
//
//  Created by Евгений Иванов on 05.08.16.
//  Copyright © 2016 Евгений Иванов. All rights reserved.
//

///Users/evgeny/Library/Developer/CoreSimulator/Devices/6293EC30-6077-4A04-8D8D-E213039BB95D/data/Containers/Data/Application/9D3C4A93-3A71-41FE-8051-4EE47DB83D3C/Documents/

#import "EIDataManager.h"
#import <Realm/Realm.h>
#import "EIGroup.h"
#import "EIStudent.h"

@interface EIDataManager ()

@property (strong, nonatomic) RLMRealm* realm;

@end


@implementation EIDataManager

+ (EIDataManager *)sharedManager {
    
    static EIDataManager* manager = nil;

        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [[self alloc] init];
            manager.realm = [RLMRealm defaultRealm];
        });
    
    return manager;
}

- (void)generateGroupsWithStudents {
    
//    [self.realm beginWriteTransaction];
//    [self.realm deleteAllObjects];
//    [self.realm commitWriteTransaction];
    
    
    [self.realm beginWriteTransaction];
    
    EIGroup* group1 = [[EIGroup alloc] initWithName:@"1st-year"];
    EIGroup* group2 = [[EIGroup alloc] initWithName:@"2nd-year"];
    EIGroup* group3 = [[EIGroup alloc] initWithName:@"3rd-year"];
    
//    [self.realm addObject:group1];
//    [self.realm addObject:group2];
//    [self.realm addObject:group3];

    NSArray* groups = [NSArray arrayWithObjects:group1, group2, group3, nil];
    
    for (int i = 0; i < 20; i++) {
        
        EIStudent* student = [EIStudent randomStudent];
        
            for (EIGroup* group in groups) {
                
                NSInteger random = arc4random() % 2;
                
                if (random) {
                    [student.groups addObject:group];
                    [self.realm addObject:student];
                }
                
            }
    }

    [self.realm commitWriteTransaction];

}

- (RLMResults *)getGroupsArray {
    
    RLMResults* groups = [EIGroup allObjects];
    
    return groups;
    
}

- (RLMResults *)getStudentsForGroup:(EIGroup *)group withFilterString:(NSString *)filterString {
    
    RLMResults* students = [EIStudent objectsWithPredicate:[NSPredicate predicateWithFormat:@"(firstName CONTAINS %@ OR lastName CONTAINS %@) AND %@ IN groups", filterString, filterString, group]];
    
    return students;
    
}

- (RLMResults *)getStudentsWithFilterString:(NSString *)filterString {
    
    RLMResults* students = [EIStudent objectsWithPredicate:[NSPredicate predicateWithFormat:@"firstName CONTAINS %@ OR lastName CONTAINS %@", filterString, filterString]];
    
    return students;

}

@end
