//
//  EIStudent.h
//  Lesson 35 Homework
//
//  Created by Евгений on 22.06.16.
//  Copyright © 2016 Евгений. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@class EIGroup;
@protocol EIGroup;

@interface EIStudent : RLMObject

@property NSString* firstName;
@property NSString* lastName;
@property NSDate* dateOfBirth;
@property RLMArray<EIGroup>* groups;

+ (EIStudent*)randomStudent;

@end
RLM_ARRAY_TYPE(EIStudent)