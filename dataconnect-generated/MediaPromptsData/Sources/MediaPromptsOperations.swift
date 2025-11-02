import Foundation

import FirebaseCore
import FirebaseDataConnect




















// MARK: Common Enums

public enum OrderDirection: String, Codable, Sendable {
  case ASC = "ASC"
  case DESC = "DESC"
  }

public enum SearchQueryFormat: String, Codable, Sendable {
  case QUERY = "QUERY"
  case PLAIN = "PLAIN"
  case PHRASE = "PHRASE"
  case ADVANCED = "ADVANCED"
  }


// MARK: Connector Enums

// End enum definitions









public class PublishSystemMediaPromptsMutation{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "PublishSystemMediaPrompts"

  public typealias Ref = MutationRef<PublishSystemMediaPromptsMutation.Data,PublishSystemMediaPromptsMutation.Variables>

  public struct Variables: OperationVariable {

    
    
  }

  public struct Data: Decodable, Sendable {



public var 
mediaPrompt_upsertMany: [MediaPromptKey]

  }

  public func ref(
        
        ) -> MutationRef<PublishSystemMediaPromptsMutation.Data,PublishSystemMediaPromptsMutation.Variables>  {
        var variables = PublishSystemMediaPromptsMutation.Variables()
        

        let ref = dataConnect.mutation(name: "PublishSystemMediaPrompts", variables: variables, resultsDataType:PublishSystemMediaPromptsMutation.Data.self)
        return ref as MutationRef<PublishSystemMediaPromptsMutation.Data,PublishSystemMediaPromptsMutation.Variables>
   }

  @MainActor
   public func execute(
        
        ) async throws -> OperationResult<PublishSystemMediaPromptsMutation.Data> {
        var variables = PublishSystemMediaPromptsMutation.Variables()
        
        
        let ref = dataConnect.mutation(name: "PublishSystemMediaPrompts", variables: variables, resultsDataType:PublishSystemMediaPromptsMutation.Data.self)
        
        return try await ref.execute()
        
   }
}






public class AddPromptMutation{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "AddPrompt"

  public typealias Ref = MutationRef<AddPromptMutation.Data,AddPromptMutation.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
name: String

  
        
        public var
prompt: String


    
    
    
    public init (
        
name: String
,
        
prompt: String

        
        ) {
        self.name = name
        self.prompt = prompt
        

        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.name == rhs.name && 
              lhs.prompt == rhs.prompt
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(name)
  
  hasher.combine(prompt)
  
}

    enum CodingKeys: String, CodingKey {
      
      case name
      
      case prompt
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(name, forKey: .name, container: &container)
      
      
      
      try codecHelper.encode(prompt, forKey: .prompt, container: &container)
      
      
    }

  }

  public struct Data: Decodable, Sendable {



public var 
mediaPrompt_insert: MediaPromptKey

  }

  public func ref(
        
name: String
,
prompt: String

        ) -> MutationRef<AddPromptMutation.Data,AddPromptMutation.Variables>  {
        var variables = AddPromptMutation.Variables(name:name,prompt:prompt)
        

        let ref = dataConnect.mutation(name: "AddPrompt", variables: variables, resultsDataType:AddPromptMutation.Data.self)
        return ref as MutationRef<AddPromptMutation.Data,AddPromptMutation.Variables>
   }

  @MainActor
   public func execute(
        
name: String
,
prompt: String

        ) async throws -> OperationResult<AddPromptMutation.Data> {
        var variables = AddPromptMutation.Variables(name:name,prompt:prompt)
        
        
        let ref = dataConnect.mutation(name: "AddPrompt", variables: variables, resultsDataType:AddPromptMutation.Data.self)
        
        return try await ref.execute()
        
   }
}






public class DeletePromptMutation{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "DeletePrompt"

  public typealias Ref = MutationRef<DeletePromptMutation.Data,DeletePromptMutation.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
id: UUID


    
    
    
    public init (
        
id: UUID

        
        ) {
        self.id = id
        

        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.id == rhs.id
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
}

    enum CodingKeys: String, CodingKey {
      
      case id
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(id, forKey: .id, container: &container)
      
      
    }

  }

  public struct Data: Decodable, Sendable {



public var 
mediaPrompt_delete: MediaPromptKey?

  }

  public func ref(
        
id: UUID

        ) -> MutationRef<DeletePromptMutation.Data,DeletePromptMutation.Variables>  {
        var variables = DeletePromptMutation.Variables(id:id)
        

        let ref = dataConnect.mutation(name: "DeletePrompt", variables: variables, resultsDataType:DeletePromptMutation.Data.self)
        return ref as MutationRef<DeletePromptMutation.Data,DeletePromptMutation.Variables>
   }

  @MainActor
   public func execute(
        
id: UUID

        ) async throws -> OperationResult<DeletePromptMutation.Data> {
        var variables = DeletePromptMutation.Variables(id:id)
        
        
        let ref = dataConnect.mutation(name: "DeletePrompt", variables: variables, resultsDataType:DeletePromptMutation.Data.self)
        
        return try await ref.execute()
        
   }
}






public class ListMediaPromptsQuery{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "ListMediaPrompts"

  public typealias Ref = QueryRefObservation<ListMediaPromptsQuery.Data,ListMediaPromptsQuery.Variables>

  public struct Variables: OperationVariable {

    
    
  }

  public struct Data: Decodable, Sendable {




public struct MediaPrompt: Decodable, Sendable ,Hashable, Equatable, Identifiable {
  


public var 
id: UUID



public var 
name: String



public var 
prompt: String



public var 
createdBy: String



public var 
attributedTo: String?



public var 
attributionURL: String?


  
  public var mediaPromptKey: MediaPromptKey {
    return MediaPromptKey(
      
      id: id
    )
  }

  
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
}
public static func == (lhs: MediaPrompt, rhs: MediaPrompt) -> Bool {
    
    return lhs.id == rhs.id 
        
  }

  

  
  enum CodingKeys: String, CodingKey {
    
    case id
    
    case name
    
    case prompt
    
    case createdBy
    
    case attributedTo
    
    case attributionURL
    
  }

  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()

    
    
    self.id = try codecHelper.decode(UUID.self, forKey: .id, container: &container)
    
    
    
    self.name = try codecHelper.decode(String.self, forKey: .name, container: &container)
    
    
    
    self.prompt = try codecHelper.decode(String.self, forKey: .prompt, container: &container)
    
    
    
    self.createdBy = try codecHelper.decode(String.self, forKey: .createdBy, container: &container)
    
    
    
    self.attributedTo = try codecHelper.decode(String?.self, forKey: .attributedTo, container: &container)
    
    
    
    self.attributionURL = try codecHelper.decode(String?.self, forKey: .attributionURL, container: &container)
    
    
  }
}
public var 
mediaPrompts: [MediaPrompt]

  }

  public func ref(
        
        ) -> QueryRefObservation<ListMediaPromptsQuery.Data,ListMediaPromptsQuery.Variables>  {
        var variables = ListMediaPromptsQuery.Variables()
        

        let ref = dataConnect.query(name: "ListMediaPrompts", variables: variables, resultsDataType:ListMediaPromptsQuery.Data.self, publisher: .observableMacro)
        return ref as! QueryRefObservation<ListMediaPromptsQuery.Data,ListMediaPromptsQuery.Variables>
   }

  @MainActor
   public func execute(
        
        ) async throws -> OperationResult<ListMediaPromptsQuery.Data> {
        var variables = ListMediaPromptsQuery.Variables()
        
        
        let ref = dataConnect.query(name: "ListMediaPrompts", variables: variables, resultsDataType:ListMediaPromptsQuery.Data.self, publisher: .observableMacro)
        
        let refCast = ref as! QueryRefObservation<ListMediaPromptsQuery.Data,ListMediaPromptsQuery.Variables>
        return try await refCast.execute()
        
   }
}


