/*
 * Copyright 2019 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <XCTest/XCTest.h>

#import <GoogleDataTransport/GDTCORUploadPackage.h>

#import "GDTCCTLibrary/Private/GDTCCTNanopbHelpers.h"
#import "GDTCCTLibrary/Private/GDTCCTUploader.h"

#import "GDTCCTTests/Unit/Helpers/GDTCCTEventGenerator.h"
#import "GDTCCTTests/Unit/TestServer/GDTCCTTestServer.h"

@interface GDTCCTUploaderTest : XCTestCase

/** An event generator for testing. */
@property(nonatomic) GDTCCTEventGenerator *generator;

/** The local HTTP server to use for testing. */
@property(nonatomic) GDTCCTTestServer *testServer;

@end

@implementation GDTCCTUploaderTest

- (void)setUp {
  self.generator = [[GDTCCTEventGenerator alloc] initWithTarget:kGDTCORTargetCCT];
  self.testServer = [[GDTCCTTestServer alloc] init];
  [self.testServer registerLogBatchPath];
  [self.testServer start];
  XCTAssertTrue(self.testServer.isRunning);
}

- (void)tearDown {
  [super tearDown];
  [self.generator deleteGeneratedFilesFromDisk];
  [self.testServer stop];
}

- (void)testCCTUploadGivenConditions {
  NSArray<GDTCORStoredEvent *> *storedEventsA =
      [self.generator generateTheFiveConsistentStoredEvents];
  NSSet<GDTCORStoredEvent *> *storedEvents = [NSSet setWithArray:storedEventsA];

  GDTCORUploadPackage *package = [[GDTCORUploadPackage alloc] initWithTarget:kGDTCORTargetCCT];
  package.events = storedEvents;
  GDTCCTUploader *uploader = [[GDTCCTUploader alloc] init];
  uploader.testServerURL = [self.testServer.serverURL URLByAppendingPathComponent:@"logBatch"];
  __weak id weakSelf = self;
  XCTestExpectation *responseSentExpectation = [self expectationWithDescription:@"response sent"];
  self.testServer.responseCompletedBlock =
      ^(GCDWebServerRequest *_Nonnull request, GCDWebServerResponse *_Nonnull response) {
        // Redefining the self var addresses strong self capturing in the XCTAssert macros.
        id self = weakSelf;
        XCTAssertNotNil(self);
        [responseSentExpectation fulfill];
        XCTAssertEqual(response.statusCode, 200);
        XCTAssertTrue(response.hasBody);
      };
  [uploader uploadPackage:package];
  dispatch_sync(uploader.uploaderQueue, ^{
    XCTAssertNotNil(uploader.currentTask);
  });
  [self waitForExpectations:@[ responseSentExpectation ] timeout:30.0];
  dispatch_sync(uploader.uploaderQueue, ^{
    XCTAssertNil(uploader.currentTask);
  });
}

@end
