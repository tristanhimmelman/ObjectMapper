//
//  Mapper.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

protocol MapperProtocol {
    class func map(mapper: Mapper, object: Self)
    init()
}

enum MappingType {
    case fromJSON
    case toJSON
}

class Mapper {
    
    var JSON: [String : AnyObject] = [:]
    var currentValue: AnyObject?
    var currentKey: String?
    var mappingType: MappingType = .fromJSON
    
    init(){
        
    }
    
    // Sets the current mapper value and key 
    subscript(key: String) -> Mapper {
        get {
            currentKey = key
            currentValue = valueFor(key)
            
            return self
        }
        set {}
    }
    
    // fetch value from JSON dictionary
    func valueFor<N>(key: String) -> N? {
        return (JSON[key] as? N)
    }
    
    // map a JSON string to an object that conforms to MapperProtocol
    func map<N: MapperProtocol>(JSON: String, to type: N.Type) -> N {
        return map(Parser.stringToDictionary(JSON), to: type)
    }
    
    // maps a JSON dictionary to an object that conforms to MapperProtocol
    func map<N: MapperProtocol>(JSON: [String : AnyObject], to type: N.Type) -> N {
        mappingType = .fromJSON

        self.JSON = JSON
        
        var object = N()

        N.map(self, object: object)
        
        return object
    }
    
    // maps a JSON dictonary to a passed object that conforms to MapperProtocol
    func map<N: MapperProtocol>(JSON: String, to object: N) -> N {
        mappingType = .fromJSON

        self.JSON = Parser.stringToDictionary(JSON)
        
        N.map(self, object: object)
        
        return object
    }
    
    // maps an Object to a JSON dictionary <String : AnyObject>
    func toJSON<N: MapperProtocol>(object: N) -> [String : AnyObject] {
        mappingType = .toJSON
        
        self.JSON = [String : AnyObject]()
        N.map(self, object: object)
        
        return self.JSON
    }
}
