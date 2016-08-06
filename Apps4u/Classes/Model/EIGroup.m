//
//  EIGroup.m
//  Apps4u
//
//  Created by Евгений Иванов on 05.08.16.
//  Copyright © 2016 Евгений Иванов. All rights reserved.
//

#import "EIGroup.h"
#import "EIStudent.h"

@implementation EIGroup

- (instancetype)initWithName:(NSString *)name {
    
    self = [super init];
    
    if (self) {
        self.name = name;
    }
    
    return self;
}

+ (NSDictionary *)linkingObjectsProperties {
    return @{
             @"students": [RLMPropertyDescriptor descriptorWithClass:EIStudent.class propertyName:@"groups"],
             };
}

//- (EIStudent *)student {
//    return self.students.firstObject;
//}

@end
