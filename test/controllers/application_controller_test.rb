require "test_helper"

class ConcreteTestController < ApplicationController
  enable_request_formats json: :json, js_or_atom: [:js, :atom]

  def test
    render text: 'ok'
  end

  def json
    respond_to do |format|
      format.html { render text: 'html' }
      format.json { render text: '{}' }
    end
  end

  def js_or_atom
    respond_to do |format|
      format.html  { render text: 'html' }
      format.js    { render text: 'javascript' }
      format.atom  { render text: 'atom' }
    end
  end
end

describe ConcreteTestController do
  def with_test_routing
    with_routing do |map|
      map.draw do
        get '/test', to: 'concrete_test#test'
        get '/test', to: 'concrete_test#json'
        get '/test', to: 'concrete_test#js_or_atom'
      end
      yield
    end
  end

  it "allows HTML or wildcard requests by default" do
    mime_types = ["text/html", "application/xhtml+xml", "*/*"]

    with_test_routing do
      mime_types.each do |type|
        @request.env['HTTP_ACCEPT'] = type
        get :test

        assert_equal 200, response.status, "mime type #{type} should be acceptable"
        assert_equal Mime::HTML, response.content_type
      end
    end
  end

  it "rejects non-HTML requests by default" do
    with_test_routing do
      [:json, :xml, :atom].each do |format|
        get :test, format: format

        assert_response :not_acceptable
      end
    end
  end

  it "allows additional formats which are explicitly enabled" do
    with_test_routing do
      get :json
      assert_response :success
      assert_equal Mime::HTML, response.content_type
      assert_equal 'html', response.body

      get :json, format: :json
      assert_response :success
      assert_equal Mime::JSON, response.content_type
      assert_equal '{}', response.body

      get :json, format: :atom
      assert_response :not_acceptable
    end
  end

  it "allows multiple formats which are explicitly enabled" do
    with_test_routing do
      get :js_or_atom
      assert_response :success
      assert_equal Mime::HTML, response.content_type
      assert_equal 'html', response.body

      get :js_or_atom, format: :js
      assert_response :success
      assert_equal Mime::JS, response.content_type
      assert_equal 'javascript', response.body

      get :js_or_atom, format: :atom
      assert_response :success
      assert_equal Mime::ATOM, response.content_type
      assert_equal 'atom', response.body

      get :js_or_atom, format: :json
      assert_response :not_acceptable
    end
  end

  it "returns an appropriate response for unrecognised/invalid request formats" do
    with_test_routing do
      get :test, format: 'atom\\'
      assert_response :not_acceptable
    end
  end
end