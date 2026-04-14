---
name: flutter-delivery-domain
description: Domain knowledge for shipperbee_delivery: Hive storage, Firebase (Auth, Messaging, Remote Config, Crashlytics), SignalR real-time updates, delivery flows (pickup, POD upload, parcel transfer). Use when working on delivery features, local storage, push notifications, or real-time updates.
---

# Flutter Delivery Domain

## Storage

### Hive
- **HiveDb** (`util/hive_storage/hive_db.dart`): Singleton managing boxes for parcels, pickups, routes, locations, delivery notes, pins
- **Boxes**: parcelHiveBox, pickupParcelHiveBox, routeHiveBox, locationHiveBox, deliveryNoteBox, offloadPinBox, scanOutForDeliveryPinBox, etc.
- **Adapters**: Register in `mainDelegate()` before `HiveDb.instance.initBoxes()`
- **Constants**: `HiveConstants` defines type IDs and box names

### Secure Storage
- **SBSecureStorage** (`util/secure_storage/secure_storage.dart`): Encrypted storage for tokens, user data
- Use for auth tokens, sensitive config

## Firebase
- **Auth**: Firebase Auth for login; `AuthenticationService`, `ApiAuthenticationService`
- **Messaging**: FCM for push; `NotificationServiceManager` handles inbound notifications
- **Remote Config**: Force app updates; `RemoteConfigService`
- **Crashlytics**: Error reporting; disabled in debug

## Real-time
- **SignalR** (`signalr_core`): Real-time hub connection for live updates
- **NotificationServiceManager**: Handles parcel assignments, delivery acceptance, consignee details, recalls, intercepts

## Delivery Flows
- **Pickup**: Scan, assign, complete; `PickupRepository`, `PickupService`
- **POD upload**: Proof of delivery; `UploadPodService`, signature capture
- **Parcel transfer**: Driver-to-driver; `TransferParcelsPage`, `driver_transfer_parcel`
- **Routes**: `RouteRepository`, `HiveDb.getRouteBox()`

## DI
- **GetIt** (`setupLocator()`): Non-context services
- **Provider**: Context-based UI state
