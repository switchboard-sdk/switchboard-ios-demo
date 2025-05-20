//
//  STTExample.hpp
//  SwitchboardWhisperSampleApp
//
//  Created by Balazs Kiss on 2025. 03. 27..
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol STTExampleDelegate

- (void)transcribedText:(NSString*)text;

@end

@interface STTExample : NSObject

@property (nonatomic, weak) id<STTExampleDelegate> delegate;

- (void)createEngine;
- (void)startEngine;
- (void)stopEngine;

@end

NS_ASSUME_NONNULL_END
