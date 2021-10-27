//
//  VehicleNewDataModel.swift
//  MFCAUDIDynamicViews
//
//  Created by MacBook Pro on 01/10/21.
//

import Foundation
// MARK: - DynamicModel
struct DynamicModel: Decodable {
    let forms: [Form]
}

// MARK: - Form
struct Form: Decodable {
    let formTitle, formID: String
    let sectionAvailable: Bool
    let submitURL: String
    let submitRequest: [SubmitRequest]
    let preFill: PreFill
    let sections: [Section]

    enum CodingKeys: String, CodingKey {
        case formTitle = "form_title"
        case formID = "form_id"
        case sectionAvailable = "section_available"
        case submitURL = "submit_url"
        case submitRequest = "submit_request"
        case preFill = "pre_fill"
        case sections
    }
}

// MARK: - PreFill
struct PreFill: Decodable {
    let request: Request
    let fields: [PreFillField]
}

// MARK: - PreFillField
struct PreFillField: Decodable {
    let objName, key, eleID: String

    enum CodingKeys: String, CodingKey {
        case objName = "obj_name"
        case key
        case eleID = "ele_id"
    }
}

// MARK: - Request
struct Request: Decodable {
    let url: String
    let method: String
    let parameters: Parameters
}

// MARK: - Parameters
struct Parameters: Decodable {
    let formID: String

    enum CodingKeys: String, CodingKey {
        case formID = "form_id"
    }
}

// MARK: - Section
struct Section: Decodable {
    let sectionName: String
    var fields: [SectionField]

    enum CodingKeys: String, CodingKey {
        case sectionName = "section_name"
        case fields
    }
}

// MARK: - SectionField
struct SectionField: Decodable {
    let displayTitle, apiKey, validationRegex, tagid: String
    let fieldType: FieldType
    var selectedValue: String
    let fieldDynamic: Bool
    let defaultValue: DefaultValue
    let maxLength, hint: String
    let fieldRequired: Bool
    let dynamicValue: DynamicValue?
    let staticValue: StaticValue?

    enum CodingKeys: String, CodingKey {
        case displayTitle = "display_title"
        case apiKey = "api_key"
        case validationRegex = "validation_regex"
        case tagid
        case fieldType = "field_type"
        case selectedValue = "selected_value"
        case fieldDynamic = "dynamic"
        case defaultValue = "default_value"
        case maxLength = "max_length"
        case hint
        case fieldRequired = "required"
        case dynamicValue = "dynamic_value"
        case staticValue = "static_value"
    }
}

enum DefaultValue: String, Decodable {
    case empty = ""
    case select = "Select"
    case update = "Update"
}

// MARK: - DynamicValue
struct DynamicValue: Decodable {
    let apiURL: String
    let type: String
    let requestValue: RequestValue
    let requestValueDynamic: [RequestValueDynamic]
    let valueType: String

    enum CodingKeys: String, CodingKey {
        case apiURL = "api_url"
        case type
        case requestValue = "request_value"
        case requestValueDynamic = "request_value_dynamic"
        case valueType = "value_type"
    }
}

// MARK: - RequestValue
struct RequestValue: Decodable {
    let requestValueFor: String

    enum CodingKeys: String, CodingKey {
        case requestValueFor = "for_"
    }
}

// MARK: - RequestValueDynamic
struct RequestValueDynamic: Decodable {
    let tagid, apiKey: String

    enum CodingKeys: String, CodingKey {
        case tagid
        case apiKey = "api_key"
    }
}

enum FieldType: String, Decodable {
    case date = "date"
    case image = "image"
    case options = "options"
    case text = "text"
}

// MARK: - StaticValue
struct StaticValue: Decodable {
    let valueType: String
    let value: [String]

    enum CodingKeys: String, CodingKey {
        case valueType = "value_type"
        case value
    }
}

// MARK: - SubmitRequest
struct SubmitRequest: Decodable {
    var key, valueFrom, selectedValue: String

    enum CodingKeys: String, CodingKey {
        case key
        case valueFrom = "value_from"
        case selectedValue = "selected_value"
    }
}
