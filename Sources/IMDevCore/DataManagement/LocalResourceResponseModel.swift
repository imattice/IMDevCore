//
//  LocalResourceResponseModel.swift
//  IMDevCore
//
//  Created by Ike Mattice on 1/4/25.
//

public struct LocalResourceResponseModel<T: ResponseModel>: ResponseModel {
    public let version: String
    public let content: [T]
}
