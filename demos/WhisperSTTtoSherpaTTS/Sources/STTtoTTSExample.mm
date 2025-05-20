#import "STTtoTTSExample.h"

#include <switchboard/SwitchboardV3.hpp>

using namespace switchboard;

@implementation STTtoTTSExample {
    std::string engineID;
}

- (void)createEngine {
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"STTtoTTSExample" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"Error reading JSON file: %@", error.localizedDescription);
    }

    const char* config = [jsonString UTF8String];
    Result<SwitchboardV3::ObjectID> result = SwitchboardV3::createEngine(std::string(config));
    if (result.isError()) {
        return;
    }
    engineID = result.value().value();

    SwitchboardV3::addEventListener("vadNode", "start", [](const std::any& data) {
        NSLog(@"STT - vadNode start");
    });

    SwitchboardV3::addEventListener("vadNode", "end", [](const std::any& data) {
        NSLog(@"STT - vadNode end");
    });

    STTtoTTSExample* __weak weakSelf = self;
    SwitchboardV3::addEventListener("sttNode", "transcription", [weakSelf](const std::any& data) {
        const auto text = Config::toString(data);
        NSString* textString = [NSString stringWithUTF8String:text.c_str()];
        NSLog(@"STT - transcribed: %@", textString);
    });
}

- (void)startEngine {
    auto startEngineResult = SwitchboardV3::callAction(engineID, "start");
    if (startEngineResult.isError()) {
        NSLog(@"Failed to start audio engine");
    }
}

- (void)stopEngine {
    auto stopEngineResult = SwitchboardV3::callAction(engineID, "stop");
    if (stopEngineResult.isError()) {
        NSLog(@"Failed to stop audio engine");
    }
}

@end
