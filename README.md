MVVMÇ (MVVM Calçot) is an implementation of MVVM influenced by VIPER. Basically VIPER with MVVM names.  
The most important concept of MVVMÇ is that implements MVVM with **immutable** ViewModels, this helps to write correct and testable code with minor complexity.  
Other than this, it introduces the concepts of `Interactor` and `Coordinator` to MVVM.

## Content

* [Components](#components)
  - [Model](#model)
  - [View](#view)
  - [ViewModel](#viewmodel)
  - [Interactor](#interactor)
  - [Coordinator](#coordinator)
* [Binding](#binding)
* [Testing](#testing)
* [Drawbacks of Immutable ViewModels](#drawbacks-of-immutable-viewmodels)
* [Contacts](#contacts)

## Components

<img src="https://i.imgur.com/Uu81WZV.jpg" width="600" />
  
### Model

`Model`s are entities that represent the data behind the business logic. In order to have immutable `ViewModel`s the model needs to be immutable as well, preferably using value types when possible.
The `Model` doesn't contain any logic as it is just the input of a `ViewModel` that transforms the model into what a `View` needs.

### View

The `View` is what the user actually see, usually a `UIView` or `UIViewController`. `View` should never have any logic but instead use whaveter comes from the `ViewModel` directly without manipulation. Because `ViewModel`s should be immutable the `View` might have to hold the state.
For example, a `UISwitch`, is already holding the state `on/off` so there is no need to replicate it in the `ViewModel` or the `Model` with the risk of inconsistencies. Then the `View` will pass the value to the `ViewModel` whenever needed.
Let's say a `ViewModel` needs to provide a `String` based on the switch value.  

Instead of:

```swift
viewModel.notificationsEnabled = notificationsSwitch.isOn
descriptionLabel.text = viewModel.description
```

You would use:

```swift
descriptionLabel.text = viewModel.description(notificationsEnabled: notificationsSwitch.isOn)
```

There are few cases where this is not possible ([Drawbacks of Immutable ViewModels](#drawbacks-of-immutable-viewmodels))

### ViewModel

The ViewModel contains all the business logic and the presentation logic. It transforms the Model into what the View should display. In MVVMÇ the goal is to have always immutable ViewModels because it makes it really easy to tests them. Given a Model you will always have the exact same output.  
The ViewModel forwards updates of the Model or other actions to the `Interactor` and forwards navigation to the `Coordinator`. The `View` never navigates or use the `Interactor` or `Coordinator` directly, but instead it delegates to the ViewModel that then dispatches it as necessary.
The [biding](#binding) between the `View` and the `Interactor` takes care of replacing the `ViewModel` whenever the `Model` changes.

Example:

```swift
struct User {
  let name: String
  let nickname: String
  ....
}

struct UserCellViewModel {
  let user: User
  
  var title: String {
    return "\(user.name) @(\(user.nickname))"
  }
  ...
}
```

### Interactor

The `Interactor` is responsible to manipulate the model, keep it in a consistent state, notify changes.
The interactor can be used, for example, to communicate with your backend to fetch the model, to update it, etc.

### Coordinator

The `Coordinator` is responsible to setup all the components of a module together and eventually to use other Coordinator's to navigate.  
It holds a weak reference to the `View` because the `View` itself is what keeps all the compents alive until the `View` is removed from the hierachy.

## Binding

The `Interactor` is binded to the `View` so that whenever the `Model` changes a new `ViewModel` is created and the `View` is reconfigured.
The `View` has a single method that given a `ViewModel` updates the whole UI (`configure(with: viewModel)`).  
This means that given the same `ViewModel` the `View` is supposed to looks exactly the same.  

## Testing

Because of immutability of the `ViewModel` and the fact that given the same `Model` the `ViewModel` is always going to behave the same way; and given the same `ViewModel` the `View` is going to look the same, we can easily test all the components.
`ViewModel` can be unit tested by using an arbitrary `Model`.
`View` can be snapshot tested by using an arbitrary `ViewModel`.
`Interactor` can be tested mocking its dependencies and veryfing its `Model`.

## Drawbacks of Immutable ViewModels

There are few cases where immutability of the `ViewModel` might not work.
One is forms that use `UITableView`, since tableView's cells are reused the state can't be kept in the `View` or it will be lost once the cell is reused. However in our experience is better to not use `UITableView` for building forms and reusing cells cause more troubles than gains, `UIStackView` is a better choice for simple forms.
Another case is with animations, this need to be solved case by case by escaping a bit from immutability.  
At Verse for example to properly animate the like button of a cell we had to keep the `liked` state of each Feed entry mutable and using callbacks to update the cell state.  
This is needed to avoid re-creating the whole `ViewModel` since it would reload the whole table.

## Contacts

MVVMÇ was initially developed by [Alex Manzella](https://twitter.com/manzopower) and [Joan Romano](https://twitter.com/joanromano).  
It was introduced at [@Verse](https://twitter.com/joinverse) and refined together with [Pol Quintana](https://twitter.com/polqf) and [Ramon Arguello](https://twitter.com/monchote).
The Verse app was completely rewritten using MVVMÇ.  
At [@Runtastic](https://twitter.com/runtastic), were the architecture was introduced, has been adopted since end of 2016.    
You might contact one of these people for any question about it.
