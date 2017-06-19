// This source file is part of the Swift.org Server APIs open source project
//
// Copyright (c) 2017 Swift Server API project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
//

import HTTP

public class ContinueWebApp: WebAppContaining {
    public func serve(req: HTTPRequest, res: HTTPResponseWriter ) -> HTTPBodyProcessing {
        res.writeContinue(headers: HTTPHeaders([("X-foo", "bar")]))
        res.writeResponse(HTTPResponse(httpVersion: req.httpVersion,
                                       status: .ok,
                                       transferEncoding: .chunked,
                                       headers: HTTPHeaders([("X-foo2", "bar2")])))
        res.done()
        return .discardBody
    }
}
