#import "TTSExample.h"

#include <switchboard/SwitchboardV3.hpp>

using namespace switchboard;

@implementation TTSExample {
    std::string engineID;
}

- (void)createEngine {
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TTSExample" ofType:@"json"];
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

- (void)synthesizeText:(NSString *)text {
    auto synthesizeResult = SwitchboardV3::callAction("sherpaTTSNode", "synthesize", { { "text", text.UTF8String } });
    if (synthesizeResult.isError()) {
        NSLog(@"Failed to synthesize text");
    }
}

@end
