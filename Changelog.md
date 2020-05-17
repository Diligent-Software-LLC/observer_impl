# Changelog

## v0.2.0, 2020-05-17

### Added

- node_observer_impl developmental dependency.
- Test coverage.

### Edited

- 'Observer.notify(instance = nil)'. Raises an error in the case the argument
 is not an observable instance.

### Fixed

- 'Observer.changed(instance = nil' bug. In the case an unobservable object
 was argued, 'Observer.kind_observer(instance = nil)' raised an ArgumentError.

## v0.1.0, 2020-05-05

### Added

- version.rb.
- Gem Specification.
- README.md.
- 'Observer.observable()', 'Observer.changed(instance = nil)', 
'Observer.type(identifier = nil)', 'Observer.notify(pub_i = nil)', 
'Observer.add_subject(subject = nil)', 'Observer.remove_subject(subject = nil)',
 and 'Observer.kind_observer(instance = nil)'.
- Test coverage.

### Edited

- Deleted Travis CI deployment settings.

### Fixed
