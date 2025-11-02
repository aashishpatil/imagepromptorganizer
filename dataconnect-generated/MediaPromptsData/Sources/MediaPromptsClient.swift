
import Foundation

import FirebaseCore
import FirebaseDataConnect








public extension DataConnect {

  static let mediaPromptsConnector: MediaPromptsConnector = {
    let dc = DataConnect.dataConnect(connectorConfig: MediaPromptsConnector.connectorConfig, callerSDKType: .generated)
    return MediaPromptsConnector(dataConnect: dc)
  }()

}

public class MediaPromptsConnector {

  let dataConnect: DataConnect

  public static let connectorConfig = ConnectorConfig(serviceId: "prompts-organizer", location: "us-central1", connector: "media-prompts")

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect

    // init operations 
    self.publishSystemMediaPromptsMutation = PublishSystemMediaPromptsMutation(dataConnect: dataConnect)
    self.addPromptMutation = AddPromptMutation(dataConnect: dataConnect)
    self.deletePromptMutation = DeletePromptMutation(dataConnect: dataConnect)
    self.listMediaPromptsQuery = ListMediaPromptsQuery(dataConnect: dataConnect)
    
  }

  public func useEmulator(host: String = DataConnect.EmulatorDefaults.host, port: Int = DataConnect.EmulatorDefaults.port) {
    self.dataConnect.useEmulator(host: host, port: port)
  }

  // MARK: Operations
public let publishSystemMediaPromptsMutation: PublishSystemMediaPromptsMutation
public let addPromptMutation: AddPromptMutation
public let deletePromptMutation: DeletePromptMutation
public let listMediaPromptsQuery: ListMediaPromptsQuery


}
