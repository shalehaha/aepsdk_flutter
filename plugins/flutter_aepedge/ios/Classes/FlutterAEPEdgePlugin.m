/*
Copyright 2022 Adobe. All rights reserved.
This file is licensed to you under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License. You may obtain a copy
of the License at http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under
the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
OF ANY KIND, either express or implied. See the License for the specific language
governing permissions and limitations under the License.
*/

@import AEPEdge;
@import AEPCore;
@import Foundation;
#import "FlutterAEPEdgePlugin.h"
#import "FlutterAEPEdgeDataBridge.h"

@implementation FlutterAEPEdgePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_aepedge"
            binaryMessenger:[registrar messenger]];
  FlutterAEPEdgePlugin* instance = [[FlutterAEPEdgePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"extensionVersion" isEqualToString:call.method]) {
      result([AEPMobileEdge extensionVersion]);
  } else if ([@"sendEvent" isEqualToString:call.method]) {
     [self handleSendEvent:call result:result];
  } else {
      result(FlutterMethodNotImplemented);
  }
}
    
- (void)handleSendEvent:(FlutterMethodCall *) call result:(FlutterResult)result {
    NSDictionary *experienceEventDict = (NSDictionary *) call.arguments;
    AEPExperienceEvent *experienceEvent = [FlutterAEPEdgeDataBridge experienceEventFromDictionary:experienceEventDict];
    NSString* eventExperienceError = @"Dispatch Experience Event failed because experience event is null.";
    if (!experienceEvent) {
        NSLog(@"FlutterAEPEdgePlugin - %@", eventExperienceError);
        return;
    }
    
    [AEPMobileEdge sendExperienceEvent:experienceEvent completion:^(NSArray<AEPEdgeEventHandle *> * _Nonnull handles) {
        result([FlutterAEPEdgeDataBridge dictionaryFromEdgeEventHandler:handles]);
    }];
    }
@end
