require_relative 'test_helper'

# ObserverTest.
# @class_description
#   Tests the Observer class.
class ObserverTest < Minitest::Test

  # Constants.
  CLASS      = Observer
  ONE        = 1
  EMPTY_HASH = {}

  # test_conf_doc_f_ex().
  # @description
  #   The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, README.md,
  #   and .yardopts files exist.
  def test_conf_doc_f_ex()

    assert_path_exists('.travis.yml')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('Gemfile')
    assert_path_exists('LICENSE.txt')
    assert_path_exists('README.md')
    assert_path_exists('.yardopts')

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

    assert_raises(ArgumentError) {
      Observer.add_subject(EMPTY_HASH)
    }

  end

  # test_cas_x2().
  # @description
  #   An observable instance.
  def test_cas_x2()

    n = Minitest::Mock.new()
    n.expect(:class, Node)
    assert_raises(NameError) {
      Observer.add_subject(n)
    }

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
  #   An observable instance.
  def test_crs_x2()

    n = Minitest::Mock.new()
    n.expect(:class, Node)
    assert_raises(NameError) {
      Observer.remove_subject(n)
    }

  end

  # Observer.notify(pub_i = nil).

  # test_notify_x1().
  # @description
  #   A Node subject.
  def test_notify_x1()

    n = Minitest::Mock.new()
    n.expect(:class, Node)
    n.expect(:class, Node)
    assert_raises(NameError) {
      Observer.notify(n)
    }

  end

  # test_notify_x2().
  # @description
  #   A subject excluding a Node.
  def test_notify_x2()
    assert_nil(Observer.notify(nil))
  end

  # Observer.changed(instance = nil).

  # test_changed_x1().
  # @description
  #   A Node.
  def test_changed_x1()

    n = Minitest::Mock.new()
    n.expect(:class, Node)
    n.expect(:class, Node)
    assert_raises(NameError) {
      Observer.changed(n)
    }

  end

  # test_changed_x2().
  # @description
  #   The argument's class is not Node.
  def test_changed_x2()
    refute_operator(Observer, 'changed', nil)
  end

  # teardown().
  # @description
  #  Cleanup.
  def teardown()
  end

end
