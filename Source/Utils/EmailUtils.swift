//
//  EmailUtils.swift
//  SoraaPushTest
//
//  Created by Oleksandr Deundiak on 10/13/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

import Foundation

public class EmailUtils {
    public class func generateEmail() -> String {
        let candidate = UUID().uuidString.lowercased();
        let identityLong = candidate.replacingOccurrences(of: "-", with: "")
        let identity = identityLong.substring(to: identityLong.index(identityLong.startIndex, offsetBy: 25))
        
        return String(format: "%@@mailinator.com", identity)
    }

    public class func getConfirmationCode(emailNumber: Int = 0, identityValue: String, mailinator: VSMMailinator, timeout: TimeInterval = 40.0, completion: @escaping (String?)->()) {
        var timeoutFired = false
        
        var callbackCalled = false
        let callbackWrapper = { (code: String?) in
            guard !timeoutFired && !callbackCalled else {
                return
            }
            
            callbackCalled = true
            completion(code)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            timeoutFired = true
            callbackWrapper(nil)
        }
        
        let identityShort = identityValue.substring(to: identityValue.range(of: "@")!.lowerBound)
        
        var received = false
        let getEmail = { (mid: String, completion: @escaping (VSMEmail)->()) in
            while !received && !timeoutFired {
                sleep(5)
                guard !received && !timeoutFired else {
                    return
                }
                mailinator.getEmail(mid) { email, error in
                    guard error == nil, let email = email else {
                        return
                    }
                    
                    received = true
                    completion(email)
                }
            }
        }
        
        let metadataReceivedCallback = { (metadataList: [VSMEmailMetadata]) in
            // find last message
            let lastMetadata = metadataList.min(by: { m1, m2 in
                return m1.seconds_ago.compare(m2.seconds_ago) == .orderedAscending;
            })!
            
            getEmail(lastMetadata.mid) { email in
                let bodyPart = email.parts[0];
                
                let regexp = try! NSRegularExpression(pattern: "Your confirmation code is.+([A-Z0-9]{6})", options: .caseInsensitive)
                let matchResult = regexp.firstMatch(in: bodyPart.body, options: .reportCompletion, range: NSMakeRange(0, bodyPart.body.lengthOfBytes(using: .utf8)))
                
                let match = (bodyPart.body as NSString).substring(with: matchResult!.range)
                
                let code = String(match.characters.suffix(6))
                
                callbackWrapper(code)
            }
        }
        
        let checkInbox = { (completion: @escaping ([VSMEmailMetadata]?, Error?) -> ()) in
            mailinator.getInbox(identityShort) { metadataList, error in
                completion(metadataList, error)
            }
        }
        
        var receivedMeta = false
        while !receivedMeta && !timeoutFired {
            sleep(5)
            guard !receivedMeta && !timeoutFired else {
                return
            }
            checkInbox() { metadataList, error in
                guard error == nil, let mList = metadataList, mList.count > emailNumber else {
                    return
                }
                
                receivedMeta = true
                metadataReceivedCallback(mList)
            }
        }
    }
}
