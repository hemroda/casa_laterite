# frozen_string_literal: true

class AttachmentsController < ApplicationController
  def purge
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge
    redirect_back fallback_location: admin_root_path, notice: "Attachment deleted!"
  end
end
