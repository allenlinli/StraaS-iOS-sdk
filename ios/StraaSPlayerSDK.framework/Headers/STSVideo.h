//
//  STSVideos.h
//  StraaS
//
//  Created by Lee on 6/27/16.
//
//

#import <StraaSCoreSDK/LHDataObject.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Video model of StraaS player SDK
 */
@interface STSVideo : LHDataObject

/**
 *  The video id.
 */
@property (nonatomic, readonly) NSString * videoId;

/**
 *  The id of the account which the resource belongs to.
 */
@property (nonatomic, readonly) NSString * accountId;

/**
 *  The video title.
 */
@property (nonatomic, readonly) NSString * title;

/**
 *  The video synopsis.
 */
@property (nonatomic, readonly) NSString * synopsis;

/**
 *  The video transcoding status.
 */
@property (nonatomic, readonly) BOOL accomplished;

/**
 *  The duration of the video.
 */
@property (nonatomic, readonly) NSNumber * duration;

/**
 *  The large size thumbnail of thumbnail_urls.
 */
@property (nonatomic, readonly) NSString * posterUrl;

/**
 *  The id of the live event that the video is generated by.
 *  If a video is generated by a live event, it would have a corresponding live id.
 *  If a video is generated by uploading, liveId would be nil;
 */
@property (nonatomic, readonly, nullable) NSString * liveId;

/**
 *  Indicate if the source is 360-degree streaming or not.
 *  "equirectangular" if the source is 360-degree streaming. "flat" if not.
 */
@property (nonatomic, readonly) NSString * projection;

/**
 *  The total views count.
 *  This property is deprecated. Use `playCountSum` instead.
 */
@property (nonatomic, readonly) NSNumber * viewsCount __attribute__((deprecated("Use playCountSum instead.")));

/**
 *  The total viewers count.
 *  This property is deprecated and will be removed in a feature release.
 */
@property (nonatomic, readonly) NSNumber * viewersCount __attribute__((deprecated("This property will be removed in a feature release.")));

/**
 *  The total watched duration.
 *  This property is deprecated. Use `playDurationSum` instead.
 */
@property (nonatomic, readonly) NSNumber * timeWatched __attribute__((deprecated("Use playDurationSum instead.")));

/**
 *  The sum of number of times the media (Live or VOD) played.
 */
@property (nonatomic, readonly) NSNumber * playCountSum;

/**
 *  The play count inherited from related media.
 */
@property (nonatomic, readonly) NSNumber * basePlayCount;

/**
 *  The sum of play duration of the media (Live or VOD) in seconds.
 */
@property (nonatomic, readonly) NSNumber * playDurationSum;

/**
 *  The play duration inherited from related media.
 */
@property (nonatomic, readonly) NSNumber * basePlayDuration;

/**
 *  The sum of number of times the media (Live or VOD) hit.
 */
@property (nonatomic, readonly) NSNumber * hitCountSum;

/**
 *  The hit count inherited from related media.
 */
@property (nonatomic, readonly) NSNumber * baseHitCount;

@end
NS_ASSUME_NONNULL_END
