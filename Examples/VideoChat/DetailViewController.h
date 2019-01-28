//
//  DetailViewController.h
//  VideoChat
//
//  Created by Luke Jang on 8/26/16.
//  Copyright © 2016 StraaS.io. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const STSPlayerServiceBasicPlayerViewKeyword;
extern NSString * const STSMessagingServiceKeyword;
extern NSString * const STSMessagingServiceCustomUIKeyword;
extern NSString * const STSMessagingServiceECommerceUIKeyword;
extern NSString * const STSStreamingServiceKeyword;
extern NSString * const STSStreamingFiltersServiceKeyword;
extern NSString * const STSCircallServiceSingleVideoCallKeyword;
extern NSString * const STSCircallServiceIPCamBroadcastingHostViewKeyword;
extern NSString * const STSCircallServiceIPCamBroadcastingViewerViewKeyword;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (nonatomic, readonly) UIViewController * contentViewController;
@end

