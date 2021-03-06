//
//  SLLogMacros.m
//  SuperLogger
//
//  Created by Joel Fischer on 7/30/15.
//  Copyright © 2015 livio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "SLLogMacros.h"

SpecBegin(SLLogMacrosTests)

describe(@"Macro Helpers", ^{
    describe(@"SLOG_FILE define", ^{
        it(@"should properly return a file name", ^{
            expect(SLOG_FILE).to.equal(@"SLLogMacrosTests");
        });
    });
});

describe(@"Release Macros", ^{
    describe(@"Logging with the release level macro", ^{
        xcontext(@"when the log level is at or below release", ^{
            __block id loggerControllerClassMock = OCMClassMock([SLLoggerController class]);
            beforeAll(^{
                OCMStub([[loggerControllerClassMock ignoringNonObjectArgs] logWithLevel:0 fileName:[OCMArg anyPointer] functionName:[OCMArg anyPointer] line:0 message:[OCMArg any]]);
            });
            
            it(@"should log correctly", ^{
                SLogR(@"testlog");
                OCMVerify([[loggerControllerClassMock ignoringNonObjectArgs] logWithLevel:SLLogLevelRelease fileName:SLOG_FILE functionName:SLOG_FUNC line:0 message:@"testlog"]);
            });
        });
        
        xcontext(@"when logging is off", ^{
            __block id loggerControllerClassMock = OCMClassMock([SLLoggerController class]);
            beforeAll(^{
                OCMStub([[loggerControllerClassMock ignoringNonObjectArgs] logWithLevel:0 fileName:[OCMArg anyPointer] functionName:[OCMArg anyPointer] line:0 message:[OCMArg any]]);
            });
            
            xit(@"should not log", ^{
                SLogR(@"testlog");
            });
        });
    });
});

SpecEnd
