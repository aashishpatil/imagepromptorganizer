## **Nano Banana Image Generator: SwiftUI & Firebase Integration 🖼️**

This repository hosts an **iOS SwiftUI application** that provides a user interface for **saving, viewing, and replaying** image generation prompts using the Gemini API.

The application leverages [Firebase](https://firebase.google.com/products-build) services:

* **Firebase AI SDK (Gemini Nano Banana API):** For **image generation** based on user prompts.  
* **Firebase Data Connect:** For **persistent storage and retrieval** of user-saved prompts, allowing for easy replay.  
* **Firebase Authentication with Google Sign-in**.

![Demo](PromptsOrganizerMovie.gif)

---

## **🛠️ Project Setup and Configuration**

To build and run this project, you must first configure the dependencies and integrate your Firebase project.

### **1\. Prerequisites and Repository Setup**

**Clone the repository:**  
```
git clone https://github.com/aashishpatil/imagepromptorganizer.git  
cd imagepromptorganizer
```
  
* **Configure the Xcode Project:**  
  * Update the **Bundle Identifier** to a unique value.  
  * Configure **App Signing** to use your developer account and profile.

### **2\. Firebase Project Integration**

The application requires a Firebase project with specific services enabled:

* **Create a Firebase Project** in the [Firebase Console](https://console.firebase.google.com/)  
* **Enable Services:**  
  * **Authentication:** Enable **Google Sign-In** as a sign-in provider.  
  * **Firebase AI:** Enable **Gemini Developer API**.  
  * **Firebase Data Connect:** Activate Data Connect for the project.

---

### **3\. Integrating Firebase Data Connect**

This repository includes a pre-configured Data Connect project structure (schema, queries, and supporting files). To utilize it:

* **Install the [Firebase Data Connect iOS SDK](https://github.com/firebase/data-connect-ios-sdk) :** Follow the **"Getting Started"** guide to integrate the Data Connect SDK into your Xcode project.  
* **Generated Data Connect Client Code:** The included project already contains schema, queries and generated Swift code for that schema. 

---

### **4\. Replacing Placeholder Files**

Several placeholder files must be rseplaced or updated with configuration specific to your Firebase project:

| File Name | Required Action | Source/Details |
| :---- | :---- | :---- |
| **GoogleService-Info.plist** | **Download and Replace** | Download this file from the **Firebase Console** for your iOS app configuration and place it in the project root. |
| **.firebaserc** | **Update Project ID** | Edit this file to ensure the **"projects": { "default": "..." }** field matches your Firebase Project ID. |
| **Info.plist** | **Update Bundle ID** | Verify or update the relevant entries (e.g., related to Google Sign-In or bundle references) to match your new App Bundle Identifier. |
