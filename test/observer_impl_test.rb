require_relative 'test_helper'

# ObserverTest.
# @class_description
#   Tests the Observer class.
class ObserverTest < Minitest::Test

  # Constants.
  CLASS      = Observer
  ONE        = 1
  EMPTY_HASH = {}
  NILCLASS_I = nil
  TEST_SYMBOL = :test_symbol
  NODE1 = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)

  # test_conf_doc_f_ex().
  # @description
  #   The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, README.md,
  #   .yardopts, .gitignore, Changelog.md, CODE_OF_CONDUCT.md,
  #   observer_impl.gemspec, Gemfile.lock, and Rakefile files exist.
  def test_conf_doc_f_ex()

    assert_path_exists('.travis.yml')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('Gemfile')
    assert_path_exists('LICENSE.txt')
    assert_path_exists('README.md')
    assert_path_exists('.yardopts')
    assert_path_exists('.gitignore')
    assert_path_exists('Changelog.md')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('observer_impl.gemspec')
    assert_path_exists('Gemfile.lock')
    assert_path_exists('Rakefile')

  end

  # test_version_declared().
  # @description
  #   The version was declared.
  def test_version_declared()
    refute_nil(Observer::VERSION)
  end

  # setup().
  # @description
  #   Set fixtures.
  def setup()
  end

  # Observer.observable().

  # test_obs_x().
  # @description
  #   OBSERVABLE is a Set containing Node.
  def test_obs_x()

    assert_includes(Observer.observable(), Node)
    o_set = Observer.observable()
    assert_same(ONE, o_set.size())

  end

  # Observer.type(identifier = nil).

  # test_type_x1().
  # @description
  #   An identifier OBSERVABLE excluded.
  def test_type_x1()
    exclusion = Hash
    refute_operator(Observer, 'type', exclusion)
  end

  # test_type_x2().
  # @description
  #   A Node.
  def test_type_x2()
    assert_operator(Observer, 'type', Node)
  end

  # Observer.add_subject(subject = nil).

  # test_cas_x1().
  # @description
  #   An unobservable instance.
  def test_cas_x1()
    assert_raises(ArgumentError) { Observer.add_subject(EMPTY_HASH) }
  end

  # test_cas_x2().
  # @description
  #   An observable instance.
  def test_cas_x2()

    r = Observer.add_subject(NODE1)
    no_singleton = NodeObserver.instance()
    assert_operator(no_singleton, 'subject', NODE1)
    assert_nil(r)

  end

  # Observer.remove_subject(subject = nil).

  # test_crs_x1().
  # @description
  #   An unobservable instance.
  def test_crs_x1()

    assert_raises(ArgumentError) {
      Observer.remove_subject(EMPTY_HASH)
    }

  end

  # test_crs_x2().
  # @description
  #   The argument is an observable object and a subject.
  def test_crs_x2()

    Observer.add_subject(NODE1)
    r = Observer.remove_subject(NODE1)
    assert_nil(r)
    no_singleton = NodeObserver.instance()
    refute_operator(no_singleton, 'subject', NODE1)

  end

  # test_crs_x3().
  # @description
  #   The argument is an observable object, and not a subject.
  def test_crs_x3()

    assert_raises(ArgumentError, "#{NODE1} is not a subject.") {
      Observer.remove_subject(NODE1)
    }

  end

  # Observer.notify(instance = nil).

  # test_notify_x1().
  # @description
  #   The argument is not an observable instance.
  def test_notify_x1()

    assert_raises(ArgumentError,
                  "#{TEST_SYMBOL} is not an observable instance.") {
      Observer.notify(TEST_SYMBOL)
    }

  end

  # Observer.changed(instance = nil).

  # test_changed_x1().
  # @description
  #   Any object excluding observable objects.
  def test_changed_x1()
    refute_operator(Observer, 'changed', TEST_SYMBOL)
  end

  # test_changed_x2().
  # @description
  #   An observable object, and a subject.
  def test_changed_x2()
    Observer.add_subject(NODE1)
    refute_operator(Observer, 'changed', NODE1)
  end

  # test_changed_x3().
  # @description
  #   An observable object, and not a subject.
  def test_changed_x3()
    refute_operator(Observer, 'changed', NODE1)
  end

  # teardown().
  # @description
  #   Cleanup.
  def teardown()

    no_singleton = NodeObserver.instance()
    if (no_singleton.subject(NODE1))
      no_singleton.remove(NODE1)
    end

  end

end
