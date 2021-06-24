# CHAIWALA420 though sounds debatable :stuck_out_tongue_winking_eye: , is a simple app using flutter and firebase.
`Chaiwala420 is an app that allows users of a team or gang to store thier beverage preferrences and use that to order online beverages in bulk for their evening snacks or mini parties`

## Flutter firebase setup:

* Create firebase account
* Create a new project
* Setup  app for android
* Provide the package name from `android > app > build.gradle > applicationId` in the register app.
* Provide a nickname and register app
* Download the `google-service.json`. `This service file is an identifier that will tell the project which backend to connect to on firebase`
* Paste the `google-service.json` inside `android > app`
* Add firebase sdk in your flutter project 
    * Copy the dependency classpath `classpath 'com.google.gms:google-services:4.0.1'` and paste it in `android > build.gradle > dependencies`
    * Copy the plugin `apply plugin: 'com.google.gms.google-services'` from App-lelve build.gradle and paste it in `android > app > build.gradle`

### To enable authentication in firebase
* Select authentication and get started
* Enable the service you want for authentication
