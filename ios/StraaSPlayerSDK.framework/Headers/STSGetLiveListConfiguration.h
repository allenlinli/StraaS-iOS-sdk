//
//  STSGetLiveListConfiguration.h
//  StraaSPlayerSDK
//
//  Created by Harry Hsu on 21/09/2017.
//  Copyright © 2017 StraaS.io. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * The configuration defines the request rules of how to get a live list.
 */
@interface STSGetLiveListConfiguration : NSObject

/**
 * Filter the items which exist in the categories.
 */
@property (nonatomic) NSArray<NSNumber *> * categoryIds;

/**
 * Filter the items which are tagged with the tag names.
 */
@property (nonatomic) NSArray<NSString *> * tags;

/**
 * Filter the items which are owned by the member.
 */
@property (nonatomic) NSString * ownerMemberId;

@end
