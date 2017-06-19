// This source file is part of the Swift.org Server APIs open source project
//
// Copyright (c) 2017 Swift Server API project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
//

import HTTP

class DiscardBodyWebApp: WebAppContaining {
    func serve(req: HTTPRequest, res: HTTPResponseWriter) -> HTTPBodyProcessing {
        res.writeResponse(HTTPResponse(httpVersion: req.httpVersion,
                                       status: .ok,
                                       transferEncoding: .chunked,
                                       headers: HTTPHeaders([("X-foo", "bar")])))
        res.done()
        return .discardBody
    }
}
