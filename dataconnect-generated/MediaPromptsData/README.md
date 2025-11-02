This Swift package contains the generated Swift code for the connector `media-prompts`.

You can use this package by adding it as a local Swift package dependency in your project.

# Accessing the connector

Add the necessary imports

```
import FirebaseDataConnect
import MediaPromptsData

```

The connector can be accessed using the following code:

```
let connector = DataConnect.mediaPromptsConnector

```


## Connecting to the local Emulator
By default, the connector will connect to the production service.

To connect to the emulator, you can use the following code, which can be called from the `init` function of your SwiftUI app

```
connector.useEmulator()
```

# Queries

## ListMediaPromptsQuery


### Using the Query Reference
```
struct MyView: View {
   var listMediaPromptsQueryRef = DataConnect.mediaPromptsConnector.listMediaPromptsQuery.ref(...)

  var body: some View {
    VStack {
      if let data = listMediaPromptsQueryRef.data {
        // use data in View
      }
      else {
        Text("Loading...")
      }
    }
    .task {
        do {
          let _ = try await listMediaPromptsQueryRef.execute()
        } catch {
        }
      }
  }
}
```

### One-shot execute
```
DataConnect.mediaPromptsConnector.listMediaPromptsQuery.execute(...)
```


# Mutations
## PublishSystemMediaPromptsMutation
### One-shot execute
```
DataConnect.mediaPromptsConnector.publishSystemMediaPromptsMutation.execute(...)
```

## AddPromptMutation

### Variables

#### Required
```swift

let name: String = ...
let prompt: String = ...
```
 

### One-shot execute
```
DataConnect.mediaPromptsConnector.addPromptMutation.execute(...)
```

## DeletePromptMutation

### Variables

#### Required
```swift

let id: UUID = ...
```
 

### One-shot execute
```
DataConnect.mediaPromptsConnector.deletePromptMutation.execute(...)
```

