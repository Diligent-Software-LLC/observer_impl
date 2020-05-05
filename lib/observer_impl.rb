# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative "observer_impl/version"
require 'set'
require 'node'

# Observer.
# @class_description
#   An Observer library implementation. Implements the Observer library
#   interface.
class Observer < ObserverInt

  # self.observable().
  # @description
  #   Gets OBSERVABLE.
  # @return [Set]
  #   OBSERVABLE's reference.
  def self.observable()
    return OBSERVABLE
  end

  # self.type(identifier = nil).
  # @description
  #   Predicate. Verifies an identifier is an observable identifier.
  # @param identifier [.]
  #   Any identifier.
  # @return [TrueClass, FalseClass]
  #   True in the case the identifier is an observable type. False otherwise.
  def self.type(identifier = nil)
    return observable().include?(identifier)
  end

  # self.changed(instance = nil).
  # @description
  #   Verifies an instance's state.
  # @param instance [.]
  #   Any instance.
  # @return [TrueClass, FalseClass]
  #   True in the case the argument is an observable type, it is an
  #   Observer's subject, and its state changed. False otherwise.
  def self.changed(instance = nil)

    if (!type(instance.class()))
      return false
    else

      k_o   = kind_observer(instance)
      k_o_i = k_o.instance()
      return (k_o_i.subject(instance) && k_o_i.changed(instance))

    end

  end

  # self.add_subject(subject = nil).
  # @description
  #   Adds a subject in the appropriate Observer.
  # @param subject [.]
  #   Any observable instance.
  # @return [NilClass]
  #   nil.
  def self.add_subject(subject = nil)

    k_o   = kind_observer(subject)
    k_o_i = k_o.instance()
    k_o_i.add(subject)
    return nil

  end

  # self.remove_subject(subject = nil).
  # @description
  #   Removes a subject in the appropriate Observer.
  # @param subject [.]
  #   Any observable instance.
  # @return [NilClass]
  #   nil.
  def self.remove_subject(subject = nil)

    k_o   = kind_observer(subject)
    k_o_i = k_o.instance()
    k_o_i.remove(subject)
    return nil

  end

  # self.notify(instance = nil).
  # @description
  #   Notifies the appropriate Observer kind an instance's state changed.
  # @param instance [.]
  #   An observable instance.
  # @return [NilClass]
  #   nil.
  def self.notify(instance = nil)

    ic_identifier = instance.class()
    if (type(ic_identifier))
      k_o = kind_observer(instance)
      k_o.receive_change(instance)
    end
    return nil

  end

  # self.kind_observer(instance = nil).
  # @description
  #   Gets the corresponding type's observer.
  # @param instance [.]
  #   Any observable instance.
  # @return [.]
  #   The argument's corresponding observer identifier.
  # @raise [ArgumentError]
  #   In the case the instance is not an observable instance.
  def self.kind_observer(instance = nil)

    ic_identifier = instance.class()
    case
    when ic_identifier.equal?(Node)
      return NodeObserver
    else
      raise(ArgumentError, "#{instance} is not an observable instance.")
    end

  end

  # Private Constants.
  OBSERVABLE = Set[Node].freeze()
  private_constant :OBSERVABLE

  # Private class methods.
  private_class_method :new
  private_class_method :kind_observer

end
