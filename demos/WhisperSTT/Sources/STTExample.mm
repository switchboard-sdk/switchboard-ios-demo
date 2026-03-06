#import "STTExample.h"

#include <switchboard/Switchboard.hpp>

using namespace switchboard;

@implementation STTExample {
    std::string engineID;
}

- (void)createEngine {
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"STTExample" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"Error reading JSON file: %@", error.localizedDescription);
    }

    const char* config = [jsonString UTF8String];
    Result<Switchboard::ObjectID> result = Switchboard::createEngine(std::string(config));
    if (result.isError()) {
        return;
    }
    engineID = result.value();

    Switchboard::addEventListener("vadNode", "speechStarted", [](const Event& event) {
        NSLog(@"STT - vadNode start");
    });

    Switchboard::addEventListener("vadNode", "speechEnded", [](const Event& event) {
        NSLog(@"STT - vadNode end");
    });

    STTExample* __weak weakSelf = self;
    Switchboard::addEventListener("sttNode", "transcribed", [weakSelf](const Event& event) {
        const auto params = SBAny::convert<SBAnyMap>(event.data);
        const auto text = SBAny::convert<std::string>(params.at("text"));
        NSString* textString = [NSString stringWithUTF8String:text.c_str()];
        NSLog(@"STT - transcribed: %@", textString);
        if (weakSelf.delegate) {
            [weakSelf.delegate transcribedText:textString];
        }
    });
}

- (void)startEngine {
    auto startEngineResult = Switchboard::callAction(engineID, "start");
    if (startEngineResult.isError()) {
        NSLog(@"Failed to start audio engine");
    }
}

- (void)stopEngine {
    auto stopEngineResult = Switchboard::callAction(engineID, "stop");
    if (stopEngineResult.isError()) {
        NSLog(@"Failed to stop audio engine");
    }
}

@end
