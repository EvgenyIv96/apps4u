//
//  EIGroup.h
//  Apps4u
//
//  Created by Евгений Иванов on 05.08.16.
//  Copyright © 2016 Евгений Иванов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@class EIStudent;
@protocol EIStudent;


@interface EIGroup : RLMObject

@property NSString* name;
//@property RLMArray <EIStudent>* students;
@property (readonly) RLMLinkingObjects* students;

- (instancetype)initWithName:(NSString *)name;

@end
RLM_ARRAY_TYPE(EIGroup)