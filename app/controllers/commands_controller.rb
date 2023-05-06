class CommandsController < ApplicationController
  require "redis"
  layout false, except: :index
  before_action :require_login!

  def index
    @count = aylin_count
  end

  def rickroll_frame
    render partial: "rickroll_frame", locals: { submit: "Rickrollen!", reset: "" }
  end

  def rickroll
    ActionCable.server.broadcast("dns_channel", { type: "perform", target: "self", name: "rickroll" })
    render partial: "rickroll_frame", locals: { submit: "Erfolg!", reset: "reset" }
  end

  def redirect_frame
    render partial: "redirect_frame", locals: { submit: "Weiterleiten", reset: "" }
  end

  def redirect
    ActionCable.server.broadcast("dns_channel", { type: "perform", target: "self", name: "redirect", href: params[:href] })
    render partial: "redirect_frame", locals: { submit: "Erfolg!", reset: "reset" }
  end

  def redirect_all_frame
    render partial: "redirect_all_frame", locals: { submit: "Weiterleiten", reset: "" }
  end

  def redirect_all
    ActionCable.server.broadcast("dns_channel", { type: "perform", target: "all", name: "redirect-all", href: params[:href] })
    render partial: "redirect_all_frame", locals: { submit: "Erfolg!", reset: "reset" }
  end

  def change_urls_frame
    render partial: "change_urls_frame", locals: { submit: "Links ändern", reset: "" }
  end

  def change_urls
    ActionCable.server.broadcast("dns_channel", { type: "perform", target: "self", name: "change-urls", href: params[:href] })
    render partial: "change_urls_frame", locals: { submit: "Erfolg!", reset: "reset" }
  end

  def change_all_urls_frame
    render partial: "change_all_urls_frame", locals: { submit: "Links ändern", reset: "" }
  end

  def change_all_urls
    ActionCable.server.broadcast("dns_channel", { type: "perform", target: "all", name: "change-all-urls", href: params[:href] })
    render partial: "change_all_urls_frame", locals: { submit: "Erfolg!", reset: "reset" }
  end

  def change_images_frame
    render partial: "change_images_frame", locals: { submit: "Bilder ändern", reset: "" }
  end

  def change_images
    ActionCable.server.broadcast("dns_channel", { type: "perform", target: "self", name: "change-images", href: params[:href] })
    render partial: "change_images_frame", locals: { submit: "Erfolg!", reset: "reset" }
  end

  def change_all_images_frame
    render partial: "change_all_images_frame", locals: { submit: "Bilder ändern", reset: "" }
  end

  def change_all_images
    ActionCable.server.broadcast("dns_channel", { type: "perform", target: "all", name: "change-all-images", href: params[:href] })
    render partial: "change_all_images_frame", locals: { submit: "Erfolg!", reset: "reset" }
  end

  def prompt_frame
    render partial: "prompt_frame", locals: { submit: "Senden", reset: "" }
  end

  def prompt
    ActionCable.server.broadcast("dns_channel", { type: "perform", target: "self", name: params[:prompt_type], text: params[:text] })
    render partial: "prompt_frame", locals: { submit: "Erfolg!", reset: "reset" }
  end
end
