// This source file is part of the Swift.org Server APIs open source project
//
// Copyright (c) 2017 Swift Server API project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
//

import HTTP

class IdentityEncodingWebApp: WebAppContaining {
    func serve(req: HTTPRequest, res: HTTPResponseWriter ) -> HTTPBodyProcessing {
        res.writeResponse(HTTPResponse(httpVersion: req.httpVersion,
                                       status: .ok,
                                       transferEncoding: .identity(contentLength: UInt("Hello, World!".lengthOfBytes(using: .utf8))),
                                       headers: HTTPHeaders([("X-foo", "bar")])))
        return .processBody { (chunk, stop) in
            switch chunk {
            case .chunk(_, let finishedProcessing):
                finishedProcessing()
            case .end:
                res.writeBody(data: "Hello, World!".data(using: .utf8)!) { _ in }
                res.done()
            default:
                stop = true /* don't call us anymore */
                res.abort()
            }
        }
    }
}
