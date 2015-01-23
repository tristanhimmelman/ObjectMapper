//
//  TransformOf.swift
//  ObjectMapper
//
//  Created by Syo Ikeda on 1/23/15.
//  Copyright (c) 2015 hearst. All rights reserved.
//

public class TransformOf<ObjectType, JSONType>: MapperTransform<ObjectType, JSONType> {
    private let fromJSON: JSONType? -> ObjectType?
    private let toJSON: ObjectType? -> JSONType?

    public init(fromJSON: JSONType? -> ObjectType?, toJSON: ObjectType? -> JSONType?) {
        self.fromJSON = fromJSON
        self.toJSON = toJSON
        super.init()
    }

    public override func transformFromJSON(value: AnyObject?) -> ObjectType? {
        return fromJSON(value as? JSONType)
    }

    public override func transformToJSON(value: ObjectType?) -> JSONType? {
        return toJSON(value)
    }
}
