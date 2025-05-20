//
//  TTSExample.h
//  SwitchboardiOSDemo
//
//  Created by Iván Nádor on 2025. 04. 15..
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTSExample : NSObject

- (void)createEngine;
- (void)startEngine;
- (void)stopEngine;
- (void)synthesizeText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
