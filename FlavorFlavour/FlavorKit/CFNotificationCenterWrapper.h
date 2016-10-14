//
//  CFNotificationCenterWrapper.h
//  FlavorFlavour
//
//  Created by Ellen Shapiro (Work) on 10/14/16.
//  Copyright © 2016 Designated Nerd Software. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Lots of C code snatched from MMWormhole: https://github.com/mutualmobile/MMWormhole
@interface CFNotificationCenterWrapper : NSObject

/// Name of the NSNotification which will be posted when a CFNotification is recieved
FOUNDATION_EXTERN NSString * _Nonnull const CFNotificationReceived;

/// User info dictionary key for the identifier of the notification recieved.
FOUNDATION_EXTERN NSString * _Nonnull const ReceivedNotificationIdentifier;


/**
 Starts this instance listening to the darwin notification center for a given identifier

 @param identifier The identifier to listen to notifications for
 */
- (void)registerForNotificationsWithIdentifier:(nullable NSString *)identifier;


/**
 Stops this class from listening to the Darwin notification center for a given identifier

 @param identifier The identifier to stop listening to notifications for
 */
- (void)unregisterForNotificationsWithIdentifier:(nullable NSString *)identifier;


/**
 Sends a notification with the given identifier via Darwin notification center

 @param identifier The identifier to send with the notification
 */
- (void)sendNotificationForMessageWithIdentifier:(nullable NSString *)identifier;


/**
 Removes all Darwin notification center listeners - should be called to clean up when 
 anything that calls `registerForNotificationsWithIdentifier:` is dealloced/deinited.
 */
- (void)removeCFNotificationListener;

@end
